-- ============================================================================
--  SCHOOL MANAGEMENT SYSTEM  —  schema.sql   (v1 · prototype)
--  Target : PostgreSQL (Supabase)
--  Mirror : SQLite/Drift on desktop + mobile — SAME names, SAME enum strings
--
--  ⚠️  THIS FILE IS THE CONTRACT BETWEEN THE TWO APPS.
--      Admin app owns it. Student app consumes it.
--      Any change = new numbered migration file + tell the other dev.
-- ============================================================================


-- ============================================================================
--  CONVENTIONS  (read this before writing any Dart)
-- ============================================================================
--
--  1. IDs are UUIDv7, GENERATED ON THE CLIENT — never by the database.
--     A teacher offline marking 40 students needs IDs immediately.
--     Dart:  uuid.v7()   (package:uuid ^4.x)
--
--  2. Enums are TEXT + CHECK, never Postgres ENUM type.
--     Reason: SQLite has no enum type. TEXT keeps both schemas identical.
--     The exact strings below are part of the contract. Do not improvise.
--
--  3. NEVER DELETE A ROW. Set deleted_at instead (tombstone).
--     A hard delete cannot be synced — a missing row is invisible to peers.
--     Also: a withdrawn student's 3 years of records must survive.
--
--  4. Every syncable table carries the same 4 sync columns:
--        updated_at   TIMESTAMPTZ  — set by the client on every write
--        deleted_at   TIMESTAMPTZ  — NULL = alive, non-NULL = tombstone
--        server_seq   BIGINT       — set by the server, the sync cursor
--        version      INT          — optimistic concurrency
--
--  5. PG → SQLite type mapping (for the Drift side):
--        UUID        → TEXT
--        TIMESTAMPTZ → TEXT   (ISO-8601 UTC, always with 'Z')
--        DATE        → TEXT   ('YYYY-MM-DD')
--        JSONB       → TEXT   (json-encoded)
--        BOOLEAN     → INTEGER (0/1)
--        NUMERIC     → REAL
--
--  6. All money is PKR, stored as NUMERIC(10,2).
-- ============================================================================


-- ============================================================================
--  SECTION 1 · REFERENCE
-- ============================================================================

CREATE TABLE schools (
    id              UUID PRIMARY KEY,
    name            TEXT NOT NULL,
    address         TEXT,
    phone           TEXT,
    logo_url        TEXT,

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1
);

CREATE TABLE academic_years (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    name            TEXT NOT NULL,              -- '2026-2027'
    start_date      DATE NOT NULL,
    end_date        DATE NOT NULL,
    is_current      BOOLEAN NOT NULL DEFAULT false,

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1
);

-- A "class" here = grade + section together, e.g. grade 9 section A.
CREATE TABLE classes (
    id                UUID PRIMARY KEY,
    school_id         UUID NOT NULL REFERENCES schools(id),
    academic_year_id  UUID NOT NULL REFERENCES academic_years(id),
    grade             INT  NOT NULL,            -- 1..12
    section           TEXT NOT NULL,            -- 'A', 'B'
    display_name      TEXT NOT NULL,            -- '9-A'  (denormalised for UI)
    class_teacher_id  UUID,                     -- → teachers.id
    room              TEXT,

    updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at        TIMESTAMPTZ,
    server_seq        BIGINT,
    version           INT NOT NULL DEFAULT 1,

    UNIQUE (school_id, academic_year_id, grade, section)
);

-- Subjects belong to a CLASS, not to a student.
-- Everyone in 9-A takes the same subjects. This is the school model
-- (vs university, where each student picks their own courses).
-- The student app's subject grid = SELECT * FROM subjects WHERE class_id = my_class.
-- That is the whole "dynamic per student" requirement — no special logic needed.
CREATE TABLE subjects (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    class_id        UUID NOT NULL REFERENCES classes(id),
    name            TEXT NOT NULL,              -- 'Mathematics'
    code            TEXT,                       -- 'MATH'
    teacher_id      UUID,                       -- → teachers.id
    total_marks     INT NOT NULL DEFAULT 100,
    sort_order      INT NOT NULL DEFAULT 0,
    icon            TEXT,                       -- icon key for the grid tile

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1
);


-- ============================================================================
--  SECTION 2 · PEOPLE & ACCESS  (RBAC)
-- ============================================================================

