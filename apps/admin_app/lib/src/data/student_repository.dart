import 'package:drift/drift.dart';
import 'package:school_core/school_core.dart';

/// Enrolment, editing and withdrawal.
class StudentRepository {
  StudentRepository(this._db) : _writer = OutboxWriter(_db);

  final AppDatabase _db;
  final OutboxWriter _writer;

  Stream<List<SchoolClass>> watchClasses() {
    final query = _db.select(_db.classes)
      ..where((c) => c.deletedAt.isNull())
      ..orderBy([
        (c) => OrderingTerm.asc(c.grade),
        (c) => OrderingTerm.asc(c.section),
      ]);
    return query.watch();
  }

  /// Students, optionally filtered by class and free-text search.
  ///
  /// Withdrawn students are included when [includeInactive] is set. They are
  /// never deleted (schema.sql convention 3), so the principal must be able to
  /// find them — a leaving certificate request arrives months later.
  Stream<List<Student>> watchStudents({
    String? classId,
    String search = '',
    bool includeInactive = false,
  }) {
    final query = _db.select(_db.students)
      ..where((s) {
        var predicate = s.deletedAt.isNull();
        if (classId != null) predicate = predicate & s.classId.equals(classId);
        if (!includeInactive) {
          predicate = predicate & s.status.equals(StudentStatus.active.wire);
        }
        if (search.trim().isNotEmpty) {
          final term = '%${search.trim()}%';
          predicate = predicate &
              (s.fullName.like(term) |
                  s.admissionNo.like(term) |
                  s.fatherName.like(term));
        }
        return predicate;
      })
      ..orderBy([
        (s) => OrderingTerm.desc(s.status),
        (s) => OrderingTerm.asc(s.rollNo),
        (s) => OrderingTerm.asc(s.fullName),
      ]);
    return query.watch();
  }

  /// Next free admission number for the year, e.g. `2026-0351`.
  ///
  /// Admission numbers are permanent and school-wide — distinct from roll_no,
  /// which is per-class and resets yearly (CLAUDE.md §8).
  Future<String> nextAdmissionNo(String schoolId) async {
    final year = DateTime.now().year;
    final rows = await (_db.select(_db.students)
          ..where((s) => s.admissionNo.like('$year-%')))
        .get();

    var highest = 0;
    for (final row in rows) {
      final tail = int.tryParse(row.admissionNo.split('-').last);
      if (tail != null && tail > highest) highest = tail;
    }
    return '$year-${(highest + 1).toString().padLeft(4, '0')}';
  }

  Future<void> save({
    required String schoolId,
    String? id,
    required String fullName,
    String? fatherName,
    required String admissionNo,
    int? rollNo,
    String? classId,
    String? gender,
    String? guardianPhone,
    String? dateOfBirth,
    String? address,
    String status = 'active',
  }) async {
    final now = nowTimestamp();
    final rowId = id ?? newId();

    await _writer.upsert(
      table: _db.students,
      rowId: rowId,
      row: StudentsCompanion.insert(
        id: rowId,
        schoolId: schoolId,
        classId: Value(classId),
        admissionNo: admissionNo,
        rollNo: Value(rollNo),
        fullName: fullName,
        fatherName: Value(fatherName),
        guardianPhone: Value(guardianPhone),
        dateOfBirth: Value(dateOfBirth),
        gender: Value(gender),
        address: Value(address),
        admissionDate: Value(encodeDate(DateTime.now())),
        status: Value(status),
        updatedAt: now,
      ),
    );
  }

