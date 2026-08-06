import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// Mirrors `fee_structures` in schema.sql §5.
///
/// Per-class fee amounts — "manage fees for every class" from the sketch.
@DataClassName('FeeStructure')
class FeeStructures extends Table with SyncColumns {
  @override
  String get tableName => 'fee_structures';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get academicYearId => text().named('academic_year_id')();

  /// Null means the structure applies school-wide.
  TextColumn get classId => text().named('class_id').nullable()();

  /// All money is PKR, NUMERIC(10,2) → REAL.
  RealColumn get tuitionFee =>
      real().named('tuition_fee').withDefault(const Constant(0))();
  RealColumn get admissionFee =>
      real().named('admission_fee').withDefault(const Constant(0))();
  RealColumn get examFee =>
      real().named('exam_fee').withDefault(const Constant(0))();
  RealColumn get otherFee =>
      real().named('other_fee').withDefault(const Constant(0))();

  TextColumn get otherLabel => text().named('other_label').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Mirrors `fee_challans` in schema.sql §5.
///
/// One-click bulk generation writes one row per active student — 800 rows in a
/// single local transaction, then synced. The strongest moment in the demo
/// video (CLAUDE.md §12, 1:35).
///
/// DISPLAY ONLY on the student side. There is no payment gateway; the office
/// records payment in the admin app. That keeps financial compliance entirely
/// out of scope (CLAUDE.md §8).
@DataClassName('FeeChallan')
class FeeChallans extends Table with SyncColumns {
  @override
  String get tableName => 'fee_challans';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get studentId => text().named('student_id')();
  TextColumn get classId => text().named('class_id')();

  /// `'CH-2026-08-0341'`.
  TextColumn get challanNo => text().named('challan_no')();

  /// 1..12.
  IntColumn get month => integer()();
  IntColumn get year => integer()();

  /// E.g. 'Sports Fine', 'August Tuition'
  TextColumn get title => text().nullable()();

  RealColumn get tuitionFee =>
      real().named('tuition_fee').withDefault(const Constant(0))();
  RealColumn get admissionFee =>
      real().named('admission_fee').withDefault(const Constant(0))();
  RealColumn get examFee =>
      real().named('exam_fee').withDefault(const Constant(0))();
  RealColumn get otherFee =>
      real().named('other_fee').withDefault(const Constant(0))();

  /// Unpaid balance carried forward from previous months.
  ///
  /// Without this the bulk generator produces wrong totals from month two and
  /// the school's books never balance (CLAUDE.md §8).
  RealColumn get arrears =>
      real().named('arrears').withDefault(const Constant(0))();

  RealColumn get discount =>
      real().named('discount').withDefault(const Constant(0))();
  RealColumn get fine => real().named('fine').withDefault(const Constant(0))();

  RealColumn get totalAmount => real().named('total_amount')();

  TextColumn get issueDate => text().named('issue_date')();
  TextColumn get dueDate => text().named('due_date')();

  /// `ChallanStatus.wire`, defaulting to `'unpaid'`.
  TextColumn get status => text().withDefault(const Constant('unpaid'))();

  RealColumn get paidAmount =>
      real().named('paid_amount').withDefault(const Constant(0))();
  TextColumn get paidDate => text().named('paid_date').nullable()();

  /// `PaymentMethod.wire` — `'cash'` | `'bank'` | `'online'`.
  TextColumn get paymentMethod =>
      text().named('payment_method').nullable()();

  TextColumn get receivedBy => text().named('received_by').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  /// Cannot double-bill a student for the same month. This is what makes
  /// re-running bulk generation safe.
  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {studentId, month, year, title},
      ];
}
