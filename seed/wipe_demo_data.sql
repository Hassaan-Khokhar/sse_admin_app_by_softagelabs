-- ============================================================================
--  WIPE DEMO DATA
--  Run in: Supabase dashboard → SQL Editor, on project `sse_portal`
--
--  ⚠️  DESTRUCTIVE AND IRREVERSIBLE.
--      The Supabase free tier has NO BACKUPS (CLAUDE.md §14). Nothing deleted
--      here can be recovered from the server.
--
--      It is all reproducible: the seeder is deterministic, so "Seed demo
--      data" then "Queue all for push" rebuilds an identical school with
--      identical UUIDs. Nothing irreplaceable is lost — but only because this
--      is demo data. Do not point this at real school records.
-- ============================================================================
--
--  DO THIS IN ORDER, or the data comes straight back:
--
--    1. In the admin app → Dashboard → "Wipe local data"
--    2. Then run this script
--
--  The desktop holds its own full copy. Wiping only the server leaves the
--  local database intact, and the next "Queue all for push" re-uploads
--  everything you just deleted.
-- ============================================================================
--
--  WHAT SURVIVES, DELIBERATELY:
--
--    * your login — the app_users row whose id matches auth.users
--    * the school and academic year the app hangs off
--
--  Deleting the linked app_users row would lock you out of your own project:
--  current_role_name() reads that row, every admin policy trusts it, and with
--  it gone RLS denies you everything. The Supabase SQL editor could still fix
--  it, but the app could not.
--
--  These are HARD deletes, not tombstones. schema.sql convention 3 forbids
--  hard deletes for real data because a missing row cannot sync — but this is
--  a reset to a clean slate before anything is live, and 3,000 tombstones
--  syncing to devices is worse than a clean table.
-- ============================================================================

BEGIN;

-- Children first — foreign keys are enforced here, unlike in local SQLite.
DELETE FROM item_claims;
DELETE FROM lost_items;

DELETE FROM marks;
DELETE FROM attendance;
DELETE FROM teacher_attendance;

DELETE FROM fee_challans;
DELETE FROM fee_structures;

DELETE FROM assignments;
DELETE FROM notices;
DELETE FROM timetable_slots;

DELETE FROM exams;
DELETE FROM teacher_class_assignments;

DELETE FROM students;
DELETE FROM subjects;
DELETE FROM classes;
DELETE FROM teachers;

--  Every app_user EXCEPT the one you sign in with.
--  This removes "Principal (seed)" and any student accounts, and keeps yours.
DELETE FROM app_users
WHERE id NOT IN (SELECT id FROM auth.users);

--  Sync bookkeeping. Stale entries here describe rows that no longer exist,
--  and would be replayed to any device that pulls with an old cursor.
DELETE FROM change_log;
DELETE FROM sync_ops;

COMMIT;


-- ============================================================================
--  OPTIONAL — also remove the school itself
-- ============================================================================
--  Only if you are starting completely fresh with the real school's details.
--  After this, re-run seed/bootstrap_principal.sql to recreate the school and
--  re-link your account, or the app has no school to attach anything to.
--
--   BEGIN;
--   DELETE FROM app_users;          -- including yours; auth.users is untouched
--   DELETE FROM academic_years;
--   DELETE FROM schools;
--   COMMIT;
--
--  auth.users is never touched by any of this. Your email and password
--  survive; only the app_users mirror row is removed, and bootstrap recreates
--  it by looking you up by email.
-- ============================================================================


-- ============================================================================
--  VERIFY — everything zero except app_users (1) and schools (1)
-- ============================================================================
--
--   SELECT 'students' AS t, count(*) FROM students
--   UNION ALL SELECT 'attendance',         count(*) FROM attendance
--   UNION ALL SELECT 'teacher_attendance', count(*) FROM teacher_attendance
--   UNION ALL SELECT 'teachers',           count(*) FROM teachers
--   UNION ALL SELECT 'classes',            count(*) FROM classes
--   UNION ALL SELECT 'subjects',           count(*) FROM subjects
--   UNION ALL SELECT 'fee_challans',       count(*) FROM fee_challans
--   UNION ALL SELECT 'fee_structures',     count(*) FROM fee_structures
--   UNION ALL SELECT 'marks',              count(*) FROM marks
--   UNION ALL SELECT 'exams',              count(*) FROM exams
--   UNION ALL SELECT 'app_users',          count(*) FROM app_users
--   UNION ALL SELECT 'schools',            count(*) FROM schools
--   ORDER BY t;
--
--  Confirm you can still sign in afterwards — this must return one row:
--
--   SELECT a.full_name, a.role
--   FROM app_users a JOIN auth.users u ON u.id = a.id;
-- ============================================================================
