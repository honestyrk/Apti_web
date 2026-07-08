-- 0005_fix_view_grants.sql
-- Hotfix for a real gap found after deploying: Supabase's default
-- privileges automatically grant SELECT on newly created tables/views to
-- both `anon` and `authenticated`. The original 0003_views.sql only added
-- a GRANT for `authenticated` without revoking the pre-existing `anon`
-- grant, so questions_public (question text, options, difficulty) was
-- readable by completely unauthenticated requests. Run this once against
-- any database that already applied 0001-0004 before this file existed.

revoke all on public.questions_public from public, anon;
grant select on public.questions_public to authenticated;

revoke all on public.user_topic_progress from public, anon;
grant select on public.user_topic_progress to authenticated;
