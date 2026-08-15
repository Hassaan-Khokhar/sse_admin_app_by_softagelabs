-- ============================================================================
--  MIGRATION 005 · ADD 'pending' TO lost_items.moderation CHECK CONSTRAINT
--  Target : PostgreSQL (Supabase) — project `sse_portal`
--  Applies on top of : schema.sql + migrations 001–004
--
--  Safe to run more than once.
-- ============================================================================
--
--  WHY THIS EXISTS
--
--  schema.sql §7 defines `lost_items.moderation` with a DEFAULT of 'pending'
--  and a CHECK constraint that includes it. The Dart enum `ModerationState`
--  also has `pending` as its first value.
--
--  However, the Supabase database was provisioned from an older version of the
--  schema where the CHECK constraint only listed ('visible','hidden','removed').
--  The column's DEFAULT was 'pending' — a value that Postgres itself wrote —
--  yet the CHECK constraint would reject if the app tried to sync that value.
--
--  Result: every `lost_items` row with `moderation = 'pending'` fails on push:
--
--      PostgrestException: new row for relation "lost_items" violates
--      check constraint "lost_items_moderation_check"
--
--  This migration replaces the constraint with the full set.
-- ============================================================================

BEGIN;

-- Drop the old constraint (name may vary; Postgres auto-names it
-- `<table>_<column>_check`). IF EXISTS makes this idempotent.
ALTER TABLE lost_items DROP CONSTRAINT IF EXISTS lost_items_moderation_check;

-- Re-add with the full set matching schema.sql and the Dart enum.
ALTER TABLE lost_items ADD CONSTRAINT lost_items_moderation_check
    CHECK (moderation IN ('pending', 'visible', 'hidden', 'removed'));

COMMIT;


-- ============================================================================
--  VERIFY — the constraint should now accept 'pending'
-- ============================================================================
--
--   SELECT conname, pg_get_constraintdef(oid)
--   FROM pg_constraint
--   WHERE conrelid = 'lost_items'::regclass
--     AND contype = 'c'
--     AND conname LIKE '%moderation%';
--
--  Expected: lost_items_moderation_check
--            CHECK ((moderation = ANY (ARRAY['pending','visible','hidden','removed'])))
-- ============================================================================