-- Mirrors Supabase auth.users. id == auth.users.id.
CREATE TABLE app_users (
    id              UUID PRIMARY KEY,           -- = auth.users.id
    school_id       UUID NOT NULL REFERENCES schools(id),
    role            TEXT NOT NULL
                    CHECK (role IN ('super_admin','teacher','student')),
    email           TEXT,
    phone           TEXT,
    full_name       TEXT NOT NULL,
    is_active       BOOLEAN NOT NULL DEFAULT true,
    last_login_at   TIMESTAMPTZ,

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1
);
--  ROLES
--    super_admin — principal. Full access. THE ONLY ROLE BUILT IN THE PROTOTYPE.
--    teacher     — schema ready, UI deferred. Scoped to assigned classes.
--    student     — read-only, except lost_items + item_claims.

CREATE TABLE teachers (
    id              UUID PRIMARY KEY,
    user_id         UUID REFERENCES app_users(id),
    school_id       UUID NOT NULL REFERENCES schools(id),
    employee_no     TEXT,
    full_name       TEXT NOT NULL,
    cnic            TEXT,
    phone           TEXT,
    qualification   TEXT,
    joining_date    DATE,
    photo_url       TEXT,
    is_active       BOOLEAN NOT NULL DEFAULT true,

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1,

    UNIQUE (school_id, employee_no)
);

-- Deferred for the prototype (principal-only), but the table exists now so
-- enabling the teacher role later is seeding rows, not a migration.
CREATE TABLE teacher_class_assignments (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    teacher_id      UUID NOT NULL REFERENCES teachers(id),
    class_id        UUID NOT NULL REFERENCES classes(id),
    subject_id      UUID REFERENCES subjects(id),   -- NULL = class teacher
    can_mark_attendance BOOLEAN NOT NULL DEFAULT false,

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1
);

CREATE TABLE students (
    id                UUID PRIMARY KEY,
    user_id           UUID REFERENCES app_users(id),
    school_id         UUID NOT NULL REFERENCES schools(id),
    class_id          UUID REFERENCES classes(id),

    admission_no      TEXT NOT NULL,            -- '2026-0341'  (school-wide, permanent)
    roll_no           INT,                      -- 23           (within the class, resets yearly)
    full_name         TEXT NOT NULL,
    father_name       TEXT,
    guardian_phone    TEXT,
    date_of_birth     DATE,
    gender            TEXT CHECK (gender IN ('male','female')),
    address           TEXT,
    photo_url         TEXT,

    admission_date    DATE,
    status            TEXT NOT NULL DEFAULT 'active'
                      CHECK (status IN ('active','withdrawn','graduated','suspended')),
    left_date         DATE,
    left_reason       TEXT,

    updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at        TIMESTAMPTZ,
    server_seq        BIGINT,
    version           INT NOT NULL DEFAULT 1,

    UNIQUE (school_id, admission_no)
);
-- ⚠️  Withdrawing a student = status='withdrawn' + app_users.is_active=false.
--     NEVER delete the row — attendance, marks and fee history must survive.
--     The student app checks is_active on every sync and logs out if false.

CREATE INDEX idx_students_class ON students(class_id) WHERE deleted_at IS NULL;


-- ============================================================================
--  SECTION 3 · ATTENDANCE
-- ============================================================================

-- DAILY attendance — one row per student per day.
-- Decision: the class teacher marks the whole class once each morning.
-- (Per-period attendance was considered and rejected: 8x the rows and
--  8x the teacher's work, and it isn't how the school actually operates.)
CREATE TABLE attendance (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    student_id      UUID NOT NULL REFERENCES students(id),
    class_id        UUID NOT NULL REFERENCES classes(id),
    date            DATE NOT NULL,

    status          TEXT NOT NULL
                    CHECK (status IN ('present','absent','leave','late','holiday')),
    remarks         TEXT,
    marked_by       UUID NOT NULL REFERENCES app_users(id),
    marked_at       TIMESTAMPTZ NOT NULL DEFAULT now(),

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1,

    -- IDEMPOTENCY: marking the same day twice UPDATES, never duplicates.
    -- This is what makes offline retries safe. Do not drop this constraint.
    UNIQUE (student_id, date)
);

CREATE INDEX idx_attendance_student_date ON attendance(student_id, date);
CREATE INDEX idx_attendance_class_date   ON attendance(class_id, date);

--  STATUS COLOURS — student app monthly calendar (contract with mobile dev):
--    present  🟢 green      absent  🔴 red       leave   🟡 yellow
--    late     🟠 orange     holiday ⬜ grey
--  Attendance % = present + late  /  (total - holiday)


