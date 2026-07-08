-- 0003_views.sql

-- ============================================================
-- questions_public: everything except correct_option/explanation.
-- Deliberately created WITHOUT security_invoker so it runs with the view
-- owner's privileges (the migration role, which is exempt from RLS on the
-- base `questions` table as its owner) even though `questions` itself has
-- no policies granted to authenticated/anon. This is what lets logged-in
-- users list questions to practice/take tests without ever being able to
-- query correct_option/explanation off the base table.
-- ============================================================
create view public.questions_public as
select
  id,
  topic_id,
  question_text,
  option_a,
  option_b,
  option_c,
  option_d,
  difficulty,
  is_active,
  created_at
from public.questions
where is_active = true;

grant select on public.questions_public to authenticated;

-- ============================================================
-- user_topic_progress: per-user, per-topic accuracy aggregation.
-- security_invoker = true is required here -- the opposite of
-- questions_public -- so the view is evaluated with the *querying* user's
-- own RLS on test_attempts/user_answers, restricting results to their own
-- rows. Without it, this view (owned by a role that bypasses RLS) would
-- return every user's stats to anyone who queries it.
-- ============================================================
create view public.user_topic_progress
  with (security_invoker = true) as
select
  ta.user_id,
  q.topic_id,
  t.category_id,
  t.branch_id,
  count(*) as questions_attempted,
  count(*) filter (where ua.is_correct) as correct_count,
  round(
    100.0 * count(*) filter (where ua.is_correct) / nullif(count(*), 0),
    2
  ) as accuracy_pct
from public.user_answers ua
join public.test_attempts ta on ta.id = ua.attempt_id
join public.questions q on q.id = ua.question_id
join public.topics t on t.id = q.topic_id
where ua.selected_option is not null
group by ta.user_id, q.topic_id, t.category_id, t.branch_id;

grant select on public.user_topic_progress to authenticated;
