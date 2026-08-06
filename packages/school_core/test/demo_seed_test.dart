import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:school_core/school_core.dart';
import 'package:test/test.dart';

void main() {
  late AppDatabase db;
  late DemoSeeder seeder;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    seeder = DemoSeeder(db);
  });

  tearDown(() async => db.close());

  Future<int> count(String table) async {
    final rows = await db.customSelect('SELECT count(*) AS c FROM $table').get();
    return rows.single.data['c']! as int;
  }

  test('seeds a complete school', () async {
    await seeder.seed();

    expect(await count('schools'), 1);
    expect(await count('classes'), 3);
    expect(await count('students'), 50);
    expect(await count('teachers'), 10);
    expect(await count('subjects'), 24, reason: '8 subjects × 3 classes');
    expect(await count('attendance'), greaterThan(2000));
    expect(await count('teacher_attendance'), greaterThan(400));
    expect(await count('fee_structures'), 3);
    expect(await count('fee_challans'), greaterThan(0));
  });

  test('ids are deterministic across separate databases', () async {
    // CLAUDE.md §12 requires "the same student (same UUID) on both sides".
    // Two devices seeding independently must agree, or sync sees two schools.
    await seeder.seed();
    final first = (await db.select(db.students).get()).map((s) => s.id).toSet();

    // Two independent in-memory databases is the whole point of this test;
    // drift's "multiple databases" warning is about sharing one executor.
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    final other = AppDatabase(NativeDatabase.memory());
    await DemoSeeder(other).seed();
    final second =
        (await other.select(other.students).get()).map((s) => s.id).toSet();
    await other.close();

    expect(first, second);
  });

  test('re-seeding is idempotent', () async {
    await seeder.seed();
    final before = await count('students');
    final attendanceBefore = await count('attendance');

    await seeder.seed();

    expect(await count('students'), before);
    expect(await count('attendance'), attendanceBefore);
  });

  group('re-seeding over rows the app created', () {
    // The reported failure. Rows written through the app carry a random
    // UUIDv7; the seeder generates a deterministic UUIDv5. When both describe
    // the same natural key, ON CONFLICT(id) does not match and the insert
    // fails on the OTHER unique constraint.

    test('survives a challan created with a different id', () async {
      await seeder.seed();

      final student = await (db.select(db.students)..limit(1)).getSingle();
      final now = DateTime.now();

      // Exactly what the Fees screen does: newId(), not demoId().
      await db.into(db.feeChallans).insert(
            FeeChallansCompanion.insert(
              id: newId(),
              schoolId: student.schoolId,
              studentId: student.id,
              classId: student.classId!,
              challanNo: 'CH-MANUAL',
              month: now.month,
              year: now.year,
              title: const Value('Tuition'),
              totalAmount: 1234,
              issueDate: encodeDate(now),
              dueDate: encodeDate(now),
              updatedAt: nowTimestamp(),
            ),
            onConflict: DoUpdate(
              (_) => FeeChallansCompanion(challanNo: const Value('CH-MANUAL')),
              target: [
                db.feeChallans.studentId,
                db.feeChallans.month,
                db.feeChallans.year,
                db.feeChallans.title,
              ],
            ),
          );

      // Before the fix this threw:
      //   UNIQUE constraint failed: fee_challans.student_id, .month, .year
      await expectLater(seeder.seed(), completes);
    });

    test('survives attendance marked through the app', () async {
      await seeder.seed();

      final student = await (db.select(db.students)..limit(1)).getSingle();
      // A back-dated day the seeder also covers.
      final date = encodeDate(
        dateOnly(DateTime.now()).subtract(const Duration(days: 3)),
      );

      await db.into(db.attendance).insert(
            AttendanceCompanion.insert(
              id: newId(),
              schoolId: student.schoolId,
              studentId: student.id,
              classId: student.classId!,
              date: date,
              status: AttendanceStatus.leave.wire,
              markedBy: DemoSeeder.principalUserId,
              markedAt: nowTimestamp(),
              updatedAt: nowTimestamp(),
            ),
            onConflict: DoUpdate(
              (_) => AttendanceCompanion(
                  status: Value(AttendanceStatus.leave.wire)),
              target: [db.attendance.studentId, db.attendance.date],
            ),
          );

      await expectLater(seeder.seed(), completes);

      // Still exactly one row for that student and day.
      final rows = await (db.select(db.attendance)
            ..where((a) =>
                a.studentId.equals(student.id) & a.date.equals(date)))
          .get();
      expect(rows, hasLength(1));
    });
  });

  test('attendance is not 100% present', () async {
    // A defaulter list with nobody on it demonstrates nothing, and every
    // student at a flat 100% reads as fake.
    await seeder.seed();
    final rows = await db.select(db.attendance).get();
    final statuses = rows.map((r) => r.status).toSet();
    expect(statuses, contains('present'));
    expect(statuses.length, greaterThan(1));
  });

  test('isSeeded reports honestly', () async {
    expect(await seeder.isSeeded(), isFalse);
    await seeder.seed();
    expect(await seeder.isSeeded(), isTrue);
  });
}
