import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/school_repository.dart';
import '../widgets/empty_state.dart';

/// Weekly timetable for a class, as a day × period grid.
///
/// A grid rather than a list because that is how a timetable is read — "what
/// is 9-A doing in period 3 on Wednesday" is a two-axis question, and a flat
/// list forces the reader to reconstruct the grid in their head.
class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  late final SchoolRepository _repo;
  String? _classId;

  /// Monday–Saturday. Sunday is the weekly holiday in Pakistani schools, so it
  /// is not a column — an always-empty column is just noise.
  static const _days = [
    (day: 1, label: 'Mon'),
    (day: 2, label: 'Tue'),
    (day: 3, label: 'Wed'),
    (day: 4, label: 'Thu'),
    (day: 5, label: 'Fri'),
    (day: 6, label: 'Sat'),
  ];

  static const _periods = 8;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = SchoolRepository(AppScope.databaseOf(context));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<SchoolClass>>(
      stream: _repo.watchClasses(),
      builder: (context, classSnapshot) {
        final classes = classSnapshot.data ?? const [];
        if (classes.isEmpty) {
          return const EmptyState(
            icon: Icons.schedule_outlined,
            title: 'No classes',
            detail: 'Add a class first — a timetable belongs to a class.',
          );
        }
        final classId = _classId ??= classes.first.id;
        final schoolClass = classes.firstWhere((c) => c.id == classId,
            orElse: () => classes.first);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  Text('Timetable', style: theme.textTheme.headlineSmall),
                  const SizedBox(width: 24),
                  DropdownButton<String>(
                    value: classId,
                    onChanged: (id) => setState(() => _classId = id),
                    items: [
                      for (final c in classes)
                        DropdownMenuItem(
                            value: c.id, child: Text('Class ${c.displayName}')),
                    ],
                  ),
                  const Spacer(),
                  Text('Tap any cell to set the period',
                      style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: StreamBuilder<List<TimetableSlot>>(
                stream: _repo.watchTimetable(classId),
                builder: (context, snapshot) {
                  final slots = snapshot.data ?? const [];
                  final byCell = {
                    for (final s in slots) '${s.dayOfWeek}/${s.periodNo}': s,
                  };
                  return _buildGrid(schoolClass, byCell);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGrid(
    SchoolClass schoolClass,
    Map<String, TimetableSlot> byCell,
  ) {
    return StreamBuilder<List<Subject>>(
      stream: _repo.watchSubjects(schoolClass.id),
      builder: (context, snapshot) {
        final subjects = snapshot.data ?? const [];
        final subjectsById = {for (final s in subjects) s.id: s};

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              defaultColumnWidth: const FixedColumnWidth(150),
              border: TableBorder.all(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(6),
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  children: [
                    const _HeaderCell('Period'),
                    for (final day in _days) _HeaderCell(day.label),
                  ],
                ),
                for (var period = 1; period <= _periods; period++)
                  TableRow(
                    children: [
                      _HeaderCell('$period'),
                      for (final day in _days)
                        _SlotCell(
                          slot: byCell['${day.day}/$period'],
                          subject: subjectsById[
                              byCell['${day.day}/$period']?.subjectId],
                          onTap: () => _editSlot(
                            schoolClass: schoolClass,
                            subjects: subjects,
                            dayOfWeek: day.day,
                            periodNo: period,
                            existing: byCell['${day.day}/$period'],
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _editSlot({
    required SchoolClass schoolClass,
    required List<Subject> subjects,
    required int dayOfWeek,
    required int periodNo,
    TimetableSlot? existing,
  }) async {
    final teachers = await _repo.watchTeachers().first;
    if (!mounted) return;

    // School day starts at 08:00 with 40-minute periods — a sensible default
    // the principal can overwrite, rather than an empty field to fill 48 times.
    final defaultStart = 8 * 60 + (periodNo - 1) * 40;
    final start = TextEditingController(
        text: existing?.startTime ?? _formatMinutes(defaultStart));
    final end = TextEditingController(
        text: existing?.endTime ?? _formatMinutes(defaultStart + 40));

    var subjectId = existing?.subjectId;
    var teacherId = existing?.teacherId;
    var slotType = existing?.slotType ?? SlotType.lesson.wire;

    final result = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: Text('${_days.firstWhere((d) => d.day == dayOfWeek).label} '
              '· Period $periodNo'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: slotType,
                  decoration: const InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final t in SlotType.values)
                      DropdownMenuItem(value: t.wire, child: Text(t.wire)),
                  ],
                  onChanged: (v) => setLocal(() => slotType = v ?? slotType),
                ),
                const SizedBox(height: 12),
                // Null subject is valid — that is what a break or assembly is.
                DropdownButtonFormField<String?>(
                  initialValue: subjectId,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem(
                        value: null, child: Text('None (break / assembly)')),
                    for (final s in subjects)
                      DropdownMenuItem(value: s.id, child: Text(s.name)),
                  ],
                  onChanged: (v) => setLocal(() => subjectId = v),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String?>(
                  initialValue: teacherId,
                  decoration: const InputDecoration(
                    labelText: 'Teacher',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Unassigned')),
                    for (final t in teachers)
                      DropdownMenuItem(value: t.id, child: Text(t.fullName)),
                  ],
                  onChanged: (v) => setLocal(() => teacherId = v),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: start,
                        decoration: const InputDecoration(
                          labelText: 'Start (HH:MM)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: end,
                        decoration: const InputDecoration(
                          labelText: 'End (HH:MM)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            if (existing != null)
              TextButton(
                onPressed: () => Navigator.pop(context, 'delete'),
                child: const Text('Clear'),
              ),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.pop(context, 'save'),
                child: const Text('Save')),
          ],
        ),
      ),
    );

    if (result == 'save') {
      await _repo.saveSlot(
        schoolId: schoolClass.schoolId,
        classId: schoolClass.id,
        id: existing?.id,
        subjectId: subjectId,
        teacherId: teacherId,
        dayOfWeek: dayOfWeek,
        periodNo: periodNo,
        startTime: start.text.trim(),
        endTime: end.text.trim(),
        slotType: slotType,
      );
    } else if (result == 'delete' && existing != null) {
      await _repo.deleteSlot(existing.id);
    }

    start.dispose();
    end.dispose();
  }

  static String _formatMinutes(int minutes) =>
      '${(minutes ~/ 60).toString().padLeft(2, '0')}:'
      '${(minutes % 60).toString().padLeft(2, '0')}';
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
      );
}

class _SlotCell extends StatelessWidget {
  const _SlotCell({
    required this.slot,
    required this.subject,
    required this.onTap,
  });

  final TimetableSlot? slot;
  final Subject? subject;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final type = slot == null ? null : SlotType.tryFromWire(slot!.slotType);

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 66,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        color: switch (type) {
          SlotType.breakTime => theme.colorScheme.surfaceContainerHighest,
          SlotType.assembly =>
            theme.colorScheme.tertiaryContainer.withValues(alpha: 0.35),
          _ => null,
        },
        child: slot == null
            ? Center(
                child: Icon(Icons.add, size: 16, color: theme.disabledColor),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject?.name ?? (type?.wire ?? '—'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  const Spacer(),
                  Text(
                    '${slot!.startTime}–${slot!.endTime}',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.disabledColor),
                  ),
                ],
              ),
      ),
    );
  }
}
