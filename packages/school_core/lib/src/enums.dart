/// Every enum in this file mirrors a `TEXT + CHECK` column in schema.sql.
///
/// schema.sql convention 2: these are TEXT with a CHECK constraint, never a
/// Postgres ENUM type, because SQLite has no enum type and both schemas must
/// stay identical.
///
/// **The [WireEnum.wire] strings are the contract with the student app.**
/// Changing one is a migration on every device that has ever synced, plus a
/// message to the other dev. Renaming the *Dart* identifier is free; changing
/// the wire string is not.
///
/// Where a wire string collides with a Dart keyword the identifier differs and
/// the divergence is called out in a comment — see [SlotType] and
/// [AttendanceStatus.arrivedLate].
library;

/// A value persisted as its [wire] string in both Postgres and SQLite.
abstract interface class WireEnum {
  /// The exact string stored in the database. Part of the cross-app contract.
  String get wire;
}

/// Resolves [wire] to one of [values], throwing if it is not a known value.
///
/// Use at trusted boundaries (local database reads, UI). For anything arriving
/// over the network prefer [tryFromWire] — see its note on forward compatibility.
T _fromWire<T extends WireEnum>(List<T> values, String wire, String label) {
  for (final value in values) {
    if (value.wire == wire) return value;
  }
  throw ArgumentError.value(wire, 'wire', 'Not a valid $label');
}

/// Resolves [wire] to one of [values], or null if unrecognised.
///
/// The sync loop must use this rather than [_fromWire]. If the other app ships
/// a new enum value first, an old client that throws here would crash on every
/// pull and never recover — it would be stuck, because the row it chokes on is
/// still there next time. Returning null lets the client skip the row and keep
/// its cursor moving.
T? _tryFromWire<T extends WireEnum>(List<T> values, String? wire) {
  if (wire == null) return null;
  for (final value in values) {
    if (value.wire == wire) return value;
  }
  return null;
}

// ============================================================================
//  PEOPLE & ACCESS
// ============================================================================

/// `app_users.role`.
///
/// Only [superAdmin] has a UI in the prototype. [teacher] and [student] exist
/// in the contract so enabling them later is seeding rows, not a migration.
enum UserRole implements WireEnum {
  /// The principal. Full access to their own school.
  superAdmin('super_admin'),

  /// Scoped to assigned classes. Schema ready, UI deferred.
  teacher('teacher'),

  /// Read-only, except lost_items and item_claims.
  student('student');

  const UserRole(this.wire);

  @override
  final String wire;

  static UserRole fromWire(String wire) => _fromWire(values, wire, 'UserRole');
  static UserRole? tryFromWire(String? wire) => _tryFromWire(values, wire);

  /// Precedence for conflict resolution — higher wins. See CLAUDE.md §10:
  /// `super_admin` > `teacher` > `student`.
  ///
  /// This is what settles a student-status conflict in the principal's favour
  /// rather than by blanket last-write-wins.
  int get precedence => switch (this) {
        UserRole.superAdmin => 3,
        UserRole.teacher => 2,
        UserRole.student => 1,
      };
}

/// `students.gender`.
enum Gender implements WireEnum {
  male('male'),
  female('female');

  const Gender(this.wire);

  @override
  final String wire;

  static Gender fromWire(String wire) => _fromWire(values, wire, 'Gender');
  static Gender? tryFromWire(String? wire) => _tryFromWire(values, wire);
}

/// `students.status`.
///
/// Withdrawing a student sets this to [withdrawn] and flips
/// `app_users.is_active` to false. The row is NEVER deleted — attendance,
/// marks and fee history must survive. See schema.sql §2.
enum StudentStatus implements WireEnum {
  active('active'),
  withdrawn('withdrawn'),
  graduated('graduated'),
  suspended('suspended');

  const StudentStatus(this.wire);

  @override
  final String wire;

  static StudentStatus fromWire(String wire) =>
      _fromWire(values, wire, 'StudentStatus');
  static StudentStatus? tryFromWire(String? wire) => _tryFromWire(values, wire);

  /// Whether this student should still appear in day-to-day lists: attendance
  /// registers, bulk challan generation, class rosters.
  bool get isEnrolled => this == StudentStatus.active;
}

// ============================================================================
//  ATTENDANCE
// ============================================================================

