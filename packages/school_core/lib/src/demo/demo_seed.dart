import 'dart:math';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/database.dart';
import '../enums.dart';
import '../time.dart';
import 'demo_names.dart';

/// Seeds a realistic school into the local database.
///
/// CLAUDE.md §12: seed before filming, or every chart is empty and two months
/// of "history" is a blank page. This produces ~50 students across 9-A, 9-B
/// and 10-A, with back-dated attendance, so the dashboard has something to
/// draw the moment the app opens.
///
/// ## Why the ids are UUIDv5, not v7
///
/// Everywhere else in this system ids are UUIDv7 generated at the moment of
/// writing (schema.sql convention 1). Demo data is the deliberate exception:
/// these are **deterministic**, derived by hashing a stable key.
///
/// CLAUDE.md §12 requires "the same student (same UUID) exists on both sides".
/// Running this seeder on the desktop and on the phone must therefore produce
/// byte-identical ids, which random generation cannot do. Re-running it is
/// also then idempotent — it upserts over itself rather than creating a second
/// school.
///
/// This does NOT weaken the v7 rule for real data. Nothing a user creates goes
/// through here.
class DemoSeeder {
  DemoSeeder(this._db);

  final AppDatabase _db;

  /// Fixed so every run — and every device — agrees.
  static const _namespace = '6ba7b810-9dad-11d1-80b4-00c04fd430c8';
  static final _uuid = Uuid();

  /// A stable id for [key].
  static String demoId(String key) => _uuid.v5(_namespace, 'sse-demo/$key');

  static String get schoolId => demoId('school');
  static String get academicYearId => demoId('year/2026-2027');
  static String get principalUserId => demoId('user/principal');

  /// Deterministic randomness — same "random" attendance every run, so a
  /// re-shoot of the video shows identical numbers.
  final _random = Random(20260802);

  static const _classSpecs = [
    (grade: 9, section: 'A', students: 18),
    (grade: 9, section: 'B', students: 17),
    (grade: 10, section: 'A', students: 15),
  ];

  /// How far back to generate attendance. Two months, per CLAUDE.md §12.
  static const _attendanceDays = 60;

  Future<void> seed() async {
    final now = nowTimestamp();

    await _db.transaction(() async {
      await _seedSchool(now);
      await _seedPrincipal(now);
      await _seedTeachers(now);

      var admissionCounter = 300;
      for (final spec in _classSpecs) {
        final classId = demoId('class/${spec.grade}-${spec.section}');
        await _seedClass(spec.grade, spec.section, classId, now);
        await _seedSubjects(classId, now);
        admissionCounter = await _seedStudents(
          classId: classId,
          grade: spec.grade,
          section: spec.section,
          count: spec.students,
          admissionCounter: admissionCounter,
          now: now,
        );
      }

      await _seedAttendance(now);
      await _seedTeacherAttendance(now);
      await _seedFees(now);
    });
  }

  /// True when the demo school is already present.
  Future<bool> isSeeded() async {
    final query = _db.select(_db.schools)..where((s) => s.id.equals(schoolId));
    return await query.getSingleOrNull() != null;
  }

  Future<void> _seedSchool(String now) async {
    await _db.into(_db.schools).insertOnConflictUpdate(
          SchoolsCompanion.insert(
            id: schoolId,
            name: 'Sunrise School of Excellence',
            address: const Value('Model Town, Lahore'),
            phone: const Value('042-35880000'),
            updatedAt: now,
          ),
        );

    await _db.into(_db.academicYears).insertOnConflictUpdate(
          AcademicYearsCompanion.insert(
            id: academicYearId,
            schoolId: schoolId,
            name: '2026-2027',
            startDate: '2026-04-01',
            endDate: '2027-03-31',
            isCurrent: const Value(true),
            updatedAt: now,
          ),
        );
  }

  Future<void> _seedPrincipal(String now) async {
    await _db.into(_db.appUsers).insertOnConflictUpdate(
          AppUsersCompanion.insert(
            id: principalUserId,
            schoolId: schoolId,
            role: UserRole.superAdmin.wire,
            fullName: 'Principal',
            email: const Value('principal@sunrise.edu.pk'),
            updatedAt: now,
          ),
        );
  }

