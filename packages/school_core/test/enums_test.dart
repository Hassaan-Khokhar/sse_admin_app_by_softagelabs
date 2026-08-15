import 'package:school_core/school_core.dart';
import 'package:test/test.dart';

/// These tests exist to make one specific mistake impossible: silently
/// changing a wire string.
///
/// The strings are the contract with the student app, which lives in another
/// repo in another city. A rename that looks like a harmless tidy-up here
/// becomes a row the phone cannot parse — and because the two apps ship
/// separately, nobody finds out until the demo.
///
/// The literal lists below are transcribed from the CHECK constraints in
/// schema.sql. If a test fails, the fix is a migration and a message to the
/// other dev, not an edit to the expectation.
void main() {
  group('wire strings match schema.sql CHECK constraints', () {
    void expectWires<T extends WireEnum>(List<T> values, List<String> wires) {
      expect(values.map((e) => e.wire).toList(), wires);
    }

    test('app_users.role', () {
      expectWires(UserRole.values, ['super_admin', 'teacher', 'student']);
    });

    test('students.gender', () {
      expectWires(Gender.values, ['male', 'female']);
    });

    test('students.status', () {
      expectWires(StudentStatus.values,
          ['active', 'withdrawn', 'graduated', 'suspended']);
    });

    test('attendance.status', () {
      expectWires(AttendanceStatus.values,
          ['present', 'absent', 'leave', 'late', 'holiday']);
    });

    test('exams.exam_type', () {
      expectWires(ExamType.values,
          ['first_term', 'mid_term', 'final_term', 'test', 'quiz']);
    });

    test('fee_challans.status', () {
      expectWires(
          ChallanStatus.values, ['unpaid', 'paid', 'partial', 'cancelled']);
    });

    test('fee_challans.payment_method', () {
      expectWires(PaymentMethod.values, ['cash', 'bank', 'online']);
    });

    test('timetable_slots.slot_type', () {
      expectWires(SlotType.values, ['class', 'break', 'assembly']);
    });

    test('notices.priority', () {
      expectWires(NoticePriority.values, ['normal', 'important', 'urgent']);
    });

    test('lost_items.type', () {
      expectWires(LostItemType.values, ['lost', 'found']);
    });

    test('lost_items.category', () {
      expectWires(LostItemCategory.values, [
        'bottle',
        'book',
        'uniform',
        'electronics',
        'keys',
        'stationery',
        'bag',
        'other',
      ]);
    });

    test('lost_items.status', () {
      expectWires(
          LostItemStatus.values, ['open', 'claimed', 'resolved', 'expired']);
    });

    test('lost_items.moderation', () {
      expectWires(
          ModerationState.values, ['pending', 'visible', 'hidden', 'removed']);
    });

    test('item_claims.status', () {
      expectWires(ClaimStatus.values, ['pending', 'approved', 'rejected']);
    });

    test('change_log.op', () {
      expectWires(SyncOp.values, ['upsert', 'delete']);
    });
  });

  group('parsing', () {
    test('fromWire round-trips every value', () {
      for (final value in AttendanceStatus.values) {
        expect(AttendanceStatus.fromWire(value.wire), value);
      }
      for (final value in StudentStatus.values) {
        expect(StudentStatus.fromWire(value.wire), value);
      }
      for (final value in SlotType.values) {
        expect(SlotType.fromWire(value.wire), value);
      }
    });

    test('fromWire throws on an unknown value', () {
      expect(() => AttendanceStatus.fromWire('Present'),
          throwsA(isA<ArgumentError>()));
      expect(() => AttendanceStatus.fromWire('P'),
          throwsA(isA<ArgumentError>()));
    });

    test('tryFromWire returns null instead of throwing', () {
      // The sync loop depends on this. If an old client threw on a value a
      // newer peer introduced, it would crash on every pull and never advance
      // its cursor past the offending row — permanently stuck.
      expect(AttendanceStatus.tryFromWire('half_day'), isNull);
      expect(AttendanceStatus.tryFromWire(null), isNull);
      expect(AttendanceStatus.tryFromWire('present'), AttendanceStatus.present);
    });

    test('parsing is case-sensitive', () {
      // schema.sql is explicit: 'present', not 'Present', not 'P'.
      expect(StudentStatus.tryFromWire('Active'), isNull);
      expect(UserRole.tryFromWire('SUPER_ADMIN'), isNull);
    });
  });

  group('domain helpers', () {
    test('late counts as attended, holiday is not a school day', () {
      expect(AttendanceStatus.present.countsAsAttended, isTrue);
      expect(AttendanceStatus.arrivedLate.countsAsAttended, isTrue);
      expect(AttendanceStatus.absent.countsAsAttended, isFalse);
      expect(AttendanceStatus.leave.countsAsAttended, isFalse);
      expect(AttendanceStatus.holiday.countsAsAttended, isFalse);

      expect(AttendanceStatus.holiday.isNonSchoolDay, isTrue);
      expect(AttendanceStatus.absent.isNonSchoolDay, isFalse);
    });

    test('role precedence puts the principal on top', () {
      expect(UserRole.superAdmin.precedence,
          greaterThan(UserRole.teacher.precedence));
      expect(UserRole.teacher.precedence,
          greaterThan(UserRole.student.precedence));
    });

    test('only active students appear in day-to-day lists', () {
      expect(StudentStatus.active.isEnrolled, isTrue);
      expect(StudentStatus.withdrawn.isEnrolled, isFalse);
      expect(StudentStatus.graduated.isEnrolled, isFalse);
      expect(StudentStatus.suspended.isEnrolled, isFalse);
    });

    test('cancelled challans do not roll into arrears', () {
      expect(ChallanStatus.unpaid.isOutstanding, isTrue);
      expect(ChallanStatus.partial.isOutstanding, isTrue);
      expect(ChallanStatus.paid.isOutstanding, isFalse);
      // A cancelled challan was written off. Carrying it forward would re-bill
      // money the school already forgave.
      expect(ChallanStatus.cancelled.isOutstanding, isFalse);
    });
  });
}
