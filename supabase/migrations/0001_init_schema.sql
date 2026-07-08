-- 0001_init_schema.sql
-- Core tables, constraints, and indexes for the Placement Prep platform.

create extension if not exists "pgcrypto";

-- ============================================================
-- profiles (1:1 extension of auth.users)
-- ============================================================
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  email text not null,
  role text not null default 'user' check (role in ('user', 'admin')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ============================================================
-- categories
-- ============================================================
create table public.categories (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  slug text not null unique,
  description text,
  icon text,
  display_order int not null default 0,
  has_branches boolean not null default false,
  created_at timestamptz not null default now()
);

-- ============================================================
-- branches (only populated for categories where has_branches = true)
-- ============================================================
create table public.branches (
  id uuid primary key default gen_random_uuid(),
  category_id uuid not null references public.categories(id) on delete cascade,
  name text not null,
  slug text not null,
  description text,
  display_order int not null default 0,
  created_at timestamptz not null default now(),
  unique (category_id, slug)
);

-- ============================================================
-- topics
-- ============================================================
create table public.topics (
  id uuid primary key default gen_random_uuid(),
  category_id uuid not null references public.categories(id) on delete cascade,
  branch_id uuid references public.branches(id) on delete cascade,
  name text not null,
  slug text not null,
  description text,
  display_order int not null default 0,
  created_at timestamptz not null default now()
);

-- A single composite unique constraint can't handle "unique per category
-- when branch_id is null, unique per category+branch when it isn't" because
-- NULL is never equal to NULL in a uniqueness check. Two partial indexes cover both cases.
create unique index topics_category_slug_no_branch_key
  on public.topics (category_id, slug) where branch_id is null;
create unique index topics_category_branch_slug_key
  on public.topics (category_id, branch_id, slug) where branch_id is not null;

create index idx_topics_category on public.topics (category_id);
create index idx_topics_branch on public.topics (branch_id);

-- Keeps topics.branch_id consistent with categories.has_branches so the
-- frontend never has to special-case malformed data.
create or replace function public.enforce_topic_branch_consistency()
returns trigger
language plpgsql
as $$
declare
  cat_has_branches boolean;
  branch_category_id uuid;
begin
  select has_branches into cat_has_branches from public.categories where id = new.category_id;

  if cat_has_branches then
    if new.branch_id is null then
      raise exception 'topics.branch_id is required for categories with has_branches = true';
    end if;
    select category_id into branch_category_id from public.branches where id = new.branch_id;
    if branch_category_id is distinct from new.category_id then
      raise exception 'topics.branch_id must belong to the same category_id';
    end if;
  else
    if new.branch_id is not null then
      raise exception 'topics.branch_id must be null for categories with has_branches = false';
    end if;
  end if;

  return new;
end;
$$;

create trigger trg_enforce_topic_branch_consistency
  before insert or update on public.topics
  for each row execute function public.enforce_topic_branch_consistency();

-- ============================================================
-- questions
-- ============================================================
create table public.questions (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid not null references public.topics(id) on delete cascade,
  question_text text not null,
  option_a text not null,
  option_b text not null,
  option_c text not null,
  option_d text not null,
  correct_option char(1) not null check (correct_option in ('a', 'b', 'c', 'd')),
  explanation text,
  difficulty text not null default 'medium' check (difficulty in ('easy', 'medium', 'hard')),
  is_active boolean not null default true,
  created_by uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index idx_questions_topic_active on public.questions (topic_id, is_active);
create index idx_questions_topic_difficulty on public.questions (topic_id, difficulty);

-- ============================================================
-- test_attempts (covers both practice and test mode)
-- ============================================================
create table public.test_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  mode text not null check (mode in ('practice', 'test')),
  scope_type text not null check (scope_type in ('topic', 'branch', 'category', 'full')),
  topic_id uuid references public.topics(id) on delete set null,
  branch_id uuid references public.branches(id) on delete set null,
  category_id uuid references public.categories(id) on delete set null,
  total_questions int not null,
  duration_seconds int,
  started_at timestamptz not null default now(),
  expires_at timestamptz,
  submitted_at timestamptz,
  status text not null default 'in_progress'
    check (status in ('in_progress', 'submitted', 'auto_submitted', 'abandoned')),
  score numeric(5, 2),
  correct_count int not null default 0,
  incorrect_count int not null default 0,
  unanswered_count int not null default 0
);

create index idx_attempts_user on public.test_attempts (user_id);
create index idx_attempts_user_status on public.test_attempts (user_id, status);

-- ============================================================
-- test_attempt_questions (locks in the randomized set at start time)
-- ============================================================
create table public.test_attempt_questions (
  id uuid primary key default gen_random_uuid(),
  attempt_id uuid not null references public.test_attempts(id) on delete cascade,
  question_id uuid not null references public.questions(id) on delete cascade,
  order_index int not null,
  unique (attempt_id, question_id),
  unique (attempt_id, order_index)
);

create index idx_attempt_questions_attempt on public.test_attempt_questions (attempt_id);

-- ============================================================
-- user_answers
-- ============================================================
create table public.user_answers (
  id uuid primary key default gen_random_uuid(),
  attempt_id uuid not null references public.test_attempts(id) on delete cascade,
  question_id uuid not null references public.questions(id) on delete cascade,
  selected_option char(1) check (selected_option in ('a', 'b', 'c', 'd')),
  is_correct boolean,
  answered_at timestamptz not null default now(),
  unique (attempt_id, question_id)
);

create index idx_answers_attempt on public.user_answers (attempt_id);
create index idx_answers_question on public.user_answers (question_id);

-- ============================================================
-- updated_at maintenance
-- ============================================================
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger trg_profiles_updated_at
  before update on public.profiles
  for each row execute function public.set_updated_at();

create trigger trg_questions_updated_at
  before update on public.questions
  for each row execute function public.set_updated_at();

-- ============================================================
-- new-user provisioning: create a profile row when a user signs up
-- ============================================================
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, full_name, email)
  values (new.id, new.raw_user_meta_data ->> 'full_name', new.email);
  return new;
end;
$$;

create trigger trg_on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