  /// Fee structures per class, plus two months of challans.
  ///
  /// Without this the Fees screen has nothing to bill and generation silently
  /// produces zero challans. CLAUDE.md §12 also calls for realistic PKR
  /// amounts on screen before filming.
  ///
  /// Roughly a third are left unpaid so the defaulter list has something in
  /// it — a defaulter screen with nobody on it demonstrates nothing, and the
  /// arrears carry-forward has nothing to carry.
  Future<void> _seedFees(String now) async {
    final classes = await _db.select(_db.classes).get();

    // Senior classes cost more, which is how Pakistani schools actually price.
    for (final schoolClass in classes) {
      final tuition = 3500 + (schoolClass.grade * 250);
      await _db.into(_db.feeStructures).insertOnConflictUpdate(
            FeeStructuresCompanion.insert(
              id: demoId('fee-structure/${schoolClass.id}'),
              schoolId: schoolId,
              academicYearId: academicYearId,
              classId: Value(schoolClass.id),
              tuitionFee: Value(tuition.toDouble()),
              examFee: const Value(500),
              otherFee: const Value(300),
              otherLabel: const Value('Sports & library'),
              updatedAt: now,
            ),
          );
    }

    final structures = {
      for (final s in await _db.select(_db.feeStructures).get())
        if (s.classId != null) s.classId!: s,
    };

    final students = await (_db.select(_db.students)
          ..where((s) => s.status.equals(StudentStatus.active.wire)))
        .get();

    final today = dateOnly(DateTime.now());

    // Last month and this month.
    for (var monthsAgo = 1; monthsAgo >= 0; monthsAgo--) {
      final period = DateTime(today.year, today.month - monthsAgo);

      for (final student in students) {
        final structure = structures[student.classId];
        if (structure == null) continue;

        final base = structure.tuitionFee +
            structure.admissionFee +
            structure.examFee +
            structure.otherFee;

        // Last month's unpaid balance becomes this month's arrears — the
        // behaviour that makes the books balance from month two (CLAUDE.md §8).
        final roll = _random.nextInt(100);
        final paidLastMonth = monthsAgo == 1 && roll >= 30;
        final arrears =
            (monthsAgo == 0 && !paidLastMonth && roll < 30) ? base : 0.0;

        final total = base + arrears;
        final isPaid = monthsAgo == 1 ? paidLastMonth : roll >= 65;
        final serial = student.admissionNo.split('-').last;
        final monthKey = period.month.toString().padLeft(2, '0');

        await _db.into(_db.feeChallans).insertOnConflictUpdate(
              FeeChallansCompanion.insert(
                id: demoId('challan/${student.id}/${period.year}-$monthKey'),
                schoolId: schoolId,
                studentId: student.id,
                classId: student.classId!,
                challanNo: 'CH-${period.year}-$monthKey-$serial',
                month: period.month,
                year: period.year,
                tuitionFee: Value(structure.tuitionFee),
                admissionFee: Value(structure.admissionFee),
                examFee: Value(structure.examFee),
                otherFee: Value(structure.otherFee),
                arrears: Value(arrears),
                totalAmount: total,
                issueDate: encodeDate(DateTime(period.year, period.month, 1)),
                dueDate: encodeDate(DateTime(period.year, period.month, 10)),
                status: Value(isPaid
                    ? ChallanStatus.paid.wire
                    : ChallanStatus.unpaid.wire),
                paidAmount: Value(isPaid ? total : 0),
                paidDate: Value(isPaid
                    ? encodeDate(DateTime(period.year, period.month, 8))
                    : null),
                paymentMethod:
                    Value(isPaid ? PaymentMethod.cash.wire : null),
                receivedBy: Value(isPaid ? principalUserId : null),
                updatedAt: now,
              ),
            );
      }
    }
  }

  Future<void> _seedTeachers(String now) async {
    for (var i = 0; i < demoTeachers.length; i++) {
      final teacher = demoTeachers[i];
      await _db.into(_db.teachers).insertOnConflictUpdate(
            TeachersCompanion.insert(
              id: demoId('teacher/$i'),
              schoolId: schoolId,
              employeeNo: Value('EMP-${100 + i}'),
              fullName: teacher.name,
              qualification: Value(teacher.qualification),
              // CNIC and phone are staff HR data. They are stored because the
              // office needs them, and RLS keeps them away from students —
              // `teachers` has no student policy (migration 001).
              cnic: Value('35202-${1000000 + i * 7919}-${i % 9 + 1}'),
              phone: Value('0301-${2000000 + i * 4567}'),
              joiningDate: Value('${2019 + (i % 6)}-04-01'),
              updatedAt: now,
            ),
          );
    }
  }

  /// Staff register for the same period as the student one.
  ///
  /// Teachers are absent less often than students, and their absences skew
  /// towards `leave` rather than unexplained `absent` — a teacher who simply
  /// does not turn up is rare, whereas casual and medical leave are routine.
  /// A flat copy of the student distribution would look wrong to a principal.
  Future<void> _seedTeacherAttendance(String now) async {
    final teachers = await _db.select(_db.teachers).get();
    final today = dateOnly(DateTime.now());

    for (var dayOffset = _attendanceDays; dayOffset >= 1; dayOffset--) {
      final date = today.subtract(Duration(days: dayOffset));
      if (date.weekday == DateTime.sunday) continue;

      final dateKey = encodeDate(date);

      for (final teacher in teachers) {
        final status = _rollTeacherStatus();
        await _db.into(_db.teacherAttendance).insertOnConflictUpdate(
              TeacherAttendanceCompanion.insert(
                id: demoId('teacher-attendance/${teacher.id}/$dateKey'),
                schoolId: schoolId,
                teacherId: teacher.id,
                date: dateKey,
                status: status.wire,
                checkInTime: Value(_checkInFor(status)),
                remarks: Value(
                  status == AttendanceStatus.leave ? _leaveReason() : null,
                ),
                markedBy: principalUserId,
                markedAt: now,
                updatedAt: now,
              ),
            );
      }
    }
  }

