-- ============================================================================
--  MIGRATION 002 · server_seq TRIGGERS ON EVERY SYNCABLE TABLE
--  Target : PostgreSQL (Supabase) — project `sse_portal`
--  Applies on top of : schema.sql (v1), migration 001
--
--  ⚠️  SCHEMA CHANGE — TELL THE STUDENT-APP DEV (CLAUDE.md §6).
--      Additive, no column changes, no client code change required.
--
--  Safe to run more than once.
-- ============================================================================
--
--  WHY THIS EXISTS
--
--  schema.sql §10 stamps server_seq on five tables — students, attendance,
--  marks, fee_challans, lost_items — and then says:
--
--      "-- add the same trigger to every remaining syncable table"
--
--  That was never done, so THIRTEEN tables still have server_seq permanently
--  NULL: schools, academic_years, classes, subjects, app_users, teachers,
--  teacher_class_assignments, exams, fee_structures, timetable_slots,
--  assignments, notices, item_claims.
--
--  Why that matters: server_seq IS the sync cursor (CLAUDE.md §10). A client
--  pulls `WHERE server_seq > cursor`. A row whose server_seq is NULL never
--  satisfies that predicate, so it would NEVER sync to any device — not once,
--  not ever. Create a class, a subject or an exam on the desktop and it would
--  simply never appear on any phone.
--
--  The prototype hides this, because CLAUDE.md §10 permits pulling by
--  `updated_at > last_sync` for the demo. So this bug would stay invisible
--  right up until the switch to the real cursor — at which point three
--  quarters of the tables would silently stop syncing, and the cause would be
--  a comment nobody actioned months earlier.
-- ============================================================================

BEGIN;

--  The function itself is unchanged from schema.sql §10; recreated here only
--  so this migration can be run against a fresh database on its own.
CREATE OR REPLACE FUNCTION stamp_server_seq() RETURNS TRIGGER AS $$
BEGIN
    NEW.server_seq := nextval('global_seq');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public, pg_temp;


--  Every syncable table, in one place.
--
--  A loop rather than 18 hand-written CREATE TRIGGER statements: the whole
--  reason this migration exists is that someone hand-maintained a list and
--  missed thirteen entries. A loop over one authoritative list cannot drift.
--
--  NOT included, deliberately:
--    * change_log — append-only, has its own BIGSERIAL `seq`, no server_seq
--    * sync_ops   — idempotency ledger, never synced to clients
--  First, remove the two legacy triggers from schema.sql §10.
--
--  They exist, but under names that do not match the table:
--      fee_challans -> trg_seq_challans   (not trg_seq_fee_challans)
--      lost_items   -> trg_seq_lost       (not trg_seq_lost_items)
--
--  The loop below creates table-named triggers, so without this both tables
--  would end up with TWO triggers calling stamp_server_seq(). That is not
--  wrong — the second assignment wins and server_seq stays monotonic — but it
--  burns two sequence values per write and leaves a confusing pair behind for
--  whoever reads pg_trigger next.
DROP TRIGGER IF EXISTS trg_seq_challans ON fee_challans;
DROP TRIGGER IF EXISTS trg_seq_lost     ON lost_items;

DO $$
DECLARE
    syncable_table TEXT;
BEGIN
    FOREACH syncable_table IN ARRAY ARRAY[
        -- §1 reference
        'schools',
        'academic_years',
        'classes',
        'subjects',
        -- §2 people & access
        'app_users',
        'teachers',
        'teacher_class_assignments',
        'students',
        -- §3 attendance
        'attendance',
        -- §4 exams & marks
        'exams',
        'marks',
        -- §5 fees
        'fee_structures',
        'fee_challans',
        -- §6 timetable, assignments, notices
        'timetable_slots',
        'assignments',
        'notices',
        -- §7 lost & found
        'lost_items',
        'item_claims'
    ]
    LOOP
        EXECUTE format(
            'DROP TRIGGER IF EXISTS trg_seq_%I ON %I',
            syncable_table, syncable_table
        );
        EXECUTE format(
            'CREATE TRIGGER trg_seq_%I BEFORE INSERT OR UPDATE ON %I '
            'FOR EACH ROW EXECUTE FUNCTION stamp_server_seq()',
            syncable_table, syncable_table
        );
    END LOOP;
END $$;


--  Backfill anything already inserted while the trigger was missing.
--
--  Rows currently sitting at server_seq IS NULL are invisible to a
--  cursor-based pull forever. A no-op UPDATE fires the new BEFORE trigger and
--  stamps them.
--
--  `updated_at = updated_at` is deliberate: it touches the row without
--  changing any user-visible value, so nothing is reordered in the UI.
DO $$
DECLARE
    syncable_table TEXT;
BEGIN
    FOREACH syncable_table IN ARRAY ARRAY[
        'schools', 'academic_years', 'classes', 'subjects',
        'app_users', 'teachers', 'teacher_class_assignments', 'students',
        'attendance', 'exams', 'marks', 'fee_structures', 'fee_challans',
        'timetable_slots', 'assignments', 'notices', 'lost_items', 'item_claims'
    ]
    LOOP
        EXECUTE format(
            'UPDATE %I SET updated_at = updated_at WHERE server_seq IS NULL',
            syncable_table
        );
    END LOOP;
END $$;

COMMIT;


-- ============================================================================
--  VERIFY AFTER RUNNING
-- ============================================================================
--
--  1. Eighteen triggers, one per syncable table:
--
--       SELECT count(*) FROM pg_trigger
--       WHERE tgname LIKE 'trg_seq_%' AND NOT tgisinternal;
--       -- expect 18
--
--  2. No syncable row is invisible to a cursor pull. Every one of these must
--     return 0:
--
--       SELECT count(*) FROM classes  WHERE server_seq IS NULL;
--       SELECT count(*) FROM subjects WHERE server_seq IS NULL;
--       SELECT count(*) FROM exams    WHERE server_seq IS NULL;
--
--  3. server_seq actually advances — insert a row, update it, and confirm the
--     value increases. It comes from one global sequence, so it is monotonic
--     across ALL tables, which is what makes a single cursor work.
-- ============================================================================