-- ============================================================================
--  SECTION 4 · EXAMS & MARKS
-- ============================================================================

CREATE TABLE exams (
    id                UUID PRIMARY KEY,
    school_id         UUID NOT NULL REFERENCES schools(id),
    academic_year_id  UUID NOT NULL REFERENCES academic_years(id),
    name              TEXT NOT NULL,            -- 'First Term'
    exam_type         TEXT NOT NULL
                      CHECK (exam_type IN ('first_term','mid_term','final_term','test','quiz')),
    start_date        DATE,
    end_date          DATE,
    is_published      BOOLEAN NOT NULL DEFAULT false,   -- false = hidden from students

    updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at        TIMESTAMPTZ,
    server_seq        BIGINT,
    version           INT NOT NULL DEFAULT 1
);
-- is_published is the gate: the principal enters marks over several days,
-- then flips one switch and every student sees their result at once.
-- Great demo moment. Also stops half-entered results leaking.

CREATE TABLE marks (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    exam_id         UUID NOT NULL REFERENCES exams(id),
    student_id      UUID NOT NULL REFERENCES students(id),
    subject_id      UUID NOT NULL REFERENCES subjects(id),
    class_id        UUID NOT NULL REFERENCES classes(id),

    obtained_marks  NUMERIC(6,2),
    total_marks     NUMERIC(6,2) NOT NULL DEFAULT 100,
    is_absent       BOOLEAN NOT NULL DEFAULT false,
    grade           TEXT,                       -- 'A+','A','B'… computed on save
    remarks         TEXT,
    entered_by      UUID REFERENCES app_users(id),

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1,

    UNIQUE (exam_id, student_id, subject_id)    -- idempotent, same as attendance
);

CREATE INDEX idx_marks_student ON marks(student_id, exam_id);

--  GRADE SCALE (both apps must use the SAME function — put it in school_core):
--    >=90 A+ | >=80 A | >=70 B | >=60 C | >=50 D | >=40 E | else F


-- ============================================================================
--  SECTION 5 · FEES
-- ============================================================================

-- Per-class fee amounts. "Manage fees for every class" from the sketch.
CREATE TABLE fee_structures (
    id                UUID PRIMARY KEY,
    school_id         UUID NOT NULL REFERENCES schools(id),
    academic_year_id  UUID NOT NULL REFERENCES academic_years(id),
    class_id          UUID REFERENCES classes(id),   -- NULL = applies school-wide
    tuition_fee       NUMERIC(10,2) NOT NULL DEFAULT 0,
    admission_fee     NUMERIC(10,2) NOT NULL DEFAULT 0,
    exam_fee          NUMERIC(10,2) NOT NULL DEFAULT 0,
    other_fee         NUMERIC(10,2) NOT NULL DEFAULT 0,
    other_label       TEXT,

    updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at        TIMESTAMPTZ,
    server_seq        BIGINT,
    version           INT NOT NULL DEFAULT 1
);

-- ONE-CLICK BULK GENERATION generates one row per active student.
-- 800 students → 800 rows in a single local transaction, then synced.
-- This is the strongest moment in the demo video.
CREATE TABLE fee_challans (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    student_id      UUID NOT NULL REFERENCES students(id),
    class_id        UUID NOT NULL REFERENCES classes(id),

    challan_no      TEXT NOT NULL,              -- 'CH-2026-08-0341'
    month           INT  NOT NULL CHECK (month BETWEEN 1 AND 12),
    year            INT  NOT NULL,

    tuition_fee     NUMERIC(10,2) NOT NULL DEFAULT 0,
    admission_fee   NUMERIC(10,2) NOT NULL DEFAULT 0,
    exam_fee        NUMERIC(10,2) NOT NULL DEFAULT 0,
    other_fee       NUMERIC(10,2) NOT NULL DEFAULT 0,
    arrears         NUMERIC(10,2) NOT NULL DEFAULT 0,   -- carried from unpaid months
    discount        NUMERIC(10,2) NOT NULL DEFAULT 0,
    fine            NUMERIC(10,2) NOT NULL DEFAULT 0,
    total_amount    NUMERIC(10,2) NOT NULL,

    issue_date      DATE NOT NULL,
    due_date        DATE NOT NULL,
    status          TEXT NOT NULL DEFAULT 'unpaid'
                    CHECK (status IN ('unpaid','paid','partial','cancelled')),
    paid_amount     NUMERIC(10,2) NOT NULL DEFAULT 0,
    paid_date       DATE,
    payment_method  TEXT CHECK (payment_method IN ('cash','bank','online')),
    received_by     UUID REFERENCES app_users(id),

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1,

    UNIQUE (student_id, month, year)            -- can't double-bill a month
);

