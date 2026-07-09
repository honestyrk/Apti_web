-- 0007_admin_user_stats.sql
-- Adds an admin-only RPC that returns per-user activity stats (questions
-- attempted, accuracy, practice sessions, tests taken) across the whole
-- platform. Regular RLS on test_attempts/user_answers scopes every user
-- to their own rows only, so an admin querying those tables directly
-- would only ever see their own activity -- this SECURITY DEFINER
-- function intentionally bypasses that (after checking is_admin()) to
-- aggregate across all users for the admin dashboard.

create or replace function public.admin_list_users()
returns table (
  id uuid,
  full_name text,
  email text,
  role text,
  created_at timestamptz,
  questions_attempted bigint,
  correct_count bigint,
  accuracy_pct numeric,
  practice_sessions bigint,
  tests_taken bigint
)
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Admin privileges required';
  end if;

  return query
  select
    p.id,
    p.full_name,
    p.email,
    p.role,
    p.created_at,
    coalesce(answer_stats.questions_attempted, 0) as questions_attempted,
    coalesce(answer_stats.correct_count, 0) as correct_count,
    case
      when coalesce(answer_stats.questions_attempted, 0) > 0
        then round(100.0 * answer_stats.correct_count / answer_stats.questions_attempted, 2)
      else 0
    end as accuracy_pct,
    coalesce(attempt_stats.practice_sessions, 0) as practice_sessions,
    coalesce(attempt_stats.tests_taken, 0) as tests_taken
  from public.profiles p
  left join (
    select
      ta.user_id,
      count(*) filter (where ua.selected_option is not null) as questions_attempted,
      count(*) filter (where ua.is_correct) as correct_count
    from public.user_answers ua
    join public.test_attempts ta on ta.id = ua.attempt_id
    group by ta.user_id
  ) answer_stats on answer_stats.user_id = p.id
  left join (
    select
      user_id,
      count(*) filter (where mode = 'practice') as practice_sessions,
      count(*) filter (where mode = 'test' and status <> 'in_progress') as tests_taken
    from public.test_attempts
    group by user_id
  ) attempt_stats on attempt_stats.user_id = p.id
  order by p.created_at desc;
end;
$$;

-- Newly created functions default to EXECUTE granted to PUBLIC; revoke
-- that and grant only to authenticated (the function itself still gates
-- access to admins via is_admin()), consistent with every other RPC.
revoke all on function public.admin_list_users() from public;
grant execute on function public.admin_list_users() to authenticated;
