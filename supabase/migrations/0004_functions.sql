-- 0004_functions.sql
-- All answer-revealing reads/writes go through these SECURITY DEFINER RPCs
-- rather than direct table access. This is what lets `questions` have zero
-- direct grants: every function here explicitly checks auth.uid() ownership
-- (for attempts/answers) or is_admin() (for content management) itself,
-- since being SECURITY DEFINER means it otherwise bypasses RLS entirely.

-- ============================================================
-- Practice mode
-- ============================================================
create or replace function public.start_practice_session(p_topic_id uuid)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_attempt_id uuid;
  v_question_count int;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;

  select count(*) into v_question_count
  from public.questions where topic_id = p_topic_id and is_active = true;

  insert into public.test_attempts (
    user_id, mode, scope_type, topic_id, total_questions, duration_seconds
  ) values (
    auth.uid(), 'practice', 'topic', p_topic_id, v_question_count, null
  ) returning id into v_attempt_id;

  return v_attempt_id;
end;
$$;

create or replace function public.submit_practice_answer(
  p_attempt_id uuid,
  p_question_id uuid,
  p_selected_option char(1)
)
returns table (is_correct boolean, correct_option char(1), explanation text)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_correct char(1);
  v_explanation text;
  v_is_correct boolean;
begin
  if not exists (
    select 1 from public.test_attempts
    where id = p_attempt_id and user_id = auth.uid() and mode = 'practice'
  ) then
    raise exception 'Attempt not found or not owned by caller';
  end if;

  select q.correct_option, q.explanation into v_correct, v_explanation
  from public.questions q where q.id = p_question_id;

  if v_correct is null then
    raise exception 'Question not found';
  end if;

  v_is_correct := (v_correct = p_selected_option);

  insert into public.user_answers (attempt_id, question_id, selected_option, is_correct)
  values (p_attempt_id, p_question_id, p_selected_option, v_is_correct)
  on conflict (attempt_id, question_id)
  do update set selected_option = excluded.selected_option,
                is_correct = excluded.is_correct,
                answered_at = now();

  return query select v_is_correct, v_correct, v_explanation;
end;
$$;

