import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/faculty_repository.dart';
import '../widgets/status_chip.dart';

/// Faculty register — every teacher, their attendance today, and their record
/// over the last two months.
///
/// Same interaction as the student register: tap a chip and it is written
/// immediately to local SQLite and the outbox. No Save button, because there
/// is nothing left to save.
class FacultyScreen extends StatefulWidget {
  const FacultyScreen({super.key});

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  late final FacultyRepository _repo;
  DateTime _date = dateOnly(DateTime.now());
  bool _busy = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = FacultyRepository(AppScope.databaseOf(context));
  }

  String get _dateKey => encodeDate(_date);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Teacher>>(
      stream: _repo.watchTeachers(),
      builder: (context, teacherSnapshot) {
        final teachers = teacherSnapshot.data ?? const [];
        if (teachers.isEmpty) {
          return const _Empty(
            icon: Icons.badge_outlined,
            title: 'No faculty yet',
            detail: 'Seed the demo data from the Dashboard to add teachers.',
          );
        }

        return StreamBuilder<Map<String, TeacherAttendanceRow>>(
          stream: _repo.watchRegister(_dateKey),
          builder: (context, registerSnapshot) {
            final register = registerSnapshot.data ?? const {};

            return StreamBuilder<Map<String, AttendanceSummary>>(
              stream: _repo.watchSummaries(),
              builder: (context, summarySnapshot) {
                final summaries = summarySnapshot.data ?? const {};

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Header(
                      date: _date,
                      total: teachers.length,
                      marked: register.length,
                      busy: _busy,
                      onDateChanged: (date) => setState(() => _date = date),
                      onMarkAllPresent: () =>
                          _markAll(teachers, register, AttendanceStatus.present),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: ListView.separated(
                        itemCount: teachers.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final teacher = teachers[index];
                          final row = register[teacher.id];
                          return _TeacherRow(
                            teacher: teacher,
                            row: row,
                            summary: summaries[teacher.id],
                            onChanged: (status) => _repo.mark(
                              teacher: teacher,
                              date: _dateKey,
                              status: status,
                              markedBy: DemoSeeder.principalUserId,
                              existingId: row?.id,
                              checkInTime: row?.checkInTime,
                              remarks: row?.remarks,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _markAll(
    List<Teacher> teachers,
    Map<String, TeacherAttendanceRow> register,
    AttendanceStatus status,
  ) async {
    setState(() => _busy = true);
    try {
      await _repo.markAll(
        teachers: teachers,
        existing: register,
        date: _dateKey,
        status: status,
        // TODO(auth): the signed-in principal, once the session is threaded
        //   through. marked_by is NOT NULL REFERENCES app_users(id).
        markedBy: DemoSeeder.principalUserId,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.date,
    required this.total,
    required this.marked,
    required this.busy,
    required this.onDateChanged,
    required this.onMarkAllPresent,
  });

  final DateTime date;
  final int total;
  final int marked;
  final bool busy;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onMarkAllPresent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final today = dateOnly(DateTime.now());
    final isToday = date == today;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Faculty', style: theme.textTheme.headlineSmall),
              const SizedBox(width: 16),
              Text(
                '$total teachers',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.disabledColor),
              ),
              const Spacer(),
              OutlinedButton.icon(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(today.year - 1),
                    lastDate: today,
                  );
                  if (picked != null) onDateChanged(dateOnly(picked));
                },
                icon: const Icon(Icons.calendar_today, size: 16),
                label: Text(isToday ? 'Today' : encodeDate(date)),
              ),
              const SizedBox(width: 8),
              if (busy)
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              FilledButton.icon(
                onPressed: busy ? null : onMarkAllPresent,
                icon: const Icon(Icons.done_all, size: 18),
                label: const Text('All present'),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            marked == total
                ? 'All $total marked for ${isToday ? 'today' : encodeDate(date)}'
                : '$marked of $total marked',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _TeacherRow extends StatelessWidget {
  const _TeacherRow({
    required this.teacher,
    required this.row,
    required this.summary,
    required this.onChanged,
  });

  final Teacher teacher;
  final TeacherAttendanceRow? row;
  final AttendanceSummary? summary;
  final ValueChanged<AttendanceStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = row == null ? null : AttendanceStatus.tryFromWire(row!.status);
    final percentage = summary?.percentage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Text(
              _initials(teacher.fullName),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(teacher.fullName, style: theme.textTheme.bodyLarge),
                Text(
                  [
                    ?teacher.employeeNo,
                    ?teacher.qualification,
                  ].join(' · '),
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.disabledColor),
                ),
              ],
            ),
          ),
          // Two-month record. Null renders as "—", never 0% — a teacher who
          // joined last week has no record, and showing 0 would read as a
          // discipline problem.
          SizedBox(
            width: 92,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  percentage == null ? '—' : '${percentage.toStringAsFixed(0)}%',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: percentage != null && percentage < 90
                        ? theme.colorScheme.error
                        : null,
                  ),
                ),
                Text(
                  '60 days',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.disabledColor),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 74,
            child: Text(
              row?.checkInTime ?? '',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.disabledColor),
            ),
          ),
          for (final option in AttendanceStatus.values)
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: StatusChip(
                status: option,
                selected: status == option,
                onTap: () => onChanged(option),
              ),
            ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.characters.take(2).toString();
    return '${parts.first.characters.first}${parts.last.characters.first}';
  }
}

class _Empty extends StatelessWidget {
  const _Empty({
    required this.icon,
    required this.title,
    required this.detail,
  });

  final IconData icon;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: theme.disabledColor),
          const SizedBox(height: 12),
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(detail, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
