-- 0002_rls_policies.sql
-- Row Level Security for every table, plus the admin-check helper and the
-- role-escalation guard trigger on profiles.

-- ============================================================
-- is_admin(): SECURITY DEFINER so it bypasses RLS on profiles internally.
-- Without this, a policy like
--   using (exists (select 1 from profiles where id = auth.uid() and role = 'admin'))
-- placed directly on profiles' own policy would recurse infinitely (the
-- policy queries profiles, which re-triggers the policy). Every admin check
-- in this file goes through this function instead of an inline subquery.
-- ============================================================
create or replace function public.is_admin()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1 from public.profiles where id = auth.uid() and role = 'admin'
  );
$$;

-- ============================================================
-- profiles
-- ============================================================
alter table public.profiles enable row level security;

create policy "profiles_select_own_or_admin"
  on public.profiles for select
  using (auth.uid() = id or public.is_admin());

create policy "profiles_update_own_or_admin"
  on public.profiles for update
  using (auth.uid() = id or public.is_admin())
  with check (auth.uid() = id or public.is_admin());

-- Row inserts happen only via the handle_new_user trigger (security definer,
-- bypasses RLS), so no INSERT policy is granted to end users.
-- No DELETE policy is granted at all (accounts are removed via auth.users cascade).

-- A user can update their own row (e.g. full_name) but must not be able to
-- promote themselves to admin. RLS's WITH CHECK can't easily express
-- "this column may only change if X" against the old row, so a trigger
-- compares OLD vs NEW here instead.
create or replace function public.guard_profile_role_change()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.role is distinct from old.role and not public.is_admin() then
    raise exception 'Only admins may change profile roles';
  end if;
  return new;
end;
$$;

create trigger trg_guard_profile_role_change
  before update on public.profiles
  for each row execute function public.guard_profile_role_change();

-- ============================================================
-- categories / branches / topics: public read, admin write
-- ============================================================
alter table public.categories enable row level security;
alter table public.branches enable row level security;
alter table public.topics enable row level security;

create policy "categories_select_all" on public.categories for select using (true);
create policy "categories_admin_write" on public.categories for all
  using (public.is_admin()) with check (public.is_admin());

create policy "branches_select_all" on public.branches for select using (true);
create policy "branches_admin_write" on public.branches for all
  using (public.is_admin()) with check (public.is_admin());

create policy "topics_select_all" on public.topics for select using (true);
create policy "topics_admin_write" on public.topics for all
  using (public.is_admin()) with check (public.is_admin());

-- ============================================================
-- questions: NO direct grant to anon/authenticated at all.
-- Regular reads go through the questions_public view (0003) which excludes
-- correct_option/explanation. Answer-revealing data only ever leaves the
-- database through the RPCs in 0004 (submit_practice_answer,
-- get_attempt_review, admin_* functions), which are SECURITY DEFINER and
-- enforce their own authorization. Enabling RLS with no policies at all
-- means even the table owner's default grants are blocked for normal roles.
-- ============================================================
alter table public.questions enable row level security;
-- Intentionally no policies here: base table is inaccessible directly.
-- Admin CRUD happens exclusively through the admin_* RPCs in 0004.

revoke all on public.questions from anon, authenticated;

-- ============================================================
-- test_attempts / test_attempt_questions / user_answers: ownership-scoped.
-- Direct client writes are still gated by RLS as defense in depth, but the
-- intended write path is exclusively the RPCs in 0004 so that expires_at,
-- randomized question sets, and is_correct can never be client-supplied.
-- ============================================================
alter table public.test_attempts enable row level security;
alter table public.test_attempt_questions enable row level security;
alter table public.user_answers enable row level security;

create policy "attempts_select_own" on public.test_attempts for select
  using (auth.uid() = user_id);
create policy "attempts_insert_own" on public.test_attempts for insert
  with check (auth.uid() = user_id);
create policy "attempts_update_own" on public.test_attempts for update
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "attempt_questions_select_own" on public.test_attempt_questions for select
  using (exists (
    select 1 from public.test_attempts ta
    where ta.id = attempt_id and ta.user_id = auth.uid()
  ));

create policy "answers_select_own" on public.user_answers for select
  using (exists (
    select 1 from public.test_attempts ta
    where ta.id = attempt_id and ta.user_id = auth.uid()
  ));
create policy "answers_insert_own" on public.user_answers for insert
  with check (exists (
    select 1 from public.test_attempts ta
    where ta.id = attempt_id and ta.user_id = auth.uid()
  ));
create policy "answers_update_own" on public.user_answers for update
  using (exists (
    select 1 from public.test_attempts ta
    where ta.id = attempt_id and ta.user_id = auth.uid()
  ));

-- No policies grant INSERT on test_attempt_questions to end users; rows are
-- written exclusively by the start_test_attempt SECURITY DEFINER RPC.