CREATE INDEX idx_challans_student ON fee_challans(student_id, year, month);
CREATE INDEX idx_challans_status  ON fee_challans(status) WHERE status = 'unpaid';
-- Defaulter list = SELECT … WHERE status='unpaid' AND due_date < today

-- ⚠️  NO PAYMENT GATEWAY. The student app DISPLAYS the challan only.
--     Payment is recorded by the office in the admin app.


-- ============================================================================
--  SECTION 6 · TIMETABLE · ASSIGNMENTS · NOTICES
-- ============================================================================

-- Timetable belongs to the CLASS, not the student.
-- 40 students share one timetable — the school model, 40x less data
-- than the university per-student model the current app uses.
CREATE TABLE timetable_slots (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    class_id        UUID NOT NULL REFERENCES classes(id),
    subject_id      UUID REFERENCES subjects(id),   -- NULL = break / assembly
    teacher_id      UUID REFERENCES teachers(id),

    day_of_week     INT  NOT NULL CHECK (day_of_week BETWEEN 1 AND 7),  -- 1=Mon
    period_no       INT  NOT NULL,
    start_time      TEXT NOT NULL,              -- '08:00'
    end_time        TEXT NOT NULL,              -- '08:40'
    slot_type       TEXT NOT NULL DEFAULT 'class'
                    CHECK (slot_type IN ('class','break','assembly')),

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1,

    UNIQUE (class_id, day_of_week, period_no)
);

CREATE TABLE assignments (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    class_id        UUID NOT NULL REFERENCES classes(id),
    subject_id      UUID REFERENCES subjects(id),
    title           TEXT NOT NULL,
    description     TEXT,
    attachment_url  TEXT,
    assigned_date   DATE NOT NULL,
    due_date        DATE,
    created_by      UUID REFERENCES app_users(id),

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1
);
-- View only. Students do NOT submit through the app (v1 scope).

CREATE TABLE notices (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    class_id        UUID REFERENCES classes(id),     -- NULL = whole school
    title           TEXT NOT NULL,
    body            TEXT NOT NULL,
    attachment_url  TEXT,
    priority        TEXT NOT NULL DEFAULT 'normal'
                    CHECK (priority IN ('normal','important','urgent')),
    publish_date    DATE NOT NULL,
    expires_at      DATE,
    created_by      UUID REFERENCES app_users(id),

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1
);


-- ============================================================================
--  SECTION 7 · LOST & FOUND   (the only tables students may WRITE to)
-- ============================================================================

CREATE TABLE lost_items (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    type            TEXT NOT NULL CHECK (type IN ('lost','found')),
    title           TEXT NOT NULL,
    description     TEXT,
    category        TEXT CHECK (category IN
                    ('bottle','book','uniform','electronics','keys','stationery','bag','other')),
    location        TEXT,                       -- 'near canteen', 'ground'
    incident_date   DATE,

    reported_by     UUID NOT NULL REFERENCES app_users(id),
    status          TEXT NOT NULL DEFAULT 'open'
                    CHECK (status IN ('open','claimed','resolved','expired')),

    -- moderation: 800 teenagers + free text + photos. Non-optional.
    moderation      TEXT NOT NULL DEFAULT 'visible'
                    CHECK (moderation IN ('visible','hidden','removed')),
    report_count    INT NOT NULL DEFAULT 0,     -- auto-hide at 3
    moderated_by    UUID REFERENCES app_users(id),

    photos          JSONB DEFAULT '[]',         -- [{key,url,thumb_url}]
    expires_at      TIMESTAMPTZ,                -- auto-archive after 30 days

    -- Feed ordering key. Deliberately NOT updated_at: moderation and the
    -- report counter bump updated_at, which would reshuffle the feed.
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1
);

CREATE INDEX idx_lost_items_feed ON lost_items(school_id, status, created_at)
    WHERE deleted_at IS NULL;

-- ⚠️  PHOTO RULES (these control your entire cloud bill — everything else is tiny)
--       · compress to max 1200px / ~200 KB before upload
--       · generate a ~30 KB thumbnail; list view uses thumbs ONLY
--       · max 3 photos per item, max 5 posts per student per week
--       · upload the FILE first, push the ROW second (else broken images)
--       · delete photos when expires_at passes

