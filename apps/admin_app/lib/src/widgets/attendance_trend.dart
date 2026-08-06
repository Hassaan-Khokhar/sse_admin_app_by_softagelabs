import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../theme/app_theme.dart';

/// School-wide attendance for the last fortnight.
///
/// A bar chart because the job is *change over time* across a small, discrete
/// set of days. A line would imply attendance flows continuously between
/// Tuesday and Wednesday; it does not — each day is its own measurement.
///
/// One series, so no legend: the title names it. No number printed on every
/// bar either — only the extremes are labelled, because a value on all
/// fourteen turns a chart back into a table.
class AttendanceTrendCard extends StatelessWidget {
  const AttendanceTrendCard({super.key});

  static const _days = 14;

  @override
  Widget build(BuildContext context) {
    final db = AppScope.databaseOf(context);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Attendance, last $_days school days',
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 2),
            Text('Present and late, as a share of students marked',
                style: theme.textTheme.bodySmall),
            const SizedBox(height: 22),
            SizedBox(
              height: 168,
              child: StreamBuilder<List<_DayPoint>>(
                stream: _watchTrend(db),
                builder: (context, snapshot) {
                  final points = snapshot.data ?? const <_DayPoint>[];
                  if (points.isEmpty) {
                    return Center(
                      child: Text('No attendance recorded yet',
                          style: theme.textTheme.bodyMedium),
                    );
                  }
                  return _Bars(points: points);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Attendance percentage per day, oldest first.
  ///
  /// Aggregated in Dart so the shared [AttendanceSummary] does the arithmetic.
  /// A hand-written SQL aggregate here would be a second implementation of
  /// `(present + late) / (total - holiday)`, free to drift from the one the
  /// student app uses — and a parent comparing two screens would find them
  /// disagreeing.
  Stream<List<_DayPoint>> _watchTrend(AppDatabase db) {
    final cutoff = encodeDate(
      dateOnly(DateTime.now()).subtract(const Duration(days: _days * 2)),
    );

    final query = db.select(db.attendance)
      ..where((a) =>
          a.deletedAt.isNull() & a.date.isBiggerOrEqualValue(cutoff))
      ..orderBy([(a) => drift.OrderingTerm.asc(a.date)]);

    return query.watch().map((rows) {
      final byDate = <String, List<AttendanceStatus>>{};
      for (final row in rows) {
        final status = AttendanceStatus.tryFromWire(row.status);
        if (status == null) continue;
        byDate.putIfAbsent(row.date, () => []).add(status);
      }

      final dates = byDate.keys.toList()..sort();
      final recent = dates.length > _days
          ? dates.sublist(dates.length - _days)
          : dates;

      return [
        for (final date in recent)
          _DayPoint(
            date: date,
            percentage: AttendanceSummary.count(byDate[date]!).percentage,
          ),
      ];
    });
  }
}

class _DayPoint {
  const _DayPoint({required this.date, required this.percentage});

  final String date;

  /// Null on a day that was entirely holiday — rendered as a gap, never as 0%.
  final double? percentage;
}

class _Bars extends StatelessWidget {
  const _Bars({required this.points});

  final List<_DayPoint> points;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final values = points.map((p) => p.percentage).nonNulls.toList();
    if (values.isEmpty) {
      return Center(
        child: Text('Only holidays in this period',
            style: theme.textTheme.bodyMedium),
      );
    }

    final lowest = values.reduce((a, b) => a < b ? a : b);
    final highest = values.reduce((a, b) => a > b ? a : b);

    // Bars start at 50%, not 0. Attendance never realistically drops below
    // half, and a 0-based axis would squeeze every day into the top sliver
    // where a 12-point swing is invisible. The axis label says so — an
    // unlabelled truncated axis is the dishonest version of this.
    const floor = 50.0;

    return Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final point in points)
                Expanded(
                  child: _Bar(
                    point: point,
                    floor: floor,
                    isLowest: point.percentage == lowest,
                    isHighest: point.percentage == highest && highest != lowest,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text('$floor%', style: theme.textTheme.bodySmall),
            const Spacer(),
            Text(
              '${_short(points.first.date)} — ${_short(points.last.date)}',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  static String _short(String isoDate) {
    final parts = isoDate.split('-');
    if (parts.length != 3) return isoDate;
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${int.parse(parts[2])} ${months[int.parse(parts[1]) - 1]}';
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    required this.point,
    required this.floor,
    required this.isLowest,
    required this.isHighest,
  });

  final _DayPoint point;
  final double floor;
  final bool isLowest;
  final bool isHighest;

  @override
  Widget build(BuildContext context) {
    final pct = point.percentage;

    // A holiday is not zero attendance — it is no measurement. Drawing a
    // full-height empty slot keeps the day in place without claiming the
    // school had nobody in.
    if (pct == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 3),
        child: SizedBox.expand(),
      );
    }

    final fraction = ((pct - floor) / (100 - floor)).clamp(0.06, 1.0);
    // The worst day is worth spotting at a glance; everything else is context.
    final color = isLowest ? AppTheme.accentOrange : AppTheme.navyLight;

    return Tooltip(
      message: '${point.date} · ${pct.toStringAsFixed(1)}%',
      waitDuration: const Duration(milliseconds: 250),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isLowest || isHighest)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '${pct.round()}%',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isLowest ? AppTheme.accentOrange : AppTheme.inkMuted,
                  ),
                ),
              ),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: fraction,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    // Rounded only at the data end, anchored flat to the
                    // baseline — a pill floating off the axis misreads as a
                    // range rather than a magnitude.
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Today's register at a glance, broken down by status.
class TodaySnapshotCard extends StatelessWidget {
  const TodaySnapshotCard({super.key});