/// `attendance.status` — five states, not a boolean.
///
/// CLAUDE.md §8: the original sketch had red/green only, but real schools need
/// all five. Retrofitting a boolean into five states means migrating every
/// device, so this was settled up front.
///
/// Student-app calendar colours (contract with the mobile dev):
/// present 🟢 · absent 🔴 · leave 🟡 · late 🟠 · holiday ⬜
enum AttendanceStatus implements WireEnum {
  present('present'),
  absent('absent'),
  leave('leave'),

  /// Wire string is `'late'`. The Dart identifier differs because `late` is a
  /// Dart keyword and cannot be an enum constant.
  arrivedLate('late'),

  holiday('holiday');

  const AttendanceStatus(this.wire);

  @override
  final String wire;

  static AttendanceStatus fromWire(String wire) =>
      _fromWire(values, wire, 'AttendanceStatus');
  static AttendanceStatus? tryFromWire(String? wire) =>
      _tryFromWire(values, wire);

  /// Counts toward the numerator of the attendance percentage.
  ///
  /// A late student was in the building, so they count as present. See
  /// [attendancePercentage].
  bool get countsAsAttended =>
      this == AttendanceStatus.present || this == AttendanceStatus.arrivedLate;

  /// Excluded from the denominator entirely — a holiday is not a day the
  /// student could have attended, so it must not drag the percentage down.
  bool get isNonSchoolDay => this == AttendanceStatus.holiday;
}

// ============================================================================
//  EXAMS & MARKS
// ============================================================================

/// `exams.exam_type`.
///
/// Terms, not semesters — see CLAUDE.md §11 on the university→school model.
enum ExamType implements WireEnum {
  firstTerm('first_term'),
  midTerm('mid_term'),
  finalTerm('final_term'),
  test('test'),
  quiz('quiz');

  const ExamType(this.wire);

  @override
  final String wire;

  static ExamType fromWire(String wire) => _fromWire(values, wire, 'ExamType');
  static ExamType? tryFromWire(String? wire) => _tryFromWire(values, wire);
}

// ============================================================================
//  FEES
// ============================================================================

/// `fee_challans.status`.
enum ChallanStatus implements WireEnum {
  unpaid('unpaid'),
  paid('paid'),
  partial('partial'),
  cancelled('cancelled');

  const ChallanStatus(this.wire);

  @override
  final String wire;

  static ChallanStatus fromWire(String wire) =>
      _fromWire(values, wire, 'ChallanStatus');
  static ChallanStatus? tryFromWire(String? wire) => _tryFromWire(values, wire);

  /// Whether an outstanding balance remains, and therefore whether the amount
  /// rolls into next month's `arrears`.
  ///
  /// [cancelled] is deliberately excluded: a cancelled challan was written off,
  /// so carrying it forward would re-bill money the school already forgave.
  bool get isOutstanding =>
      this == ChallanStatus.unpaid || this == ChallanStatus.partial;
}

/// `fee_challans.payment_method`.
///
/// Recorded by the office in the admin app. There is NO payment gateway —
/// the student app displays the challan only (CLAUDE.md §8).
enum PaymentMethod implements WireEnum {
  cash('cash'),
  bank('bank'),
  online('online');

  const PaymentMethod(this.wire);

  @override
  final String wire;

  static PaymentMethod fromWire(String wire) =>
      _fromWire(values, wire, 'PaymentMethod');
  static PaymentMethod? tryFromWire(String? wire) => _tryFromWire(values, wire);
}

// ============================================================================
//  TIMETABLE & NOTICES
// ============================================================================

/// `timetable_slots.slot_type`.
///
/// Both `'class'` and `'break'` are Dart keywords, so all three identifiers
/// diverge from their wire strings here. The wire strings are what matter.
enum SlotType implements WireEnum {
  /// Wire string `'class'` (`class` is a Dart keyword).
  lesson('class'),

  /// Wire string `'break'` (`break` is a Dart keyword).
  breakTime('break'),

  assembly('assembly');

  const SlotType(this.wire);

  @override
  final String wire;

  static SlotType fromWire(String wire) => _fromWire(values, wire, 'SlotType');
  static SlotType? tryFromWire(String? wire) => _tryFromWire(values, wire);
}

/// `notices.priority`.
enum NoticePriority implements WireEnum {
  normal('normal'),
  important('important'),
  urgent('urgent');

