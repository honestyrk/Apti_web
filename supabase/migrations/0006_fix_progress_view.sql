-- 0006_fix_progress_view.sql
-- Hotfix: user_topic_progress (security_invoker = true) joins the base
-- `questions` table to resolve each answer's topic_id. But `questions`
-- has zero grants to `authenticated` at all (by design, in 0002, to stop
-- users reading correct_option/explanation directly). Because the view
-- runs with the *querying user's* privileges, this made every
-- authenticated user's query against user_topic_progress fail with
-- "permission denied for table questions" -- and the frontend was
-- silently swallowing that error, so the Dashboard's "Overall accuracy"
-- and "Questions attempted" stats appeared frozen at 0 no matter how
-- many questions a user answered.
--
-- Fix: grant SELECT on only the two columns the view actually needs
-- (id, topic_id) so the join succeeds, without exposing correct_option,
-- explanation, or any other answer-revealing column. Column-level grants
-- are used instead of routing through questions_public specifically so
-- that progress on since-deactivated (is_active = false) questions is
-- still counted -- questions_public filters those out.

grant select (id, topic_id) on public.questions to authenticated;
