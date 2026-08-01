-- ============================================================================
--  MIGRATION 001 · RLS HARDENING
--  Target : PostgreSQL (Supabase) — project `sse_portal`
--  Applies on top of : schema.sql (v1)
--
--  ⚠️  SCHEMA CHANGE — TELL THE STUDENT-APP DEV (CLAUDE.md §6).
--      This one is additive and changes no columns, so the student app needs
--      no code change. But it DOES change what the publishable key can reach,
--      so if the student app was accidentally relying on an unprotected table
--      it will start getting empty results. Read §C before assuming that is a
--      bug.
--
--  Safe to run more than once.
-- ============================================================================
--
--  WHY THIS EXISTS — two gaps in schema.sql §9, both found by probing the
--  live project with the publishable key:
--
--   1. Eight tables were created but never had RLS enabled, so the publishable
--      key — which is compiled into both apps and extractable in 30 seconds —
--      could read AND WRITE them.
--
--      The worst is `app_users`. schema.sql defines
--          current_role_name() = SELECT role FROM app_users WHERE id = auth.uid()
--      and every admin policy trusts its answer. A student able to UPDATE
--      their own app_users row to role='super_admin' would inherit full access
--      to every other table. The privilege escalation runs through the one
--      table that had no protection at all.
--
--   2. Six tables had RLS ENABLED but only student policies. RLS denies by
--      default, so the PRINCIPAL could not read or write exams, classes,
--      subjects, notices, assignments or timetable_slots. The admin app would
--      have come up blank. schema.sql:618 said "(repeat the same shape …)"
--      and that was never done.
-- ============================================================================

BEGIN;


-- ============================================================================
--  SECTION A · HARDEN THE SECURITY DEFINER HELPERS
-- ============================================================================
--  These four functions decide every access question in the database, so they
--  are worth getting exactly right.
--
--  Two changes:
--
--   * `SET search_path = public, pg_temp` — without a pinned search_path, a
--     caller who can create objects in an earlier schema can shadow `app_users`
--     with their own table and make current_role_name() return whatever they
--     like. The function runs as its owner, so that would be a straight
--     privilege escalation. This is also what Supabase's own security linter
--     flags.
--
--   * They stay SECURITY DEFINER on purpose. Enabling RLS on app_users in
--     §B would otherwise make these functions unable to read the very table
--     they depend on, and every policy in the database would evaluate to NULL
--     — locking everyone out, including the principal. A SECURITY DEFINER
--     function runs as its owner (postgres), and a table owner bypasses RLS,
--     so the helpers keep working.
--
--  These are the ONLY places that intentionally read past RLS. Do not add more.
-- ============================================================================

CREATE OR REPLACE FUNCTION current_role_name() RETURNS TEXT AS $$
    SELECT role FROM public.app_users WHERE id = auth.uid() AND deleted_at IS NULL;
$$ LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public, pg_temp;

CREATE OR REPLACE FUNCTION current_school_id() RETURNS UUID AS $$
    SELECT school_id FROM public.app_users WHERE id = auth.uid() AND deleted_at IS NULL;
$$ LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public, pg_temp;

CREATE OR REPLACE FUNCTION current_student_id() RETURNS UUID AS $$
    SELECT id FROM public.students WHERE user_id = auth.uid() AND deleted_at IS NULL;
$$ LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public, pg_temp;

CREATE OR REPLACE FUNCTION current_class_id() RETURNS UUID AS $$
    SELECT class_id FROM public.students WHERE user_id = auth.uid() AND deleted_at IS NULL;
$$ LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public, pg_temp;

--  NOTE: `AND deleted_at IS NULL` is new. Without it a tombstoned app_users row
--  still answered "super_admin", so a withdrawn account kept its powers until
--  the row was physically gone — which, per schema.sql convention 3, is never.

--  A withdrawn student is handled by is_active, checked in §B.


-- ============================================================================
--  SECTION B · ENABLE RLS ON THE EIGHT UNPROTECTED TABLES
-- ============================================================================

ALTER TABLE schools                   ENABLE ROW LEVEL SECURITY;
ALTER TABLE academic_years            ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_users                 ENABLE ROW LEVEL SECURITY;
ALTER TABLE teachers                  ENABLE ROW LEVEL SECURITY;
ALTER TABLE teacher_class_assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE fee_structures            ENABLE ROW LEVEL SECURITY;
ALTER TABLE change_log                ENABLE ROW LEVEL SECURITY;
ALTER TABLE sync_ops                  ENABLE ROW LEVEL SECURITY;