  @override
  Widget build(BuildContext context) {
    final db = AppScope.databaseOf(context);
    final theme = Theme.of(context);
    final today = encodeDate(DateTime.now());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today', style: theme.textTheme.titleMedium),
            const SizedBox(height: 2),
            Text('Student register for $today',
                style: theme.textTheme.bodySmall),
            const SizedBox(height: 18),
            StreamBuilder<AttendanceSummary>(
              stream: _watchToday(db, today),
              builder: (context, snapshot) {
                final summary = snapshot.data ?? const AttendanceSummary();
                if (summary.totalRows == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    child: Row(
                      children: [
                        const Icon(Icons.pending_outlined,
                            size: 18, color: AppTheme.inkMuted),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text('Not marked yet',
                              style: theme.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  );
                }

                final pct = summary.percentage;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          pct == null ? '—' : '${pct.toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.ink,
                            height: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('present',
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _StatusLine(
                        color: AppTheme.statusPresent,
                        label: 'Present',
                        count: summary.present),
                    _StatusLine(
                        color: AppTheme.statusLate,
                        label: 'Late',
                        count: summary.late),
                    _StatusLine(
                        color: AppTheme.statusLeave,
                        label: 'Leave',
                        count: summary.leave),
                    _StatusLine(
                        color: AppTheme.statusAbsent,
                        label: 'Absent',
                        count: summary.absent),
                    if (summary.holiday > 0)
                      _StatusLine(
                          color: AppTheme.statusHoliday,
                          label: 'Holiday',
                          count: summary.holiday),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Stream<AttendanceSummary> _watchToday(AppDatabase db, String today) {
    final query = db.select(db.attendance)
      ..where((a) => a.deletedAt.isNull() & a.date.equals(today));
    return query.watch().map(
          (rows) => AttendanceSummary.count(
            rows.map((r) => AttendanceStatus.tryFromWire(r.status)).nonNulls,
          ),
        );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({
    required this.color,
    required this.label,
    required this.count,
  });

  final Color color;
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Swatch plus written label. `late` and `leave` are nearly
          // indistinguishable under deuteranopia (ΔE 2.9), so the word is
          // doing the work and the colour is only an aid.
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.ink,
            ),
          ),
        ],
      ),
    );
  }
}
