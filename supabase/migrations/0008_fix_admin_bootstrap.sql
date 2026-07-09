-- 0008_fix_admin_bootstrap.sql
-- Hotfix: guard_profile_role_change (0002) blocks any role change unless
-- is_admin() is true. is_admin() checks profiles for a row matching
-- auth.uid() -- but auth.uid() reads a JWT claim that PostgREST sets on
-- authenticated app requests, and is NULL for SQL run directly in the
-- Supabase SQL Editor (no JWT in that context at all). That meant the
-- exact "promote yourself to admin" SQL documented in SETUP.md would
-- itself be blocked by this trigger with "Only admins may change
-- profile roles" -- nobody could ever bootstrap the first admin.
--
-- Fix: only enforce the is_admin() check when the update is happening
-- inside an authenticated app request (auth.uid() is not null). Direct
-- SQL Editor / migration access already implies full database
-- credentials (equivalent trust to a superuser), so it's safe to allow
-- there. This does NOT weaken anything for real app traffic: the RLS
-- policy on profiles (auth.uid() = id or is_admin()) already prevents
-- anon or other authenticated users from ever reaching this trigger for
-- a row they don't own, since anon's auth.uid() is also null and can
-- never match a row's id.

create or replace function public.guard_profile_role_change()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.role is distinct from old.role and auth.uid() is not null and not public.is_admin() then
    raise exception 'Only admins may change profile roles';
  end if;
  return new;
end;
$$;