-- ── schools ─────────────────────────────────────────────────────────────────
--  Everyone signed in may read their own school (name and logo appear in both
--  apps' headers). Only the principal may change it.

DROP POLICY IF EXISTS admin_all_schools ON schools;
CREATE POLICY admin_all_schools ON schools FOR ALL
    USING (current_role_name() = 'super_admin' AND id = current_school_id());

DROP POLICY IF EXISTS read_own_school ON schools;
CREATE POLICY read_own_school ON schools FOR SELECT
    USING (id = current_school_id());


-- ── academic_years ──────────────────────────────────────────────────────────
--  Students need the current year to make sense of terms and results.

DROP POLICY IF EXISTS admin_all_academic_years ON academic_years;
CREATE POLICY admin_all_academic_years ON academic_years FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());

DROP POLICY IF EXISTS read_school_academic_years ON academic_years;
CREATE POLICY read_school_academic_years ON academic_years FOR SELECT
    USING (school_id = current_school_id());


-- ── app_users ───────────────────────────────────────────────────────────────
--  🚨 THE IMPORTANT ONE. This table decides who everybody is.
--
--  A user may read their OWN row and nothing else. There is deliberately no
--  student UPDATE policy: RLS denies by default, so a student physically
--  cannot rewrite their own `role` — which was the escalation path.
--
--  Note this also means the student app cannot stamp `last_login_at` itself.
--  That is intentional. If it turns out to be needed, add a narrowly scoped
--  SECURITY DEFINER function that touches only that column — never a blanket
--  UPDATE policy on this table.

DROP POLICY IF EXISTS admin_all_app_users ON app_users;
CREATE POLICY admin_all_app_users ON app_users FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());

DROP POLICY IF EXISTS read_own_app_user ON app_users;
CREATE POLICY read_own_app_user ON app_users FOR SELECT
    USING (id = auth.uid());

--  BOOTSTRAP — chicken and egg: the first super_admin row cannot be inserted
--  by a super_admin, because none exists yet. Create it once from the Supabase
--  dashboard (SQL editor runs as postgres and bypasses RLS). After that the
--  principal can manage everyone from the admin app.


-- ── teachers ────────────────────────────────────────────────────────────────
--  Principal only. This table holds CNICs and personal phone numbers.
--
--  There is deliberately NO student policy. RLS is row-level, not
--  column-level, so granting students SELECT to show a teacher's NAME on the
--  timetable would hand them the CNIC and phone number in the same row.
--  If the student app needs teacher names, denormalise the name onto
--  timetable_slots/subjects, or expose a view with only the safe columns.

DROP POLICY IF EXISTS admin_all_teachers ON teachers;
CREATE POLICY admin_all_teachers ON teachers FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());

DROP POLICY IF EXISTS teacher_read_own ON teachers;
CREATE POLICY teacher_read_own ON teachers FOR SELECT
    USING (user_id = auth.uid());


-- ── teacher_class_assignments ───────────────────────────────────────────────
--  Principal only in the prototype. No student has any reason to read it.

DROP POLICY IF EXISTS admin_all_tca ON teacher_class_assignments;
CREATE POLICY admin_all_tca ON teacher_class_assignments FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());


-- ── fee_structures ──────────────────────────────────────────────────────────
--  Principal only. These are the per-class fee AMOUNTS the bulk challan
--  generator reads. Left unprotected, anyone holding the publishable key could
--  set their own class's tuition to zero and the next run of bulk generation
--  would faithfully bill it.
--
--  No student policy: a student sees the amounts on their own challan, where
--  they are already denormalised, so there is nothing here they need.

DROP POLICY IF EXISTS admin_all_fee_structures ON fee_structures;
CREATE POLICY admin_all_fee_structures ON fee_structures FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());


-- ── change_log ──────────────────────────────────────────────────────────────
--  🚨 Every row here contains the full JSON payload of a change to some other
--  table. Read access to change_log is read access to EVERYTHING — marks,
--  fees, guardian phone numbers — regardless of how carefully the source
--  tables are protected.
--
--  No client policy at all. RLS denies by default, so neither app can touch it
--  with the publishable key. It is written and read server-side (service_role,
--  which bypasses RLS) by the sync endpoints.
--
--  This costs nothing today: CLAUDE.md §10 defers change_log for the
--  prototype and pulls by `updated_at > last_sync` instead.
--
--  When the real cursor-based pull is built, do NOT open this table up. Expose
--  a SECURITY DEFINER function that filters by student_id/class_id and returns
--  only rows the caller is entitled to.


-- ── sync_ops ────────────────────────────────────────────────────────────────
--  The idempotency ledger. A client that could delete rows here could replay
--  operations and duplicate data — the exact failure the table prevents.
--  Server-side only, same reasoning as change_log.


