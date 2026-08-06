-- ============================================================================
--  DATA CHECK — what has actually reached the server
--  Run in: Supabase dashboard → SQL Editor
--
--  Read-only. Safe to run any time.
-- ============================================================================

-- ─────────────────────────────────────────────────────────────────────────
--  1. ROW COUNTS — the "did sync work" query
-- ─────────────────────────────────────────────────────────────────────────
--  `live` excludes tombstoned rows (deleted_at IS NOT NULL). Nothing is ever
--  hard-deleted, so `total` and `live` diverging is normal, not a fault.

SELECT 'schools'            AS table_name, count(*) AS total, count(*) FILTER (WHERE deleted_at IS NULL) AS live FROM schools
UNION ALL SELECT 'academic_years',            count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM academic_years
UNION ALL SELECT 'classes',                   count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM classes
UNION ALL SELECT 'subjects',                  count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM subjects
UNION ALL SELECT 'app_users',                 count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM app_users
UNION ALL SELECT 'teachers',                  count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM teachers
UNION ALL SELECT 'students',                  count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM students
UNION ALL SELECT 'attendance',                count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM attendance
UNION ALL SELECT 'teacher_attendance',        count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM teacher_attendance
UNION ALL SELECT 'exams',                     count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM exams
UNION ALL SELECT 'marks',                     count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM marks
UNION ALL SELECT 'fee_structures',            count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM fee_structures
UNION ALL SELECT 'fee_challans',              count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM fee_challans
UNION ALL SELECT 'timetable_slots',           count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM timetable_slots
UNION ALL SELECT 'assignments',               count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM assignments
UNION ALL SELECT 'notices',                   count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM notices
UNION ALL SELECT 'lost_items',                count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM lost_items
UNION ALL SELECT 'item_claims',               count(*), count(*) FILTER (WHERE deleted_at IS NULL) FROM item_claims
ORDER BY total DESC;


-- ─────────────────────────────────────────────────────────────────────────
--  2. STUDENTS WITH THEIR CLASS
-- ─────────────────────────────────────────────────────────────────────────
--
--   SELECT s.admission_no, s.roll_no, s.full_name, s.father_name,
--          c.display_name AS class, s.status
--   FROM students s
--   LEFT JOIN classes c ON c.id = s.class_id
--   WHERE s.deleted_at IS NULL
--   ORDER BY c.grade, c.section, s.roll_no;


-- ─────────────────────────────────────────────────────────────────────────
--  3. ATTENDANCE SUMMARY PER STUDENT
-- ─────────────────────────────────────────────────────────────────────────
--  Mirrors the shared formula: (present + late) / (total - holiday).
--  If this disagrees with the app, one of the two is wrong — they must match.
--
--   SELECT s.full_name,
--          c.display_name AS class,
--          count(*) FILTER (WHERE a.status = 'present')  AS present,
--          count(*) FILTER (WHERE a.status = 'absent')   AS absent,
--          count(*) FILTER (WHERE a.status = 'leave')    AS on_leave,
--          count(*) FILTER (WHERE a.status = 'late')     AS late,
--          count(*) FILTER (WHERE a.status = 'holiday')  AS holiday,
--          round(
--            100.0 * count(*) FILTER (WHERE a.status IN ('present','late'))
--            / NULLIF(count(*) FILTER (WHERE a.status <> 'holiday'), 0)
--          , 1) AS pct
--   FROM attendance a
--   JOIN students s ON s.id = a.student_id
--   LEFT JOIN classes c ON c.id = a.class_id
--   WHERE a.deleted_at IS NULL
--   GROUP BY s.full_name, c.display_name, c.grade, c.section
--   ORDER BY pct NULLS LAST;


-- ─────────────────────────────────────────────────────────────────────────
--  4. FACULTY REGISTER
-- ─────────────────────────────────────────────────────────────────────────
--
--   SELECT t.full_name, t.employee_no, ta.date, ta.status,
--          ta.check_in_time, ta.remarks
--   FROM teacher_attendance ta
--   JOIN teachers t ON t.id = ta.teacher_id
--   WHERE ta.deleted_at IS NULL
--   ORDER BY ta.date DESC, t.full_name
--   LIMIT 50;


-- ─────────────────────────────────────────────────────────────────────────
--  5. FEES — defaulters
-- ─────────────────────────────────────────────────────────────────────────
--
--   SELECT s.full_name, c.display_name AS class, f.challan_no,
--          f.total_amount, f.paid_amount,
--          f.total_amount - f.paid_amount AS outstanding,
--          f.due_date, f.status
--   FROM fee_challans f
--   JOIN students s ON s.id = f.student_id
--   LEFT JOIN classes c ON c.id = f.class_id
--   WHERE f.deleted_at IS NULL
--     AND f.status IN ('unpaid','partial')
--     AND f.due_date < CURRENT_DATE
--   ORDER BY outstanding DESC;


-- ─────────────────────────────────────────────────────────────────────────
--  6. SYNC HEALTH
-- ─────────────────────────────────────────────────────────────────────────
--  Every syncable row must have a server_seq, or a cursor-based pull will
--  never see it. All of these must return 0.
--
--   SELECT 'students' AS t, count(*) FROM students WHERE server_seq IS NULL
--   UNION ALL SELECT 'attendance', count(*) FROM attendance WHERE server_seq IS NULL
--   UNION ALL SELECT 'teacher_attendance', count(*) FROM teacher_attendance WHERE server_seq IS NULL
--   UNION ALL SELECT 'classes', count(*) FROM classes WHERE server_seq IS NULL
--   UNION ALL SELECT 'subjects', count(*) FROM subjects WHERE server_seq IS NULL;
--
--  Highest sequence issued so far — the cursor a client would pull from:
--
--   SELECT max(server_seq) FROM attendance;
-- ============================================================================