CREATE TABLE item_claims (
    id              UUID PRIMARY KEY,
    school_id       UUID NOT NULL REFERENCES schools(id),
    item_id         UUID NOT NULL REFERENCES lost_items(id),
    claimed_by      UUID NOT NULL REFERENCES app_users(id),
    message         TEXT,
    status          TEXT NOT NULL DEFAULT 'pending'
                    CHECK (status IN ('pending','approved','rejected')),
    handled_by      UUID REFERENCES app_users(id),

    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ,
    server_seq      BIGINT,
    version         INT NOT NULL DEFAULT 1
);

-- ⚠️  SAFETY — these are minors.
--     Claims go to the OFFICE, never student-to-student.
--     NEVER expose a student's phone number or contact details in the app.
--     The app is a notice board; the office does the handover.


-- ============================================================================
--  SECTION 8 · SYNC INFRASTRUCTURE
-- ============================================================================

-- Server-side append-only log. The spine of sync.
-- Every client stores a cursor (last seen seq) and pulls seq > cursor.
-- Prototype note: you may pull by updated_at instead and add this later —
-- but create the table now so the switch is additive.
CREATE TABLE change_log (
    seq             BIGSERIAL PRIMARY KEY,
    school_id       UUID NOT NULL,
    table_name      TEXT NOT NULL,
    row_id          UUID NOT NULL,
    op              TEXT NOT NULL CHECK (op IN ('upsert','delete')),
    payload         JSONB NOT NULL,
    student_id      UUID,                       -- scoping key
    class_id        UUID,                       -- scoping key
    actor_id        UUID,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_change_log_pull    ON change_log(school_id, seq);
CREATE INDEX idx_change_log_student ON change_log(student_id, seq);

-- Idempotency ledger: dedupes retried pushes when the connection drops
-- mid-request. Without this you get duplicate rows on every flaky sync.
CREATE TABLE sync_ops (
    op_id           UUID PRIMARY KEY,           -- generated by the client
    device_id       TEXT NOT NULL,
    actor_id        UUID NOT NULL,
    applied_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ----------------------------------------------------------------------------
--  LOCAL-ONLY TABLES  (SQLite/Drift — do NOT create these in Postgres)
-- ----------------------------------------------------------------------------
--  outbox(
--      op_id TEXT PK, table_name TEXT, row_id TEXT, op TEXT,
--      payload TEXT, created_at TEXT, attempts INT, last_error TEXT)
--
--  attachment_outbox(
--      id TEXT PK, local_path TEXT, storage_key TEXT,
--      status TEXT, attempts INT)          -- photos: separate pipeline
--
--  sync_state(key TEXT PK, value TEXT)     -- 'cursor', 'last_synced_at'
-- ----------------------------------------------------------------------------


-- ============================================================================
--  SECTION 9 · ROW LEVEL SECURITY
-- ============================================================================
--
--  🚨 CRITICAL — DO NOT SKIP THIS, EVEN FOR THE PROTOTYPE.
--
--  The Supabase ANON KEY is compiled into the Flutter app. Anyone who
--  downloads the APK can extract it in about 30 seconds. RLS is the ONLY
--  thing standing between that key and your entire database.
--
--  Without RLS, any student can read every student's marks and fees —
--  and write to them.
-- ============================================================================

CREATE OR REPLACE FUNCTION current_role_name() RETURNS TEXT AS $$
    SELECT role FROM app_users WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE OR REPLACE FUNCTION current_school_id() RETURNS UUID AS $$
    SELECT school_id FROM app_users WHERE id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE OR REPLACE FUNCTION current_student_id() RETURNS UUID AS $$
    SELECT id FROM students WHERE user_id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

CREATE OR REPLACE FUNCTION current_class_id() RETURNS UUID AS $$
    SELECT class_id FROM students WHERE user_id = auth.uid();
$$ LANGUAGE sql STABLE SECURITY DEFINER;

ALTER TABLE students      ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendance    ENABLE ROW LEVEL SECURITY;
ALTER TABLE marks         ENABLE ROW LEVEL SECURITY;
ALTER TABLE fee_challans  ENABLE ROW LEVEL SECURITY;
ALTER TABLE exams         ENABLE ROW LEVEL SECURITY;
ALTER TABLE subjects      ENABLE ROW LEVEL SECURITY;
ALTER TABLE classes       ENABLE ROW LEVEL SECURITY;
ALTER TABLE notices       ENABLE ROW LEVEL SECURITY;
ALTER TABLE assignments   ENABLE ROW LEVEL SECURITY;
ALTER TABLE timetable_slots ENABLE ROW LEVEL SECURITY;
ALTER TABLE lost_items    ENABLE ROW LEVEL SECURITY;
ALTER TABLE item_claims   ENABLE ROW LEVEL SECURITY;

-- ── Principal: full access to their own school ──────────────────────────────
CREATE POLICY admin_all_students ON students FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());
CREATE POLICY admin_all_attendance ON attendance FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());
CREATE POLICY admin_all_marks ON marks FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());
CREATE POLICY admin_all_challans ON fee_challans FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());
CREATE POLICY admin_all_lost ON lost_items FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());
CREATE POLICY admin_all_claims ON item_claims FOR ALL
    USING (current_role_name() = 'super_admin' AND school_id = current_school_id());