-- ============================================================================
--  SECTION C · THE SIX MISSING ADMIN POLICIES
-- ============================================================================
--  schema.sql:618 — "(repeat the same shape for exams, subjects, classes,
--  notices, assignments, timetable_slots)". This is that repeat.
--
--  Until this runs, the principal cannot see a single exam or class, because
--  RLS on these tables is ENABLED with student-only policies and denies
--  everything else by default.
-- ============================================================================

DROP POLICY IF EXISTS admin_all_exams ON exams;
CREATE POLICY admin_all_exams ON exams FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());

DROP POLICY IF EXISTS admin_all_subjects ON subjects;
CREATE POLICY admin_all_subjects ON subjects FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());

DROP POLICY IF EXISTS admin_all_classes ON classes;
CREATE POLICY admin_all_classes ON classes FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());

DROP POLICY IF EXISTS admin_all_notices ON notices;
CREATE POLICY admin_all_notices ON notices FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());

DROP POLICY IF EXISTS admin_all_assignments ON assignments;
CREATE POLICY admin_all_assignments ON assignments FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());

DROP POLICY IF EXISTS admin_all_timetable ON timetable_slots;
CREATE POLICY admin_all_timetable ON timetable_slots FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());


-- ============================================================================
--  SECTION D · STUDENT READ ACCESS THAT WAS MISSING
-- ============================================================================

--  Students could read their own marks only if the exam was published — but
--  had no policy on `exams` itself, so the marksheet could not name the exam
--  it belonged to. Published exams only; an unpublished exam stays invisible,
--  which is the whole point of the is_published gate (CLAUDE.md §8).

DROP POLICY IF EXISTS student_read_published_exams ON exams;
CREATE POLICY student_read_published_exams ON exams FOR SELECT
    USING (school_id = current_school_id() AND is_published);


-- ============================================================================
--  SECTION E · LOCK THE DOOR ON WITHDRAWN ACCOUNTS
-- ============================================================================
--  Withdrawing a student sets students.status='withdrawn' AND
--  app_users.is_active=false. The student app checks is_active on sync and
--  logs out — but that is a CLIENT check, and a client check is not security.
--  A withdrawn student running a modified app would still hold a valid JWT.
--
--  This makes the database enforce it. current_student_id() returns the
--  student row only while the account is active, so every student policy that
--  depends on it — attendance, marks, challans — closes at once.

CREATE OR REPLACE FUNCTION current_student_id() RETURNS UUID AS $$
    SELECT s.id
    FROM public.students s
    JOIN public.app_users u ON u.id = s.user_id
    WHERE s.user_id = auth.uid()
      AND s.deleted_at IS NULL
      AND u.is_active
      AND u.deleted_at IS NULL;
$$ LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public, pg_temp;

CREATE OR REPLACE FUNCTION current_class_id() RETURNS UUID AS $$
    SELECT s.class_id
    FROM public.students s
    JOIN public.app_users u ON u.id = s.user_id
    WHERE s.user_id = auth.uid()
      AND s.deleted_at IS NULL
      AND u.is_active
      AND u.deleted_at IS NULL;
$$ LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public, pg_temp;

--  This is also the closing beat of the demo video (CLAUDE.md §12, 2:20):
--  the principal withdraws the student, it syncs, and the phone says
--  "Your account is no longer active." Now that is true at the database, not
--  just in the UI.


COMMIT;


-- ============================================================================
--  VERIFY BY HAND AFTER RUNNING  (CLAUDE.md §7 says to, before filming)
-- ============================================================================
--
--  1. Every table has RLS on — this must return ZERO rows:
--
--       SELECT tablename FROM pg_tables
--       WHERE schemaname = 'public' AND rowsecurity = false;
--
--  2. Every table with RLS has at least one policy — anything listed here is
--     a table nobody can read, which is usually a mistake:
--
--       SELECT t.tablename
--       FROM pg_tables t
--       LEFT JOIN pg_policies p
--         ON p.schemaname = t.schemaname AND p.tablename = t.tablename
--       WHERE t.schemaname = 'public' AND t.rowsecurity AND p.policyname IS NULL;
--
--     Expect exactly: change_log, sync_ops. Those are server-side only.
--
--  3. THE ONE THAT MATTERS. Log in as a student in the app and try to
--     escalate. Both of these must fail:
--
--       UPDATE app_users SET role = 'super_admin' WHERE id = auth.uid();
--       INSERT INTO marks (id, school_id, exam_id, student_id, subject_id,
--                          class_id, obtained_marks, total_marks, updated_at)
--       VALUES (...);
--
--     Do this with the publishable key from a REST client, not from the app UI
--     — the UI not showing a button proves nothing.
-- ============================================================================
