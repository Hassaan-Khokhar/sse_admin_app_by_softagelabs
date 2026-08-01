/// Attendance aggregation, shared by both apps.
///
/// The formula is fixed by CLAUDE.md §9:
///
/// ```
/// attendance % = (present + late) / (total - holiday)
/// ```
///
/// Two details in that line are easy to get wrong and both change the number a
/// parent sees:
///   * a LATE student was in the building, so they count as attended;
///   * a HOLIDAY was never a day the student could attend, so it leaves the
///     denominator entirely rather than counting as an absence.
library;

import 'enums.dart';

/// A tally of attendance rows over some period — a month, a term, a year.
class AttendanceSummary {
  const AttendanceSummary({
    this.present = 0,
    this.absent = 0,
    this.leave = 0,
    this.late = 0,
    this.holiday = 0,
  });

  /// Tallies [statuses], which is typically a month of `attendance` rows for
  /// one student.
  factory AttendanceSummary.count(Iterable<AttendanceStatus> statuses) {
    var present = 0;
    var absent = 0;
    var leave = 0;
    var late = 0;
    var holiday = 0;

    for (final status in statuses) {
      switch (status) {
        case AttendanceStatus.present:
          present++;
        case AttendanceStatus.absent:
          absent++;
        case AttendanceStatus.leave:
          leave++;
        case AttendanceStatus.arrivedLate:
          late++;
        case AttendanceStatus.holiday:
          holiday++;
      }
    }

    return AttendanceSummary(
      present: present,
      absent: absent,
      leave: leave,
      late: late,
      holiday: holiday,
    );
  }

  final int present;
  final int absent;
  final int leave;
  final int late;
  final int holiday;

  /// Every row tallied, holidays included.
  int get totalRows => present + absent + leave + late + holiday;

  /// Days the student could actually have attended — the denominator.
  int get schoolDays => totalRows - holiday;

  /// Days counted as attended — the numerator.
  int get attendedDays => present + late;

  /// Attendance as a percentage in 0..100, or null when there is nothing to
  /// average.
  ///
  /// Null rather than 0 is deliberate. A student enrolled yesterday, or a month
  /// that is nothing but holidays, has no attendance record — and showing a
  /// brand-new student "0%" in red would be both wrong and alarming. Callers
  /// should render null as "—", not as a number.
  double? get percentage {
    if (schoolDays <= 0) return null;
    return attendedDays / schoolDays * 100;
  }

  /// True when the student is below [threshold] percent.
  ///
  /// A student with no record yet is never short — [percentage] is null and
  /// there is nothing to judge them on.
  bool isBelow(double threshold) {
    final pct = percentage;
    return pct != null && pct < threshold;
  }

  AttendanceSummary operator +(AttendanceSummary other) => AttendanceSummary(
        present: present + other.present,
        absent: absent + other.absent,
        leave: leave + other.leave,
        late: late + other.late,
        holiday: holiday + other.holiday,
      );

  @override
  String toString() => 'AttendanceSummary(present: $present, absent: $absent, '
      'leave: $leave, late: $late, holiday: $holiday)';
}

/// Convenience wrapper over [AttendanceSummary.percentage] for callers that
/// already hold raw counts rather than rows.
double? attendancePercentage({
  required int present,
  required int late,
  required int totalRows,
  required int holiday,
}) {
  final schoolDays = totalRows - holiday;
  if (schoolDays <= 0) return null;
  return (present + late) / schoolDays * 100;
}
