import 'package:drift/drift.dart';
import 'package:school_core/school_core.dart';

/// Why bulk generation could not produce any challans.
///
/// Carries a sentence the principal can act on, not a stack trace.
class FeeGenerationException implements Exception {
  const FeeGenerationException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Fee structures, bulk challan generation, payments and defaulters.
class FeeRepository {
  FeeRepository(this._db) : _writer = OutboxWriter(_db);

  final AppDatabase _db;
  final OutboxWriter _writer;

  Stream<List<FeeStructure>> watchStructures() {
    final query = _db.select(_db.feeStructures)
      ..where((f) => f.deletedAt.isNull());
    return query.watch();
  }

  Stream<List<FeeChallan>> watchChallans({
    int? month,
    int? year,
    bool unpaidOnly = false,
  }) {
    final query = _db.select(_db.feeChallans)
      ..where((c) {
        var predicate = c.deletedAt.isNull();
        if (month != null) predicate = predicate & c.month.equals(month);
        if (year != null) predicate = predicate & c.year.equals(year);
        if (unpaidOnly) {
          predicate = predicate &
              (c.status.equals(ChallanStatus.unpaid.wire) |
                  c.status.equals(ChallanStatus.partial.wire));
        }
        return predicate;
      })
      ..orderBy([(c) => OrderingTerm.asc(c.challanNo)]);
    return query.watch();
  }

  Future<void> saveStructure({
    required String schoolId,
    required String academicYearId,
    String? id,
    String? classId,
    required double tuition,
    required double admission,
    required double exam,
    required double other,
    String? otherLabel,
  }) async {
    final rowId = id ?? newId();
    await _writer.upsert(
      table: _db.feeStructures,
      rowId: rowId,
      row: FeeStructuresCompanion.insert(
        id: rowId,
        schoolId: schoolId,
        academicYearId: academicYearId,
        classId: Value(classId),
        tuitionFee: Value(tuition),
        admissionFee: Value(admission),
        examFee: Value(exam),
        otherFee: Value(other),
        otherLabel: Value(otherLabel),
        updatedAt: nowTimestamp(),
      ),
    );
  }

  /// Generates one challan per active student for [month]/[year].
  ///
  /// The demo's strongest beat (CLAUDE.md §12, 1:35): 800 students become 800
  /// rows in a single local transaction, offline, then sync.
  ///
  /// Idempotent by `UNIQUE(student_id, month, year)` — running it twice for
  /// August updates rather than double-billing. That constraint is doing real
  /// work here: a principal who is not sure whether the click registered will
  /// click again.
  ///
  /// Returns how many challans were written.
  ///
  /// Throws [FeeGenerationException] rather than quietly returning 0 when
  /// there is nothing to bill. Silently producing no challans is the worst
  /// outcome: the principal clicks, sees nothing happen, and has no idea
  /// whether the feature is broken or they missed a step.
  Future<int> generateForMonth({
    required int month,
    required int year,
    required DateTime dueDate,
  }) async {
    final students = await (_db.select(_db.students)
          ..where((s) =>
              s.deletedAt.isNull() &
              s.status.equals(StudentStatus.active.wire)))
        .get();

    if (students.isEmpty) {
      throw const FeeGenerationException(
        'No active students to bill. Enrol students first, or seed the demo '
        'data from the Dashboard.',
      );
    }

    final structures = await (_db.select(_db.feeStructures)
          ..where((f) => f.deletedAt.isNull()))
        .get();

    if (structures.isEmpty) {
      throw const FeeGenerationException(
        'No fee structure set. Add one on the "Fee structure" tab — challan '
        'generation has no amounts to bill without it.',
      );
    }

    // A structure with a null class_id applies school-wide; a class-specific
    // one overrides it.
    final byClass = {
      for (final s in structures)
        if (s.classId != null) s.classId!: s,
    };
    final schoolWide = structures.where((s) => s.classId == null).firstOrNull;

    final issueDate = encodeDate(DateTime.now());
    final due = encodeDate(dueDate);
    var written = 0;
    var skippedNoStructure = 0;
    var skippedNoClass = 0;

    for (final student in students) {
      // A student not yet placed in a class cannot be billed — there is no
      // class to look a fee structure up by, and class_id is NOT NULL on the
      // challan.
      if (student.classId == null) {
        skippedNoClass++;
        continue;
      }

      final structure = byClass[student.classId] ?? schoolWide;
      if (structure == null) {
        skippedNoStructure++;
        continue;
      }

      final arrears = await _outstandingBefore(
        studentId: student.id,
        month: month,
        year: year,
      );

      final total = structure.tuitionFee +
          structure.admissionFee +
          structure.examFee +
          structure.otherFee +
          arrears;

      final existing = await (_db.select(_db.feeChallans)
            ..where((c) =>
                c.studentId.equals(student.id) &
                c.month.equals(month) &
                c.year.equals(year)))
          .getSingleOrNull();

      // Never rewrite a challan the office has already taken money against.
      // Regenerating would reset paid_amount and lose the record of payment.
      if (existing != null && existing.paidAmount > 0) continue;

      final rowId = existing?.id ?? newId();
      final serial = student.admissionNo.split('-').last;

      await _writer.upsert(
        table: _db.feeChallans,
        rowId: rowId,
        conflictTarget: [
          _db.feeChallans.studentId,
          _db.feeChallans.month,
          _db.feeChallans.year,
        ],
        row: FeeChallansCompanion.insert(
          id: rowId,
          schoolId: student.schoolId,
          studentId: student.id,
          classId: student.classId!,
          challanNo: 'CH-$year-${month.toString().padLeft(2, '0')}-$serial',
          month: month,
          year: year,
          tuitionFee: Value(structure.tuitionFee),
          admissionFee: Value(structure.admissionFee),
          examFee: Value(structure.examFee),
          otherFee: Value(structure.otherFee),
          arrears: Value(arrears),
          totalAmount: total,
          issueDate: issueDate,
          dueDate: due,
          status: Value(ChallanStatus.unpaid.wire),
          updatedAt: nowTimestamp(),
        ),
      );
      written++;
    }

    if (written == 0) {
      throw FeeGenerationException(
        skippedNoStructure > 0
            ? 'No challans generated — $skippedNoStructure students are in '
                'classes with no fee structure. Add a school-wide structure, '
                'or one per class.'
            : skippedNoClass > 0
                ? 'No challans generated — $skippedNoClass students are not '
                    'assigned to a class yet.'
                : 'No challans generated. Every student already has a paid '
                    'challan for this month.',
      );
    }

    return written;
  }

