-- ============================================================================
--  MIGRATION 003 · TEACHER / FACULTY ATTENDANCE
--  Target : PostgreSQL (Supabase) — project `sse_portal`
--  Applies on top of : schema.sql (v1), migrations 001 and 002
--
--  ⚠️  SCHEMA CHANGE — TELL THE STUDENT-APP DEV (CLAUDE.md §6).
--      Purely ADDITIVE: one new table, no existing column touched. The student
--      app needs no change, and must never read this table — see the RLS note.
--
--  Safe to run more than once.
-- ============================================================================
--
--  WHY A SEPARATE TABLE AND NOT `attendance`
--
--  `attendance.student_id` is NOT NULL REFERENCES students(id), and the table
--  is keyed UNIQUE(student_id, date). Holding teacher rows there would mean
--  making student_id nullable and reworking that unique key — which is the
--  idempotency guarantee the entire offline retry story rests on
--  (schema.sql §6). Breaking it to save one table would be a bad trade.
--
--  A separate table also keeps staff data cleanly out of everything the
--  student app touches. `attendance` is readable by students for their own
--  rows; teacher attendance must never be.
-- ============================================================================

BEGIN;

CREATE TABLE IF NOT EXISTS teacher_attendance (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    teacher_id      UUID NOT NULL REFERENCES teachers(id),
    date            DATE NOT NULL,

    --  The same five states as student attendance, with the same wire
    --  strings. Deliberately identical: one AttendanceStatus enum in
    --  school_core serves both, and a principal reading two registers should
    --  not have to learn two vocabularies.
    status          TEXT NOT NULL
                    CHECK (status IN ('present','absent','leave','late','holiday')),

    --  '08:05'. Wall-clock text, like timetable_slots.start_time — not a
    --  timestamp, because it is a time of day and never needs a timezone.
    --  Null when not recorded; the office does not always take arrival times.
    check_in_time   TEXT,

    --  'Medical leave', 'Casual leave', 'Official duty'. Free text on purpose:
    --  leave categories vary between schools and hard-coding a CHECK list here
    --  would be guessing at this school's HR policy.
    remarks         TEXT,

    marked_by       UUID NOT NULL REFERENCES app_users(id),
    marked_at       TIMESTAMPTZ NOT NULL DEFAULT now(),

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1,

    --  Same idempotency guarantee as student attendance: marking a teacher
    --  twice on one day UPDATES. This is what makes an offline retry safe.
    UNIQUE (teacher_id, date)
);

CREATE INDEX IF NOT EXISTS idx_teacher_attendance_teacher_date
    ON teacher_attendance(teacher_id, date);
CREATE INDEX IF NOT EXISTS idx_teacher_attendance_date
    ON teacher_attendance(date) WHERE deleted_at IS NULL;


-- ----------------------------------------------------------------------------
--  RLS — principal only
-- ----------------------------------------------------------------------------
--  🚨 There is deliberately NO student policy, and no teacher policy either.
--
--  Staff attendance is HR data. A student being able to see which teacher was
--  absent on which day is both none of their business and, in a school where
--  everyone knows everyone, actively unkind. RLS denies by default, so the
--  absence of a policy IS the protection.
--
--  When the teacher role is switched on later, a teacher should see only their
--  OWN row — never a colleague's. That policy is written below but left
--  commented, because `teachers.user_id` is not populated in the prototype.

ALTER TABLE teacher_attendance ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS admin_all_teacher_attendance ON teacher_attendance;
CREATE POLICY admin_all_teacher_attendance ON teacher_attendance FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());

--  For when the teacher role is enabled:
--
--  CREATE POLICY teacher_read_own_attendance ON teacher_attendance FOR SELECT
--      USING (teacher_id IN (
--          SELECT id FROM teachers WHERE user_id = auth.uid()
--      ));


-- ----------------------------------------------------------------------------
--  server_seq stamping — same treatment as every other syncable table
-- ----------------------------------------------------------------------------
--  Without this the rows would have server_seq NULL forever and never satisfy
--  `WHERE server_seq > cursor`, so they would sync to no device, ever. That is
--  exactly the bug migration 002 existed to fix; adding a table without the
--  trigger would quietly reintroduce it.

DROP TRIGGER IF EXISTS trg_seq_teacher_attendance ON teacher_attendance;
CREATE TRIGGER trg_seq_teacher_attendance
    BEFORE INSERT OR UPDATE ON teacher_attendance
    FOR EACH ROW EXECUTE FUNCTION stamp_server_seq();

COMMIT;


-- ============================================================================
--  VERIFY
-- ============================================================================
--
--   -- 19 triggers now (18 from migration 002, plus this one)
--   SELECT count(*) FROM pg_trigger
--   WHERE tgname LIKE 'trg_seq%' AND NOT tgisinternal;
--
--   -- RLS on, exactly one policy
--   SELECT rowsecurity FROM pg_tables
--   WHERE schemaname='public' AND tablename='teacher_attendance';
--
--   SELECT policyname FROM pg_policies
--   WHERE tablename = 'teacher_attendance';
-- ============================================================================
