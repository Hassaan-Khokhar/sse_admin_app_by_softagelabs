import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/attendance_repository.dart';

/// Daily attendance register — the screen the demo video is built around
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
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late final AttendanceRepository _repo;
  String? _classId;
  DateTime _date = dateOnly(DateTime.now());
  bool _bulkRunning = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = AttendanceRepository(AppScope.databaseOf(context));
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
                          markedBy: DemoSeeder.principalUserId,
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
        // TODO(auth): the signed-in principal, once login exists. Until then
        //   the seeded principal stands in — `marked_by` is NOT NULL and
        //   references app_users, so it cannot simply be left blank.
        markedBy: DemoSeeder.principalUserId,
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
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
      child: Row(
        children: [
          Text('Attendance', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(width: 24),
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
              child: _StatusChip(
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

/// One of the five states, coloured to match the student app's calendar.
///
/// The colour contract is fixed in schema.sql §3 and shared with the mobile
/// dev: present 🟢 · absent 🔴 · leave 🟡 · late 🟠 · holiday ⬜. Both apps must
/// agree, or a parent comparing the two screens sees different answers.
class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.status,
    required this.selected,
    required this.onTap,
  });

  final AttendanceStatus status;
  final bool selected;
  final VoidCallback onTap;

  static const _colors = {
    AttendanceStatus.present: Color(0xFF16A34A),
    AttendanceStatus.absent: Color(0xFFDC2626),
    AttendanceStatus.leave: Color(0xFFCA8A04),
    AttendanceStatus.arrivedLate: Color(0xFFEA580C),
    AttendanceStatus.holiday: Color(0xFF6B7280),
  };

  static const _labels = {
    AttendanceStatus.present: 'P',
    AttendanceStatus.absent: 'A',
    AttendanceStatus.leave: 'L',
    AttendanceStatus.arrivedLate: 'Late',
    AttendanceStatus.holiday: 'H',
  };

  @override
  Widget build(BuildContext context) {
    final color = _colors[status]!;
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
            _labels[status]!,
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
