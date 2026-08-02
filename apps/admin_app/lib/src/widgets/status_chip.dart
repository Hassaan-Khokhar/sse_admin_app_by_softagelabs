import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../theme/app_theme.dart';

/// One of the five attendance states, as a tappable chip.
///
/// Shared by the student register and the faculty register so the two cannot
/// drift apart. The colours are a contract with the mobile dev, fixed in
/// schema.sql §3:
///
///   present 🟢 · absent 🔴 · leave 🟡 · late 🟠 · holiday ⬜
///
/// If the admin app and the student app coloured these differently, a parent
/// holding the phone next to the office screen would see two different
/// answers to the same question.
class StatusChip extends StatelessWidget {
  const StatusChip({
    required this.status,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final AttendanceStatus status;
  final bool selected;
  final VoidCallback onTap;

  static const colors = {
    AttendanceStatus.present: AppTheme.statusPresent,
    AttendanceStatus.absent: AppTheme.statusAbsent,
    AttendanceStatus.leave: AppTheme.statusLeave,
    AttendanceStatus.arrivedLate: AppTheme.statusLate,
    AttendanceStatus.holiday: AppTheme.statusHoliday,
  };

  static const labels = {
    AttendanceStatus.present: 'P',
    AttendanceStatus.absent: 'A',
    AttendanceStatus.leave: 'L',
    AttendanceStatus.arrivedLate: 'Late',
    AttendanceStatus.holiday: 'H',
  };

  @override
  Widget build(BuildContext context) {
    final color = colors[status]!;
    return Tooltip(
      message: status.wire,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: selected ? color : color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: selected ? color : color.withValues(alpha: 0.35),
            ),
          ),
          child: Text(
            labels[status]!,
            style: TextStyle(
              color: selected ? Colors.white : color,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