-- ============================================================
-- Test mode
-- ============================================================
create or replace function public.start_test_attempt(
  p_scope_type text,
  p_topic_id uuid,
  p_branch_id uuid,
  p_category_id uuid,
  p_total_questions int,
  p_duration_seconds int
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_attempt_id uuid;
  v_question_ids uuid[];
  v_selected_count int;
begin
  if auth.uid() is null then
    raise exception 'Authentication required';
  end if;
  if p_scope_type not in ('topic', 'branch', 'category', 'full') then
    raise exception 'Invalid scope_type';
  end if;
  if p_duration_seconds is null or p_duration_seconds <= 0 then
    raise exception 'duration_seconds must be positive for test mode';
  end if;

  select array_agg(id) into v_question_ids
  from (
    select q.id
    from public.questions q
    join public.topics t on t.id = q.topic_id
    where q.is_active = true
      and (p_scope_type = 'full' or
           (p_scope_type = 'topic' and q.topic_id = p_topic_id) or
           (p_scope_type = 'branch' and t.branch_id = p_branch_id) or
           (p_scope_type = 'category' and t.category_id = p_category_id))
    order by random()
    limit p_total_questions
  ) sub;

  v_selected_count := coalesce(array_length(v_question_ids, 1), 0);
  if v_selected_count = 0 then
    raise exception 'No active questions available for the selected scope';
  end if;

  insert into public.test_attempts (
    user_id, mode, scope_type, topic_id, branch_id, category_id,
    total_questions, duration_seconds, expires_at
  ) values (
    auth.uid(), 'test', p_scope_type, p_topic_id, p_branch_id, p_category_id,
    v_selected_count, p_duration_seconds, now() + make_interval(secs => p_duration_seconds)
  ) returning id into v_attempt_id;

  insert into public.test_attempt_questions (attempt_id, question_id, order_index)
  select v_attempt_id, qid, ord - 1
  from unnest(v_question_ids) with ordinality as t(qid, ord);

  return v_attempt_id;
end;
$$;

create or replace function public.get_test_questions(p_attempt_id uuid)
returns table (
  order_index int,
  question_id uuid,
  question_text text,
  option_a text,
  option_b text,
  option_c text,
  option_d text,
  difficulty text,
  selected_option char(1)
)
language plpgsql
security definer
set search_path = public
as $$
begin
  if not exists (
    select 1 from public.test_attempts
    where id = p_attempt_id and user_id = auth.uid()
  ) then
    raise exception 'Attempt not found or not owned by caller';
  end if;

  return query
  select taq.order_index, q.id, q.question_text,
         q.option_a, q.option_b, q.option_c, q.option_d, q.difficulty,
         ua.selected_option
  from public.test_attempt_questions taq
  join public.questions q on q.id = taq.question_id
  left join public.user_answers ua
    on ua.attempt_id = taq.attempt_id and ua.question_id = taq.question_id
  where taq.attempt_id = p_attempt_id
  order by taq.order_index;
end;
$$;

create or replace function public.submit_test_answer(
  p_attempt_id uuid,
  p_question_id uuid,
  p_selected_option char(1)
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_status text;
  v_expires_at timestamptz;
begin
  select status, expires_at into v_status, v_expires_at
  from public.test_attempts
  where id = p_attempt_id and user_id = auth.uid() and mode = 'test';

  if v_status is null then
    raise exception 'Attempt not found or not owned by caller';
  end if;
  if v_status <> 'in_progress' then
    raise exception 'Attempt is no longer in progress';
  end if;
  if now() > v_expires_at then
    raise exception 'Test time has expired';
  end if;
  if not exists (
    select 1 from public.test_attempt_questions
    where attempt_id = p_attempt_id and question_id = p_question_id
  ) then
    raise exception 'Question is not part of this attempt';
  end if;

  -- is_correct is intentionally left null here (computed later at
  -- finalize_test_attempt) so mid-test answer submission never has to
  -- return or derive correctness, matching real exam conditions.
  insert into public.user_answers (attempt_id, question_id, selected_option)
  values (p_attempt_id, p_question_id, p_selected_option)
  on conflict (attempt_id, question_id)
  do update set selected_option = excluded.selected_option, answered_at = now();
end;
$$;

create or replace function public.finalize_attempt(p_attempt_id uuid, p_auto boolean default false)
returns table (score numeric, correct_count int, incorrect_count int, unanswered_count int, status text)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_mode text;
  v_total int;
  v_correct int;
  v_incorrect int;
  v_unanswered int;
  v_score numeric;
  v_status text;
begin
  select mode, total_questions into v_mode, v_total
  from public.test_attempts
  where id = p_attempt_id and user_id = auth.uid();

  if v_mode is null then
    raise exception 'Attempt not found or not owned by caller';
  end if;

  if v_mode = 'test' then
    -- Backfill is_correct for every answered question in this attempt now
    -- that the exam is over.
    update public.user_answers ua
    set is_correct = (q.correct_option = ua.selected_option)
    from public.questions q
    where ua.attempt_id = p_attempt_id
      and ua.question_id = q.id
      and ua.selected_option is not null;

    select count(*) filter (where is_correct = true),
           count(*) filter (where is_correct = false)
      into v_correct, v_incorrect
    from public.user_answers where attempt_id = p_attempt_id;

    v_unanswered := v_total - coalesce(v_correct, 0) - coalesce(v_incorrect, 0);
    v_status := case when p_auto then 'auto_submitted' else 'submitted' end;
  else
    -- Practice mode never pre-registers a fixed question set, so
    -- "total_questions" for the summary is however many were answered.
    select count(*), count(*) filter (where is_correct = true)
      into v_total, v_correct
    from public.user_answers where attempt_id = p_attempt_id;

    v_incorrect := v_total - coalesce(v_correct, 0);
    v_unanswered := 0;
    v_status := 'submitted';
  end if;

  v_score := case when v_total > 0
    then round(100.0 * coalesce(v_correct, 0) / v_total, 2)
    else 0 end;

  update public.test_attempts
  set status = v_status,
      submitted_at = now(),
      total_questions = v_total,
      correct_count = coalesce(v_correct, 0),
      incorrect_count = coalesce(v_incorrect, 0),
      unanswered_count = v_unanswered,
      score = v_score
  where id = p_attempt_id;

  return query select v_score, coalesce(v_correct, 0), coalesce(v_incorrect, 0), v_unanswered, v_status;
end;
$$;

create or replace function public.get_attempt_review(p_attempt_id uuid)
returns table (
  order_index int,
  question_id uuid,
  question_text text,
  option_a text,
  option_b text,
  option_c text,
  option_d text,
  correct_option char(1),
  explanation text,
  selected_option char(1),
  is_correct boolean
)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_status text;
  v_mode text;
begin
  select status, mode into v_status, v_mode
  from public.test_attempts
  where id = p_attempt_id and user_id = auth.uid();

  if v_status is null then
    raise exception 'Attempt not found or not owned by caller';
  end if;
  if v_status = 'in_progress' then
    raise exception 'Attempt is still in progress; finalize it before reviewing';
  end if;

  if v_mode = 'test' then
    return query
    select taq.order_index, q.id, q.question_text,
           q.option_a, q.option_b, q.option_c, q.option_d,
           q.correct_option, q.explanation,
           ua.selected_option, ua.is_correct
    from public.test_attempt_questions taq
    join public.questions q on q.id = taq.question_id
    left join public.user_answers ua
      on ua.attempt_id = taq.attempt_id and ua.question_id = taq.question_id
    where taq.attempt_id = p_attempt_id
    order by taq.order_index;
  else
    return query
    select row_number() over (order by ua.answered_at)::int - 1, q.id, q.question_text,
           q.option_a, q.option_b, q.option_c, q.option_d,
           q.correct_option, q.explanation,
           ua.selected_option, ua.is_correct
    from public.user_answers ua
    join public.questions q on q.id = ua.question_id
    where ua.attempt_id = p_attempt_id
    order by ua.answered_at;
  end if;
end;
$$;

-- ============================================================
-- Admin: question CRUD (base `questions` table has no direct grants, so
-- even admins must go through these SECURITY DEFINER RPCs, each of which
-- checks is_admin() itself).
-- ============================================================
create or replace function public.admin_list_questions(
  p_topic_id uuid default null,
  p_search text default null,
  p_limit int default 50,
  p_offset int default 0
)
returns table (
  id uuid, topic_id uuid, topic_name text, question_text text,
  option_a text, option_b text, option_c text, option_d text,
  correct_option char(1), explanation text, difficulty text,
  is_active boolean, created_at timestamptz
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
  select q.id, q.topic_id, t.name, q.question_text,
         q.option_a, q.option_b, q.option_c, q.option_d,
         q.correct_option, q.explanation, q.difficulty,
         q.is_active, q.created_at
  from public.questions q
  join public.topics t on t.id = q.topic_id
  where (p_topic_id is null or q.topic_id = p_topic_id)
    and (p_search is null or q.question_text ilike '%' || p_search || '%')
  order by q.created_at desc
  limit p_limit offset p_offset;
end;
$$;

create or replace function public.admin_get_question(p_id uuid)
returns table (
  id uuid, topic_id uuid, question_text text,
  option_a text, option_b text, option_c text, option_d text,
  correct_option char(1), explanation text, difficulty text, is_active boolean
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
  select q.id, q.topic_id, q.question_text,
         q.option_a, q.option_b, q.option_c, q.option_d,
         q.correct_option, q.explanation, q.difficulty, q.is_active
  from public.questions q where q.id = p_id;
end;
$$;

create or replace function public.admin_create_question(
  p_topic_id uuid, p_question_text text,
  p_option_a text, p_option_b text, p_option_c text, p_option_d text,
  p_correct_option char(1), p_explanation text, p_difficulty text default 'medium'
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_id uuid;
begin
  if not public.is_admin() then
    raise exception 'Admin privileges required';
  end if;

  insert into public.questions (
    topic_id, question_text, option_a, option_b, option_c, option_d,
    correct_option, explanation, difficulty, created_by
  ) values (
    p_topic_id, p_question_text, p_option_a, p_option_b, p_option_c, p_option_d,
    p_correct_option, p_explanation, p_difficulty, auth.uid()
  ) returning id into v_id;

  return v_id;
end;
$$;

create or replace function public.admin_update_question(
  p_id uuid, p_topic_id uuid, p_question_text text,
  p_option_a text, p_option_b text, p_option_c text, p_option_d text,
  p_correct_option char(1), p_explanation text, p_difficulty text, p_is_active boolean
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Admin privileges required';
  end if;

  update public.questions set
    topic_id = p_topic_id,
    question_text = p_question_text,
    option_a = p_option_a, option_b = p_option_b,
    option_c = p_option_c, option_d = p_option_d,
    correct_option = p_correct_option,
    explanation = p_explanation,
    difficulty = p_difficulty,
    is_active = p_is_active
  where id = p_id;
end;
$$;

-- Soft-delete only: sets is_active = false rather than removing the row, so
-- past attempts/answers referencing this question keep working in history
-- and review screens.
create or replace function public.admin_delete_question(p_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Admin privileges required';
  end if;

  update public.questions set is_active = false where id = p_id;
end;
$$;

-- ============================================================
-- Execute grants: authenticated only. Every function above independently
-- enforces auth.uid()/is_admin() checks, but revoking anon execute keeps
-- unauthenticated callers from reaching these RPCs at all.
-- ============================================================
revoke execute on all functions in schema public from public;
grant execute on function public.start_practice_session(uuid) to authenticated;
grant execute on function public.submit_practice_answer(uuid, uuid, char) to authenticated;
grant execute on function public.start_test_attempt(text, uuid, uuid, uuid, int, int) to authenticated;
grant execute on function public.get_test_questions(uuid) to authenticated;
grant execute on function public.submit_test_answer(uuid, uuid, char) to authenticated;
grant execute on function public.finalize_attempt(uuid, boolean) to authenticated;
grant execute on function public.get_attempt_review(uuid) to authenticated;
grant execute on function public.admin_list_questions(uuid, text, int, int) to authenticated;
grant execute on function public.admin_get_question(uuid) to authenticated;
grant execute on function public.admin_create_question(uuid, text, text, text, text, text, char, text, text) to authenticated;
grant execute on function public.admin_update_question(uuid, uuid, text, text, text, text, text, char, text, text, boolean) to authenticated;
grant execute on function public.admin_delete_question(uuid) to authenticated;
grant execute on function public.is_admin() to authenticated;
