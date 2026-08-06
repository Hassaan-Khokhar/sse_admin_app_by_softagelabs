import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/attendance_repository.dart';
import '../widgets/status_chip.dart';
import 'faculty_screen.dart';

/// Attendance — both registers, students and faculty, under one section.
///
/// They are tabs rather than separate nav entries because they are the same
/// job done twice each morning. A principal thinking "let me take attendance"
/// should land in one place and choose who, not remember which of two sections
/// holds which register.
class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Attendance',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(icon: Icon(Icons.people_outline, size: 18), text: 'Students'),
              Tab(icon: Icon(Icons.badge_outlined, size: 18), text: 'Faculty'),
            ],
          ),
          const Divider(height: 1),
          const Expanded(
            child: TabBarView(
              children: [
                StudentAttendanceView(),
                FacultyAttendanceView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Daily student register — the screen the demo video is built around
/// (CLAUDE.md §12, 0:30: wifi off on camera, then mark 40 students).
///
/// Two things drive the design:
///
///   * **Marking must be fast.** A class teacher does this every morning for
///     40 students. "All present" then correcting the three exceptions is the
///     real workflow, not tapping 40 rows.
///   * **Every tap writes immediately** to local SQLite and the outbox. There
///     is no Save button, because there is nothing to save to — the write
///     already happened, offline, in a transaction.
class StudentAttendanceView extends StatefulWidget {
  const StudentAttendanceView({super.key});

  @override
  State<StudentAttendanceView> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<StudentAttendanceView> {
  late final AttendanceRepository _repo;
  String? _classId;
  DateTime _date = dateOnly(DateTime.now());
  bool _bulkRunning = false;

  /// Captured here rather than read inside async callbacks — reading context
  /// after an await is a lint and a lifecycle hazard.
  late String _actor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = AttendanceRepository(AppScope.databaseOf(context));
    _actor = AppScope.actorOf(context);
  }

  String get _dateKey => encodeDate(_date);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SchoolClass>>(
      stream: _repo.watchClasses(),
      builder: (context, snapshot) {
        final classes = snapshot.data ?? const [];
        if (classes.isEmpty) {
          return const _EmptyState(
            icon: Icons.fact_check_outlined,
            title: 'No classes yet',
            detail: 'Seed the demo data from the Dashboard to get started.',
          );
        }

        final selectedId = _classId ??= classes.first.id;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Toolbar(
              classes: classes,
              selectedClassId: selectedId,
              date: _date,
              onClassChanged: (id) => setState(() => _classId = id),
              onDateChanged: (date) => setState(() => _date = date),
            ),
            const Divider(height: 1),
            Expanded(child: _buildRegister(selectedId)),
          ],
        );
      },
    );
  }

  Widget _buildRegister(String classId) {
    return StreamBuilder<List<Student>>(
      stream: _repo.watchRoster(classId),
      builder: (context, rosterSnapshot) {
        final roster = rosterSnapshot.data ?? const [];
        if (roster.isEmpty) {
          return const _EmptyState(
            icon: Icons.people_outline,
            title: 'No students in this class',
            detail: 'Seed the demo data from the Dashboard.',
          );
        }

        return StreamBuilder<Map<String, AttendanceRow>>(
          stream: _repo.watchRegister(classId, _dateKey),
          builder: (context, registerSnapshot) {
            final register = registerSnapshot.data ?? const {};
            final marked = register.length;

            return Column(
              children: [
                _BulkBar(
                  total: roster.length,
                  marked: marked,
                  busy: _bulkRunning,
                  onMarkAllPresent: () => _markAll(
                    roster,
                    register,
                    AttendanceStatus.present,
                  ),
                  onMarkHoliday: () => _markAll(
                    roster,
                    register,
                    AttendanceStatus.holiday,
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.separated(
                    itemCount: roster.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final student = roster[index];
                      final row = register[student.id];
                      return _StudentRow(
                        student: student,
                        status: row == null
                            ? null
                            : AttendanceStatus.tryFromWire(row.status),
                        onChanged: (status) => _repo.mark(
                          student: student,
                          date: _dateKey,
                          status: status,
                          markedBy: _actor,
                          existingId: row?.id,
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
  }

  Future<void> _markAll(
    List<Student> roster,
    Map<String, AttendanceRow> register,
    AttendanceStatus status,
  ) async {
    setState(() => _bulkRunning = true);
    try {
      await _repo.markAll(
        roster: roster,
        existing: register,
        date: _dateKey,
        status: status,
        markedBy: _actor,
      );
    } finally {
      if (mounted) setState(() => _bulkRunning = false);
    }
  }
}

class _Toolbar extends StatelessWidget {
  const _Toolbar({
    required this.classes,
    required this.selectedClassId,
    required this.date,
    required this.onClassChanged,
    required this.onDateChanged,
  });

  final List<SchoolClass> classes;
  final String selectedClassId;
  final DateTime date;
  final ValueChanged<String> onClassChanged;
  final ValueChanged<DateTime> onDateChanged;

  @override
  Widget build(BuildContext context) {
    final today = dateOnly(DateTime.now());
    final isToday = date == today;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
      child: Row(
        children: [
          DropdownButton<String>(
            value: selectedClassId,
            onChanged: (id) => id == null ? null : onClassChanged(id),
            items: [
              for (final schoolClass in classes)
                DropdownMenuItem(
                  value: schoolClass.id,
                  child: Text('Class ${schoolClass.displayName}'),
                ),
            ],
          ),
          const SizedBox(width: 16),
          OutlinedButton.icon(
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: date,
                // Back-dating is allowed: the connection may have been down
                // for two days and the register still has to be filled in.
                firstDate: DateTime(today.year - 1),
                lastDate: today,
              );
              if (picked != null) onDateChanged(dateOnly(picked));
            },
            icon: const Icon(Icons.calendar_today, size: 16),
            label: Text(isToday ? 'Today' : encodeDate(date)),
          ),
          if (!isToday) ...[
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => onDateChanged(today),
              child: const Text('Back to today'),
            ),
          ],
        ],
      ),
    );
  }
}

class _BulkBar extends StatelessWidget {
  const _BulkBar({
    required this.total,
    required this.marked,
    required this.busy,
    required this.onMarkAllPresent,
    required this.onMarkHoliday,
  });

  final int total;
  final int marked;
  final bool busy;
  final VoidCallback onMarkAllPresent;
  final VoidCallback onMarkHoliday;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final complete = marked == total;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          Icon(
            complete ? Icons.check_circle : Icons.pending_outlined,
            size: 18,
            color: complete ? Colors.green : theme.disabledColor,
          ),
          const SizedBox(width: 8),
          Text(
            complete ? 'All $total marked' : '$marked of $total marked',
            style: theme.textTheme.bodyMedium,
          ),
          const Spacer(),
          if (busy)
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          TextButton.icon(
            onPressed: busy ? null : onMarkHoliday,
            icon: const Icon(Icons.beach_access_outlined, size: 16),
            label: const Text('Holiday'),
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: busy ? null : onMarkAllPresent,
            icon: const Icon(Icons.done_all, size: 18),
            label: const Text('All present'),
          ),
        ],
      ),
    );
  }
}

class _StudentRow extends StatelessWidget {
  const _StudentRow({
    required this.student,
    required this.status,
    required this.onChanged,
  });

  final Student student;
  final AttendanceStatus? status;
  final ValueChanged<AttendanceStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              '${student.rollNo ?? '—'}',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.disabledColor),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(student.fullName, style: theme.textTheme.bodyLarge),
                Text(
                  student.admissionNo,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.disabledColor),
                ),
              ],
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
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
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
