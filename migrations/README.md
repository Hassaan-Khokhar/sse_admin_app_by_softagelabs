# Migrations

Numbered SQL files applied **in order** on top of `schema.sql`. Every one is
safe to run more than once.

`schema.sql` remains the full picture of the schema for anyone starting fresh.
These files are the deltas applied to a database that already exists.

## Applying to Supabase

Supabase dashboard → **SQL Editor** → paste the file → **Run**. The SQL editor
runs as `postgres`, so it bypasses RLS — which is exactly what you need, since
some of these change RLS itself. No secret key required, and nothing needs to
be stored anywhere.

Run them in numeric order. Check the `VERIFY` block at the bottom of each file
afterwards.

## Testing before you apply

You have PostgreSQL 18 locally on port **5433**, so a migration can be proven
against a throwaway database before it touches the real project:

```powershell
$psql = "C:\Program Files\PostgreSQL\18\bin\psql.exe"
$A = @("-h","localhost","-p","5433","-U","postgres","-w")

& $psql @A -c "DROP DATABASE IF EXISTS sse_schema_check;" -c "CREATE DATABASE sse_schema_check;"

# Supabase's auth.uid() does not exist locally — stub it.
& $psql @A -d sse_schema_check -c "CREATE SCHEMA IF NOT EXISTS auth;
  CREATE OR REPLACE FUNCTION auth.uid() RETURNS uuid AS 'SELECT NULL::uuid' LANGUAGE sql STABLE;"

& $psql @A -d sse_schema_check -v ON_ERROR_STOP=1 -f ..\schema.sql
& $psql @A -d sse_schema_check -v ON_ERROR_STOP=1 -f 001_rls_hardening.sql
& $psql @A -d sse_schema_check -v ON_ERROR_STOP=1 -f 002_server_seq_triggers.sql
```

This is not optional ceremony — it caught two real bugs in 001 and 002 before
they reached the live project (`fee_structures` left unprotected, and duplicate
`server_seq` triggers on two tables).

To drop the scratch database when done:

```powershell
& $psql @A -c "DROP DATABASE IF EXISTS sse_schema_check;"
```

---

## 001 · RLS hardening

Closes two gaps in `schema.sql` §9.

**Eight tables had no RLS at all** — `schools`, `academic_years`, `app_users`,
`teachers`, `teacher_class_assignments`, `fee_structures`, `change_log`,
`sync_ops`. The publishable key could read and write every one of them.

The serious one was `app_users`. `current_role_name()` is defined as
`SELECT role FROM app_users WHERE id = auth.uid()`, and every admin policy
trusts its answer — so a student who could `UPDATE` their own row to
`role='super_admin'` inherited full access to everything else. The escalation
ran through the one table nobody protected.

**Six tables had RLS on but only student policies** — `exams`, `subjects`,
`classes`, `notices`, `assignments`, `timetable_slots`. RLS denies by default,
so the *principal* could not read them. `schema.sql:618` said "(repeat the same
shape …)" and it was never done. The admin app would have come up blank.

Also in 001: `search_path` pinned on the `SECURITY DEFINER` helpers, `deleted_at`
respected when resolving identity, and withdrawn accounts (`is_active = false`)
cut off at the database rather than only in the client.

## 002 · server_seq triggers

`schema.sql` §10 stamps `server_seq` on five tables and then says
"add the same trigger to every remaining syncable table". Thirteen were missing.

`server_seq` **is** the sync cursor — clients pull `WHERE server_seq > cursor`,
and a NULL never satisfies that. Those thirteen tables would have synced to no
device, ever. The prototype hides this because it pulls by `updated_at`
(CLAUDE.md §10), so the bug would only have surfaced on the switch to real
cursor-based sync, long after the cause was forgotten.

Now driven by one list in a loop, so it cannot drift again. Includes a backfill
for rows already inserted with a NULL `server_seq`.

## 004 · fee_challans title column

The local Drift schema added a nullable `title` column to `fee_challans` so that
custom challans ("Sports Fine", "Lab Fee") can coexist alongside monthly tuition
for the same student/month. Postgres was never updated, so `SyncEngine.push()`
failed with:

    Could not find the 'title' column of 'fee_challans' in the schema

This migration adds the column and replaces the old
`UNIQUE(student_id, month, year)` constraint with an index on
`(student_id, month, year, COALESCE(title, ''))` — NULL titles (regular
tuition) still can't duplicate, while named custom challans get their own slot.

---

## Message for the student-app dev

> Two migrations on `sse_portal`, both applied — `001_rls_hardening.sql` and
> `002_server_seq_triggers.sql`.
>
> **No columns changed and no enum strings changed**, so nothing in your app
> needs to change and `schema.sql` is still the contract.
>
> What *did* change is what the publishable key can reach. Eight tables had no
> RLS and now do. If the student app was reading `schools`, `academic_years` or
> `teachers` directly, expect different results:
>
> - `schools` / `academic_years` — still readable, scoped to the signed-in
>   user's school
> - `teachers` — **now returns nothing** for students. It holds CNICs and
>   personal phone numbers, and RLS is row-level so there's no way to expose
>   just the name. If you need teacher names on the timetable, ask and I'll
>   denormalise the name onto `timetable_slots` / `subjects`.
> - `app_users` — a user sees only their own row, and can no longer UPDATE it
>   (including `last_login_at`; say the word if you need that and I'll add a
>   narrow function for it)
>
> New: students can now read `exams` for **published** exams, which they
> couldn't before — your marksheet can name the exam it belongs to.
>
> Withdrawn accounts (`app_users.is_active = false`) are now cut off by the
> database, not just by your client-side check. Worth testing that the app
> handles empty results gracefully rather than showing a spinner forever.
