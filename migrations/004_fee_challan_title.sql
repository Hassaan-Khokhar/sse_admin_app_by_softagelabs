-- Migration 004 · Add title column to fee_challans
--
-- The Drift (local SQLite) schema added a nullable `title` column so that
-- custom challans ("Sports Fine", "Lab Fee") can coexist with monthly tuition
-- for the same student/month.  The Postgres side was never updated, so
-- SyncEngine.push() fails with:
--
--     Could not find the 'title' column of 'fee_challans' in the schema
--
-- This migration:
--   1. Adds the nullable TEXT column.
--   2. Replaces the old UNIQUE(student_id, month, year) with
--      UNIQUE(student_id, month, year, title) — matching the Drift uniqueKeys.
--      Postgres treats NULLs as distinct in unique indexes, so we use a
--      UNIQUE INDEX with COALESCE to keep the "one tuition per month" guard.
--
-- Safe to run more than once (all statements use IF NOT EXISTS / IF EXISTS).

BEGIN;

-- 1. Add the column ----------------------------------------------------------
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
     WHERE table_name = 'fee_challans' AND column_name = 'title'
  ) THEN
    ALTER TABLE fee_challans ADD COLUMN title TEXT;
  END IF;
END $$;

-- 2. Replace unique constraint ------------------------------------------------
-- Drop the old constraint (student_id, month, year).
-- The auto-generated name is fee_challans_student_id_month_year_key.
ALTER TABLE fee_challans
  DROP CONSTRAINT IF EXISTS fee_challans_student_id_month_year_key;

-- Create a unique index that treats NULL title the same as any other value,
-- so "one plain tuition per student per month" is still enforced, while custom
-- challans (non-NULL title) get their own slot.
CREATE UNIQUE INDEX IF NOT EXISTS uq_challans_student_month_year_title
  ON fee_challans (student_id, month, year, COALESCE(title, ''));

COMMIT;

-- VERIFY ----------------------------------------------------------------------
-- Run after applying to confirm the migration took effect.
--
-- 1. Column exists:
--    SELECT column_name, data_type, is_nullable
--      FROM information_schema.columns
--     WHERE table_name = 'fee_challans' AND column_name = 'title';
--    → should return one row: title | text | YES
--
-- 2. Old constraint is gone:
--    SELECT constraint_name FROM information_schema.table_constraints
--     WHERE table_name = 'fee_challans' AND constraint_type = 'UNIQUE';
--    → should NOT contain 'fee_challans_student_id_month_year_key'
--
-- 3. New index exists:
--    SELECT indexname FROM pg_indexes
--     WHERE tablename = 'fee_challans' AND indexname = 'uq_challans_student_month_year_title';
--    → should return one row
