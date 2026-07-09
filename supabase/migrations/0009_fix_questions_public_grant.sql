-- 0009_fix_questions_public_grant.sql
-- Hotfix: questions_public is a plain view (no security_invoker) over
-- `questions`, which should normally let it run with the view owner's
-- privileges and bypass the fact that `authenticated` has zero grants on
-- the base `questions` table. In practice, querying questions_public
-- directly from the frontend (as Practice mode does) fails with
-- "permission denied for table questions" -- the same class of bug
-- fixed for user_topic_progress in 0006, just on a different object.
--
-- Test mode never hit this because it fetches question data through
-- SECURITY DEFINER RPCs (get_test_questions, etc.), which are a more
-- explicit, guaranteed bypass mechanism than view-owner rights and were
-- already confirmed working.
--
-- Fix: same pattern as 0006 -- grant SELECT directly to `authenticated`
-- on exactly the columns questions_public exposes (everything except
-- correct_option and explanation), so the view works regardless of
-- whatever is preventing the owner-rights bypass from applying here.

grant select (
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
) on public.questions to authenticated;