  /// Withdraws a student — the closing beat of the demo (CLAUDE.md §12, 2:20).
  ///
  /// Sets `status = 'withdrawn'` and flips `app_users.is_active` to false. The
  /// row is NEVER deleted: three years of attendance, marks and fee history
  /// hang off it, and a hard delete cannot sync anyway.
  ///
  /// Migration 001 made the deactivation bite at the database — a withdrawn
  /// account's `current_student_id()` returns nothing, so every student policy
  /// closes at once. The phone logging out is a consequence, not the mechanism.
  Future<void> withdraw({
    required Student student,
    required String reason,
  }) async {
    final now = nowTimestamp();

    await _writer.upsert(
      table: _db.students,
      rowId: student.id,
      row: StudentsCompanion.insert(
        id: student.id,
        schoolId: student.schoolId,
        classId: Value(student.classId),
        admissionNo: student.admissionNo,
        rollNo: Value(student.rollNo),
        fullName: student.fullName,
        fatherName: Value(student.fatherName),
        guardianPhone: Value(student.guardianPhone),
        dateOfBirth: Value(student.dateOfBirth),
        gender: Value(student.gender),
        address: Value(student.address),
        admissionDate: Value(student.admissionDate),
        status: Value(StudentStatus.withdrawn.wire),
        leftDate: Value(encodeDate(DateTime.now())),
        leftReason: Value(reason),
        updatedAt: now,
      ),
    );

    if (student.userId case final userId?) {
      final user = await (_db.select(_db.appUsers)
            ..where((u) => u.id.equals(userId)))
          .getSingleOrNull();
      if (user != null) {
        await _writer.upsert(
          table: _db.appUsers,
          rowId: user.id,
          row: AppUsersCompanion.insert(
            id: user.id,
            schoolId: user.schoolId,
            role: user.role,
            fullName: user.fullName,
            email: Value(user.email),
            phone: Value(user.phone),
            isActive: const Value(false),
            updatedAt: now,
          ),
        );
      }
    }
  }

  /// Puts a withdrawn student back on the roll.
  Future<void> readmit(Student student) => save(
        schoolId: student.schoolId,
        id: student.id,
        fullName: student.fullName,
        fatherName: student.fatherName,
        admissionNo: student.admissionNo,
        rollNo: student.rollNo,
        classId: student.classId,
        gender: student.gender,
        guardianPhone: student.guardianPhone,
        dateOfBirth: student.dateOfBirth,
        address: student.address,
      );

  /// Promotes [students] to [targetClassId].
  ///
  /// Updates each student's `class_id` to the new class and clears `roll_no`
  /// because roll numbers are per-class and must be re-assigned by the admin
  /// once students settle into their new class.
  Future<void> promoteStudents({
    required List<Student> students,
    required String targetClassId,
  }) async {
    for (final student in students) {
      final now = nowTimestamp();
      await _writer.upsert(
        table: _db.students,
        rowId: student.id,
        row: StudentsCompanion.insert(
          id: student.id,
          schoolId: student.schoolId,
          classId: Value(targetClassId),
          admissionNo: student.admissionNo,
          rollNo: const Value(null), // reset — re-assigned per new class
          fullName: student.fullName,
          fatherName: Value(student.fatherName),
          guardianPhone: Value(student.guardianPhone),
          dateOfBirth: Value(student.dateOfBirth),
          gender: Value(student.gender),
          address: Value(student.address),
          admissionDate: Value(student.admissionDate),
          status: Value(student.status),
          leftDate: Value(student.leftDate),
          leftReason: Value(student.leftReason),
          updatedAt: now,
        ),
      );
    }
  }
  /// Graduates [students], marking their status as graduated and recording the left_date.
  Future<void> graduateStudents({
    required List<Student> students,
  }) async {
    for (final student in students) {
      final now = nowTimestamp();
      await _writer.upsert(
        table: _db.students,
        rowId: student.id,
        row: StudentsCompanion.insert(
          id: student.id,
          schoolId: student.schoolId,
          classId: Value(student.classId),
          admissionNo: student.admissionNo,
          rollNo: Value(student.rollNo),
          fullName: student.fullName,
          fatherName: Value(student.fatherName),
          guardianPhone: Value(student.guardianPhone),
          dateOfBirth: Value(student.dateOfBirth),
          gender: Value(student.gender),
          address: Value(student.address),
          admissionDate: Value(student.admissionDate),
          status: Value(StudentStatus.graduated.wire),
          leftDate: Value(encodeDate(DateTime.now())),
          leftReason: const Value('Graduated'),
          updatedAt: now,
        ),
      );

      if (student.userId case final userId?) {
        final user = await (_db.select(_db.appUsers)
              ..where((u) => u.id.equals(userId)))
            .getSingleOrNull();
        if (user != null) {
          await _writer.upsert(
            table: _db.appUsers,
            rowId: user.id,
            row: AppUsersCompanion.insert(
              id: user.id,
              schoolId: user.schoolId,
              role: user.role,
              fullName: user.fullName,
              email: Value(user.email),
              phone: Value(user.phone),
              isActive: const Value(false),
              updatedAt: now,
            ),
          );
        }
      }
    }
  }
}