  const NoticePriority(this.wire);

  @override
  final String wire;

  static NoticePriority fromWire(String wire) =>
      _fromWire(values, wire, 'NoticePriority');
  static NoticePriority? tryFromWire(String? wire) =>
      _tryFromWire(values, wire);
}

// ============================================================================
//  LOST & FOUND
// ============================================================================

/// `lost_items.type`.
enum LostItemType implements WireEnum {
  lost('lost'),
  found('found');

  const LostItemType(this.wire);

  @override
  final String wire;

  static LostItemType fromWire(String wire) =>
      _fromWire(values, wire, 'LostItemType');
  static LostItemType? tryFromWire(String? wire) => _tryFromWire(values, wire);
}

/// `lost_items.category`.
enum LostItemCategory implements WireEnum {
  bottle('bottle'),
  book('book'),
  uniform('uniform'),
  electronics('electronics'),
  keys('keys'),
  stationery('stationery'),
  bag('bag'),
  other('other');

  const LostItemCategory(this.wire);

  @override
  final String wire;

  static LostItemCategory fromWire(String wire) =>
      _fromWire(values, wire, 'LostItemCategory');
  static LostItemCategory? tryFromWire(String? wire) =>
      _tryFromWire(values, wire);
}

/// `lost_items.status`.
enum LostItemStatus implements WireEnum {
  open('open'),
  claimed('claimed'),
  resolved('resolved'),
  expired('expired');

  const LostItemStatus(this.wire);

  @override
  final String wire;

  static LostItemStatus fromWire(String wire) =>
      _fromWire(values, wire, 'LostItemStatus');
  static LostItemStatus? tryFromWire(String? wire) =>
      _tryFromWire(values, wire);
}

/// `lost_items.moderation`.
///
/// 800 teenagers plus free text plus photos. Non-optional — see schema.sql §7.
/// Items auto-hide once reported `autoHideReportCount` times (see policy.dart).
enum ModerationState implements WireEnum {
  pending('pending'),
  visible('visible'),
  hidden('hidden'),
  removed('removed');

  const ModerationState(this.wire);

  @override
  final String wire;

  static ModerationState fromWire(String wire) =>
      _fromWire(values, wire, 'ModerationState');
  static ModerationState? tryFromWire(String? wire) =>
      _tryFromWire(values, wire);
}

/// `item_claims.status`.
///
/// Claims go to the OFFICE, never student-to-student. These are minors: the
/// app is a notice board, the office does the handover, and a student's
/// contact details are never exposed. See schema.sql §7.
enum ClaimStatus implements WireEnum {
  pending('pending'),
  approved('approved'),
  rejected('rejected');

  const ClaimStatus(this.wire);

  @override
  final String wire;

  static ClaimStatus fromWire(String wire) =>
      _fromWire(values, wire, 'ClaimStatus');
  static ClaimStatus? tryFromWire(String? wire) => _tryFromWire(values, wire);
}

// ============================================================================
//  SYNC
// ============================================================================

/// `change_log.op`, and the `op` column of the local outbox.
///
/// [delete] never means a row was removed — schema.sql convention 3 forbids
/// hard deletes. It means a tombstone was written (`deleted_at` set), because
/// a genuinely missing row is invisible to peers and can never sync.
enum SyncOp implements WireEnum {
  upsert('upsert'),
  delete('delete');

  const SyncOp(this.wire);

  @override
  final String wire;

  static SyncOp fromWire(String wire) => _fromWire(values, wire, 'SyncOp');
  static SyncOp? tryFromWire(String? wire) => _tryFromWire(values, wire);
}

/// Status of a queued photo upload in the local `attachment_outbox`.
///
/// Local-only — this never reaches Postgres, so it is not in schema.sql.
/// Photos bypass the sync log entirely and use their own pipeline: upload the
/// FILE first, push the ROW second, or peers see broken images (CLAUDE.md §10).
enum AttachmentStatus implements WireEnum {
  pending('pending'),
  uploading('uploading'),
  uploaded('uploaded'),
  failed('failed');

  const AttachmentStatus(this.wire);

  @override
  final String wire;

  static AttachmentStatus fromWire(String wire) =>
      _fromWire(values, wire, 'AttachmentStatus');
  static AttachmentStatus? tryFromWire(String? wire) =>
      _tryFromWire(values, wire);
}