  AttendanceStatus _rollTeacherStatus() {
    final roll = _random.nextInt(100);
    if (roll < 93) return AttendanceStatus.present;
    if (roll < 97) return AttendanceStatus.leave;
    if (roll < 99) return AttendanceStatus.arrivedLate;
    return AttendanceStatus.absent;
  }

  /// School starts at 08:00. Present staff arrive a few minutes either side;
  /// late ones after the bell. Absent and on-leave staff have no arrival time.
  String? _checkInFor(AttendanceStatus status) => switch (status) {
        AttendanceStatus.present =>
          '07:${(45 + _random.nextInt(15)).toString().padLeft(2, '0')}',
        AttendanceStatus.arrivedLate =>
          '08:${(15 + _random.nextInt(40)).toString().padLeft(2, '0')}',
        _ => null,
      };

  String _leaveReason() => const [
        'Casual leave',
        'Medical leave',
        'Official duty',
        'Family emergency',
      ][_random.nextInt(4)];

  Future<void> _seedClass(
    int grade,
    String section,
    String classId,
    String now,
  ) async {
    await _db.into(_db.classes).insertOnConflictUpdate(
          ClassesCompanion.insert(
            id: classId,
            schoolId: schoolId,
            academicYearId: academicYearId,
            grade: grade,
            section: section,
            displayName: '$grade-$section',
            room: Value('Room ${grade}0$section'),
            updatedAt: now,
          ),
        );
  }

  Future<void> _seedSubjects(String classId, String now) async {
    for (var i = 0; i < demoSubjects.length; i++) {
      final subject = demoSubjects[i];
      await _db.into(_db.subjects).insertOnConflictUpdate(
            SubjectsCompanion.insert(
              id: demoId('subject/$classId/${subject.code}'),
              schoolId: schoolId,
              classId: classId,
              name: subject.name,
              code: Value(subject.code),
              icon: Value(subject.icon),
              sortOrder: Value(i),
              updatedAt: now,
            ),
          );
    }
  }

  Future<int> _seedStudents({
    required String classId,
    required int grade,
    required String section,
    required int count,
    required int admissionCounter,
    required String now,
  }) async {
    var admission = admissionCounter;

    for (var i = 0; i < count; i++) {
      // Alternate boys and girls so classes are mixed rather than one gender
      // per section.
      final isBoy = i.isEven;
      final pool = isBoy ? demoBoyNames : demoGirlNames;
      final name = pool[(admission + i) % pool.length];

      final studentId = demoId('student/$grade-$section/$i');
      admission++;

      await _db.into(_db.students).insertOnConflictUpdate(
            StudentsCompanion.insert(
              id: studentId,
              schoolId: schoolId,
              classId: Value(classId),
              admissionNo: '2026-0$admission',
              rollNo: Value(i + 1),
              fullName: name,
              fatherName:
                  Value(demoFatherNames[(admission + i) % demoFatherNames.length]),
              gender: Value(isBoy ? Gender.male.wire : Gender.female.wire),
              // Guardian phone is stored because the OFFICE needs it. It must
              // never be rendered in the student app — these are minors
              // (CLAUDE.md §7).
              guardianPhone: Value('0300-${1000000 + admission}'),
              dateOfBirth: Value('${2026 - grade - 5}-06-15'),
              admissionDate: const Value('2026-04-01'),
              status: Value(StudentStatus.active.wire),
              updatedAt: now,
            ),
          );
    }

    return admission;
  }

  /// Back-dated attendance, weekdays only.
  ///
  /// Sunday is the weekly holiday in Pakistani schools; Saturday is a half-day
  /// but still a school day, so only Sunday is skipped.
  Future<void> _seedAttendance(String now) async {
    final students = await _db.select(_db.students).get();
    final today = dateOnly(DateTime.now());

    for (var dayOffset = _attendanceDays; dayOffset >= 1; dayOffset--) {
      final date = today.subtract(Duration(days: dayOffset));
      if (date.weekday == DateTime.sunday) continue;

      final dateKey = encodeDate(date);

      for (final student in students) {
        await _db.into(_db.attendance).insertOnConflictUpdate(
              AttendanceCompanion.insert(
                id: demoId('attendance/${student.id}/$dateKey'),
                schoolId: schoolId,
                studentId: student.id,
                classId: student.classId!,
                date: dateKey,
                status: _rollStatus().wire,
                markedBy: principalUserId,
                markedAt: now,
                updatedAt: now,
              ),
            );
      }
    }
  }

  /// Realistic distribution — roughly 88% present, with the rest spread across
  /// absent, leave and late.
  ///
  /// Not 100% present: a defaulter list with nobody on it demonstrates
  /// nothing, and the attendance percentage tile would read a suspicious flat
  /// 100 for every student.
  AttendanceStatus _rollStatus() {
    final roll = _random.nextInt(100);
    if (roll < 88) return AttendanceStatus.present;
    if (roll < 94) return AttendanceStatus.absent;
    if (roll < 97) return AttendanceStatus.arrivedLate;
    return AttendanceStatus.leave;
  }
}
