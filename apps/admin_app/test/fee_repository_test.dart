import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_core/school_core.dart';
import 'package:sse_admin_app/src/data/fee_repository.dart';

void main() {
  late AppDatabase db;
  late FeeRepository repo;

  const schoolId = 'school-1';
  const classId = 'class-1';
  const yearId = 'year-1';

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = FeeRepository(db);

    await db.into(db.schools).insert(SchoolsCompanion.insert(
        id: schoolId, name: 'Test School', updatedAt: nowTimestamp()));
    await db.into(db.academicYears).insert(AcademicYearsCompanion.insert(
          id: yearId,
          schoolId: schoolId,
          name: '2026-2027',
          startDate: '2026-04-01',
          endDate: '2027-03-31',
          updatedAt: nowTimestamp(),
        ));
    await db.into(db.classes).insert(ClassesCompanion.insert(
          id: classId,
          schoolId: schoolId,
          academicYearId: yearId,
          grade: 9,
          section: 'A',
          displayName: '9-A',
          updatedAt: nowTimestamp(),
        ));
  });

  tearDown(() async => db.close());

  Future<void> addStudent(String id, String admissionNo) =>
      db.into(db.students).insert(StudentsCompanion.insert(
            id: id,
            schoolId: schoolId,
            classId: const Value(classId),
            admissionNo: admissionNo,
            fullName: 'Student $id',
            status: Value(StudentStatus.active.wire),
            updatedAt: nowTimestamp(),
          ));

  Future<void> addStructure({double tuition = 4000}) => repo.saveStructure(
        schoolId: schoolId,
        academicYearId: yearId,
        classId: classId,
        tuition: tuition,
        admission: 0,
        exam: 500,
        other: 0,
      );

  group('guard rails', () {
    test('explains itself when there are no students', () {
      // Silently returning 0 is the failure mode reported from the app: the
      // principal clicks, nothing happens, and there is no way to tell whether
      // the feature is broken or a step was missed.
      expect(
        () => repo.generateForMonth(
            month: 8, year: 2026, dueDate: DateTime(2026, 8, 10)),
        throwsA(isA<FeeGenerationException>()),
      );
    });

    test('explains itself when no fee structure is set', () async {
      await addStudent('s1', '2026-0001');
      await expectLater(
        repo.generateForMonth(
            month: 8, year: 2026, dueDate: DateTime(2026, 8, 10)),
        throwsA(
          isA<FeeGenerationException>().having(
            (e) => e.message,
            'message',
            contains('fee structure'),
          ),
        ),
      );
    });

    test('skips students with no class, and says so', () async {
      await addStructure();
      await db.into(db.students).insert(StudentsCompanion.insert(
            id: 'nc',
            schoolId: schoolId,
            admissionNo: '2026-9999',
            fullName: 'Unplaced',
            status: Value(StudentStatus.active.wire),
            updatedAt: nowTimestamp(),
          ));

      await expectLater(
        repo.generateForMonth(
            month: 8, year: 2026, dueDate: DateTime(2026, 8, 10)),
        throwsA(isA<FeeGenerationException>()
            .having((e) => e.message, 'message', contains('not assigned'))),
      );
    });
  });

  group('generation', () {
    test('writes one challan per active student', () async {
      await addStructure();
      for (var i = 1; i <= 5; i++) {
        await addStudent('s$i', '2026-000$i');
      }

      final count = await repo.generateForMonth(
          month: 8, year: 2026, dueDate: DateTime(2026, 8, 10));

      expect(count, 5);
      final challans = await db.select(db.feeChallans).get();
      expect(challans, hasLength(5));
      expect(challans.first.totalAmount, 4500);
    });

    test('withdrawn students are not billed', () async {
      await addStructure();
      await addStudent('active', '2026-0001');
      await db.into(db.students).insert(StudentsCompanion.insert(
            id: 'gone',
            schoolId: schoolId,
            classId: const Value(classId),
            admissionNo: '2026-0002',
            fullName: 'Withdrawn',
            status: Value(StudentStatus.withdrawn.wire),
            updatedAt: nowTimestamp(),
          ));

      final count = await repo.generateForMonth(
          month: 8, year: 2026, dueDate: DateTime(2026, 8, 10));
      expect(count, 1, reason: 'a withdrawn student must not be charged');
    });

    test('running twice does not double-bill', () async {
      // UNIQUE(student_id, month, year). A principal unsure whether the click
      // registered will click again — that must be safe.
      await addStructure();
      await addStudent('s1', '2026-0001');

      await repo.generateForMonth(
          month: 8, year: 2026, dueDate: DateTime(2026, 8, 10));
      await repo.generateForMonth(
          month: 8, year: 2026, dueDate: DateTime(2026, 8, 10));

      final challans = await db.select(db.feeChallans).get();
      expect(challans, hasLength(1));
    });

    test('never overwrites a challan money has been taken against', () async {
      await addStructure();
      await addStudent('s1', '2026-0001');
      await repo.generateForMonth(
          month: 8, year: 2026, dueDate: DateTime(2026, 8, 10));

      final challan = await db.select(db.feeChallans).getSingle();
      await repo.recordPayment(
        challan: challan,
        amount: 2000,
        method: PaymentMethod.cash.wire,
        receivedBy: 'user-1',
      );

      // Regenerating would reset paid_amount and erase the record of a payment
      // the office has physically taken.
      await expectLater(
        repo.generateForMonth(
            month: 8, year: 2026, dueDate: DateTime(2026, 8, 10)),
        throwsA(isA<FeeGenerationException>()),
      );

      final after = await db.select(db.feeChallans).getSingle();
      expect(after.paidAmount, 2000);
    });
  });

  group('arrears carry-forward', () {
    test('an unpaid month rolls into the next', () async {
      // Without this the generator produces wrong totals from month two and
      // the school's books never balance (CLAUDE.md §8).
      await addStructure();
      await addStudent('s1', '2026-0001');

      await repo.generateForMonth(
          month: 8, year: 2026, dueDate: DateTime(2026, 8, 10));
      await repo.generateForMonth(
          month: 9, year: 2026, dueDate: DateTime(2026, 9, 10));

      final september = await (db.select(db.feeChallans)
            ..where((c) => c.month.equals(9)))
          .getSingle();

      expect(september.arrears, 4500, reason: 'August went unpaid');
      expect(september.totalAmount, 9000, reason: '4500 current + 4500 arrears');
    });

    test('a paid month carries nothing forward', () async {
      await addStructure();
      await addStudent('s1', '2026-0001');

      await repo.generateForMonth(
          month: 8, year: 2026, dueDate: DateTime(2026, 8, 10));
      final august = await db.select(db.feeChallans).getSingle();
      await repo.recordPayment(
        challan: august,
        amount: august.totalAmount,
        method: PaymentMethod.cash.wire,
        receivedBy: 'user-1',
      );

      await repo.generateForMonth(
          month: 9, year: 2026, dueDate: DateTime(2026, 9, 10));
      final september = await (db.select(db.feeChallans)
            ..where((c) => c.month.equals(9)))
          .getSingle();

      expect(september.arrears, 0);
      expect(september.totalAmount, 4500);
    });

    test('a partial payment carries only the remainder', () async {
      await addStructure();
      await addStudent('s1', '2026-0001');

      await repo.generateForMonth(
          month: 8, year: 2026, dueDate: DateTime(2026, 8, 10));
      final august = await db.select(db.feeChallans).getSingle();
      await repo.recordPayment(
        challan: august,
        amount: 1500,
        method: PaymentMethod.cash.wire,
        receivedBy: 'user-1',
      );

      await repo.generateForMonth(
          month: 9, year: 2026, dueDate: DateTime(2026, 9, 10));
      final september = await (db.select(db.feeChallans)
            ..where((c) => c.month.equals(9)))
          .getSingle();

      expect(september.arrears, 3000, reason: '4500 billed less 1500 paid');
    });

    test('a cancelled challan is written off, not re-billed', () async {
      await addStructure();
      await addStudent('s1', '2026-0001');
      await repo.generateForMonth(
          month: 8, year: 2026, dueDate: DateTime(2026, 8, 10));

      await (db.update(db.feeChallans)..where((c) => c.month.equals(8)))
          .write(FeeChallansCompanion(
              status: Value(ChallanStatus.cancelled.wire)));

      await repo.generateForMonth(
          month: 9, year: 2026, dueDate: DateTime(2026, 9, 10));
      final september = await (db.select(db.feeChallans)
            ..where((c) => c.month.equals(9)))
          .getSingle();

      expect(september.arrears, 0,
          reason: 'the school forgave this — charging it again is wrong');
    });
  });

  group('payments', () {
    test('full payment marks it paid', () async {
      await addStructure();
      await addStudent('s1', '2026-0001');
      await repo.generateForMonth(
          month: 8, year: 2026, dueDate: DateTime(2026, 8, 10));

      final challan = await db.select(db.feeChallans).getSingle();
      await repo.recordPayment(
        challan: challan,
        amount: challan.totalAmount,
        method: PaymentMethod.bank.wire,
        receivedBy: 'user-1',
      );

      final after = await db.select(db.feeChallans).getSingle();
      expect(after.status, ChallanStatus.paid.wire);
      expect(after.paymentMethod, 'bank');
    });

    test('partial payment marks it partial and accumulates', () async {
      await addStructure();
      await addStudent('s1', '2026-0001');
      await repo.generateForMonth(
          month: 8, year: 2026, dueDate: DateTime(2026, 8, 10));

      var challan = await db.select(db.feeChallans).getSingle();
      await repo.recordPayment(
          challan: challan,
          amount: 2000,
          method: PaymentMethod.cash.wire,
          receivedBy: 'u');

      challan = await db.select(db.feeChallans).getSingle();
      expect(challan.status, ChallanStatus.partial.wire);
      expect(challan.paidAmount, 2000);

      await repo.recordPayment(
          challan: challan,
          amount: 2500,
          method: PaymentMethod.cash.wire,
          receivedBy: 'u');

      challan = await db.select(db.feeChallans).getSingle();
      expect(challan.status, ChallanStatus.paid.wire);
      expect(challan.paidAmount, 4500);
    });
  });
}
