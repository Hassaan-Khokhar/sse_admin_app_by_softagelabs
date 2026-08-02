import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/school_repository.dart';
import '../widgets/empty_state.dart';

/// Homework and assignments the class can see.
///
/// View-only on the student side — students do not submit through the app in
/// v1 (CLAUDE.md §9). This screen posts them; nothing here collects anything
/// back.
class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  late final SchoolRepository _repo;
  late String _actor;
  String? _classId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = SchoolRepository(AppScope.databaseOf(context));
    _actor = AppScope.actorOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<SchoolClass>>(
      stream: _repo.watchClasses(),
      builder: (context, classSnapshot) {
        final classes = classSnapshot.data ?? const [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  Text('Assignments', style: theme.textTheme.headlineSmall),
                  const SizedBox(width: 24),
                  DropdownButton<String?>(
                    value: _classId,
                    hint: const Text('All classes'),
                    onChanged: (id) => setState(() => _classId = id),
                    items: [
                      const DropdownMenuItem(
                          value: null, child: Text('All classes')),
                      for (final c in classes)
                        DropdownMenuItem(
                            value: c.id, child: Text('Class ${c.displayName}')),
                    ],
                  ),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: classes.isEmpty ? null : () => _compose(classes),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('New assignment'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: StreamBuilder<List<Assignment>>(
                stream: _repo.watchAssignments(classId: _classId),
                builder: (context, snapshot) {
                  final assignments = snapshot.data ?? const [];
                  if (assignments.isEmpty) {
                    return const EmptyState(
                      icon: Icons.assignment_outlined,
                      title: 'No assignments',
                      detail: 'Anything posted here appears on the class\'s '
                          'phones at the next sync. Students view only — they '
                          'do not submit through the app.',
                    );
                  }
                  return ListView.separated(
                    itemCount: assignments.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final a = assignments[i];
                      final className = classes
                          .where((c) => c.id == a.classId)
                          .map((c) => c.displayName)
                          .firstOrNull;
                      final overdue = a.dueDate != null &&
                          a.dueDate!.compareTo(encodeDate(DateTime.now())) < 0;

                      return ListTile(
                        leading: Icon(
                          Icons.assignment_outlined,
                          color: overdue ? theme.disabledColor : null,
                        ),
                        title: Text(a.title),
                        subtitle: Text([
                          if (className != null) 'Class $className',
                          'set ${a.assignedDate}',
                          if (a.dueDate case final d?) 'due $d',
                          ?a.description,
                        ].join(' · '), maxLines: 2, overflow: TextOverflow.ellipsis),
                        trailing: IconButton(
                          tooltip: 'Remove',
                          icon: const Icon(Icons.delete_outline, size: 18),
                          onPressed: () => _repo.deleteAssignment(a.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _compose(List<SchoolClass> classes) async {
    var classId = _classId ?? classes.first.id;
    final subjects = await _repo.watchSubjects(classId).first;
    if (!mounted) return;

    final title = TextEditingController();
    final description = TextEditingController();
    var subjectId = subjects.firstOrNull?.id;
    var dueDate = DateTime.now().add(const Duration(days: 7));

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: const Text('New assignment'),
          content: SizedBox(
            width: 480,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: title,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: description,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Details',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: classId,
                        decoration: const InputDecoration(
                          labelText: 'Class',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          for (final c in classes)
                            DropdownMenuItem(
                                value: c.id, child: Text(c.displayName)),
                        ],
                        onChanged: (v) => setLocal(() => classId = v ?? classId),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String?>(
                        initialValue: subjectId,
                        decoration: const InputDecoration(
                          labelText: 'Subject',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem(
                              value: null, child: Text('None')),
                          for (final s in subjects)
                            DropdownMenuItem(value: s.id, child: Text(s.name)),
                        ],
                        onChanged: (v) => setLocal(() => subjectId = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Due'),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: dueDate,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) setLocal(() => dueDate = picked);
                      },
                      icon: const Icon(Icons.calendar_today, size: 16),
                      label: Text(encodeDate(dueDate)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Post')),
          ],
        ),
      ),
    );

    if ((saved ?? false) && title.text.trim().isNotEmpty) {
      final schoolClass = classes.firstWhere((c) => c.id == classId);
      await _repo.saveAssignment(
        schoolId: schoolClass.schoolId,
        classId: classId,
        subjectId: subjectId,
        title: title.text.trim(),
        description:
            description.text.trim().isEmpty ? null : description.text.trim(),
        dueDate: encodeDate(dueDate),
        createdBy: _actor,
      );
    }
    title.dispose();
    description.dispose();
  }
}