  /// Unpaid balance carried forward from months before [month]/[year].
  ///
  /// Without this the generator produces wrong totals from month two and the
  /// school's books never balance (CLAUDE.md §8). Cancelled challans are
  /// excluded — those were written off, and re-billing them would charge money
  /// the school already forgave.
  Future<double> _outstandingBefore({
    required String studentId,
    required int month,
    required int year,
  }) async {
    final previous = await (_db.select(_db.feeChallans)
          ..where((c) =>
              c.studentId.equals(studentId) &
              c.deletedAt.isNull() &
              (c.year.isSmallerThanValue(year) |
                  (c.year.equals(year) & c.month.isSmallerThanValue(month)))))
        .get();

    var owed = 0.0;
    for (final challan in previous) {
      final status = ChallanStatus.tryFromWire(challan.status);
      if (status == null || !status.isOutstanding) continue;
      owed += challan.totalAmount - challan.paidAmount;
    }
    return owed < 0 ? 0 : owed;
  }

  /// Records a payment taken at the office.
  ///
  /// There is no payment gateway — the student app displays challans only
  /// (CLAUDE.md §8). This is the only way money is ever recorded.
  Future<void> recordPayment({
    required FeeChallan challan,
    required double amount,
    required String method,
    required String receivedBy,
  }) async {
    final paid = challan.paidAmount + amount;
    final status = paid >= challan.totalAmount
        ? ChallanStatus.paid
        : ChallanStatus.partial;

    await _writer.upsert(
      table: _db.feeChallans,
      rowId: challan.id,
      row: FeeChallansCompanion.insert(
        id: challan.id,
        schoolId: challan.schoolId,
        studentId: challan.studentId,
        classId: challan.classId,
        challanNo: challan.challanNo,
        month: challan.month,
        year: challan.year,
        tuitionFee: Value(challan.tuitionFee),
        admissionFee: Value(challan.admissionFee),
        examFee: Value(challan.examFee),
        otherFee: Value(challan.otherFee),
        arrears: Value(challan.arrears),
        discount: Value(challan.discount),
        fine: Value(challan.fine),
        totalAmount: challan.totalAmount,
        issueDate: challan.issueDate,
        dueDate: challan.dueDate,
        status: Value(status.wire),
        paidAmount: Value(paid),
        paidDate: Value(encodeDate(DateTime.now())),
        paymentMethod: Value(method),
        receivedBy: Value(receivedBy),
        updatedAt: nowTimestamp(),
      ),
    );
  }
}