-- (repeat the same shape for exams, subjects, classes, notices,
--  assignments, timetable_slots)

-- ── Student: READ their own private data only ───────────────────────────────
CREATE POLICY student_own_row ON students FOR SELECT
    USING (id = current_student_id());
CREATE POLICY student_own_attendance ON attendance FOR SELECT
    USING (student_id = current_student_id());
CREATE POLICY student_own_marks ON marks FOR SELECT
    USING (student_id = current_student_id()
           AND EXISTS (SELECT 1 FROM exams e
                       WHERE e.id = marks.exam_id AND e.is_published));
CREATE POLICY student_own_challans ON fee_challans FOR SELECT
    USING (student_id = current_student_id());

-- ── Student: READ shared class/school data ──────────────────────────────────
CREATE POLICY student_class_subjects ON subjects FOR SELECT
    USING (class_id = current_class_id());
CREATE POLICY student_class_timetable ON timetable_slots FOR SELECT
    USING (class_id = current_class_id());
CREATE POLICY student_class_assignments ON assignments FOR SELECT
    USING (class_id = current_class_id());
CREATE POLICY student_notices ON notices FOR SELECT
    USING (school_id = current_school_id()
           AND (class_id IS NULL OR class_id = current_class_id()));

-- ── Student: Lost & Found — the ONLY place they may write ───────────────────
CREATE POLICY student_read_lost ON lost_items FOR SELECT
    USING (school_id = current_school_id() AND moderation = 'visible');
CREATE POLICY student_create_lost ON lost_items FOR INSERT
    WITH CHECK (reported_by = auth.uid() AND school_id = current_school_id());
CREATE POLICY student_edit_own_lost ON lost_items FOR UPDATE
    USING (reported_by = auth.uid());

CREATE POLICY student_create_claim ON item_claims FOR INSERT
    WITH CHECK (claimed_by = auth.uid());
CREATE POLICY student_read_own_claim ON item_claims FOR SELECT
    USING (claimed_by = auth.uid());

--  ⚠️  Note there is deliberately NO student INSERT/UPDATE policy on
--      attendance, marks, fee_challans or exams. RLS denies by default,
--      so a student physically cannot write their own grades.
--      Verify this by hand before the demo: log in as a student and try.


-- ============================================================================
--  SECTION 10 · AUTO-STAMP server_seq  (server-side, keeps the cursor honest)
-- ============================================================================

CREATE SEQUENCE global_seq;

CREATE OR REPLACE FUNCTION stamp_server_seq() RETURNS TRIGGER AS $$
BEGIN
    NEW.server_seq := nextval('global_seq');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_seq_students   BEFORE INSERT OR UPDATE ON students
    FOR EACH ROW EXECUTE FUNCTION stamp_server_seq();
CREATE TRIGGER trg_seq_attendance BEFORE INSERT OR UPDATE ON attendance
    FOR EACH ROW EXECUTE FUNCTION stamp_server_seq();
CREATE TRIGGER trg_seq_marks      BEFORE INSERT OR UPDATE ON marks
    FOR EACH ROW EXECUTE FUNCTION stamp_server_seq();
CREATE TRIGGER trg_seq_challans   BEFORE INSERT OR UPDATE ON fee_challans
    FOR EACH ROW EXECUTE FUNCTION stamp_server_seq();
CREATE TRIGGER trg_seq_lost       BEFORE INSERT OR UPDATE ON lost_items
    FOR EACH ROW EXECUTE FUNCTION stamp_server_seq();
-- add the same trigger to every remaining syncable table

-- ============================================================================
--  END
-- ============================================================================
