import 'package:school_core/school_core.dart';
import 'package:test/test.dart';

void main() {
  group('AttendanceSummary.count', () {
    test('tallies each status', () {
      final summary = AttendanceSummary.count([
        AttendanceStatus.present,
        AttendanceStatus.present,
        AttendanceStatus.absent,
        AttendanceStatus.leave,
        AttendanceStatus.arrivedLate,
        AttendanceStatus.holiday,
      ]);

      expect(summary.present, 2);
      expect(summary.absent, 1);
      expect(summary.leave, 1);
      expect(summary.late, 1);
      expect(summary.holiday, 1);
      expect(summary.totalRows, 6);
    });
  });

  group('percentage — (present + late) / (total - holiday)', () {
    test('a late student counts as attended', () {
      // 18 present + 2 late over 20 school days = 100%. The student was in the
      // building; being late is a discipline matter, not an absence.
      const summary = AttendanceSummary(present: 18, late: 2);
      expect(summary.percentage, 100);
    });

    test('holidays leave the denominator entirely', () {
      // 20 present, 0 absent, 6 holidays. If holidays counted as days the
      // student could have attended, this would read 20/26 = 77% and a perfect
      // attender would look like a truant.
      const summary = AttendanceSummary(present: 20, holiday: 6);
      expect(summary.schoolDays, 20);
      expect(summary.percentage, 100);
    });

    test('leave and absent both reduce the percentage', () {
      const summary =
          AttendanceSummary(present: 15, absent: 3, leave: 2, holiday: 4);
      expect(summary.totalRows, 24);
      expect(summary.schoolDays, 20);
      expect(summary.attendedDays, 15);
      expect(summary.percentage, 75);
    });

    test('a realistic month', () {
      const summary = AttendanceSummary(
        present: 17,
        absent: 2,
        leave: 1,
        late: 2,
        holiday: 8,
      );
      expect(summary.schoolDays, 22);
      expect(summary.attendedDays, 19);
      expect(summary.percentage, closeTo(86.36, 0.01));
    });
  });

  group('empty records', () {
    test('no rows at all gives null, not zero', () {
      // A student enrolled yesterday has no record. Showing "0%" in red would
      // be both wrong and alarming — the UI must render this as "—".
      const summary = AttendanceSummary();
      expect(summary.percentage, isNull);
    });

    test('a month of nothing but holidays gives null', () {
      const summary = AttendanceSummary(holiday: 10);
      expect(summary.schoolDays, 0);
      expect(summary.percentage, isNull);
    });

    test('a student with no record is never flagged as short', () {
      const summary = AttendanceSummary();
      expect(summary.isBelow(75), isFalse);
    });
  });

  group('isBelow', () {
    test('flags a student under the threshold', () {
      const summary = AttendanceSummary(present: 14, absent: 6);
      expect(summary.percentage, 70);
      expect(summary.isBelow(75), isTrue);
    });

    test('a student exactly on the threshold is not below it', () {
      const summary = AttendanceSummary(present: 15, absent: 5);
      expect(summary.percentage, 75);
      expect(summary.isBelow(75), isFalse);
    });
  });

  test('summaries add up across months', () {
    const august = AttendanceSummary(present: 18, absent: 2, holiday: 5);
    const september = AttendanceSummary(present: 20, late: 1, holiday: 4);
    final term = august + september;

    expect(term.present, 38);
    expect(term.absent, 2);
    expect(term.late, 1);
    expect(term.holiday, 9);
    expect(term.schoolDays, 41);
  });

  test('the standalone helper agrees with the class', () {
    const summary = AttendanceSummary(present: 15, absent: 3, late: 2, holiday: 4);
    expect(
      attendancePercentage(
        present: 15,
        late: 2,
        totalRows: summary.totalRows,
        holiday: 4,
      ),
      summary.percentage,
    );
  });
}
