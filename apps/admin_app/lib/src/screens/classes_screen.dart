import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/school_repository.dart';
import '../widgets/empty_state.dart';

/// Classes and the subjects each one takes.
///
/// Subjects belong to the CLASS, not the student — everyone in 9-A takes the
/// same set. That is the school model, versus the university one where each
/// student picked their own courses (CLAUDE.md §11).
class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  late final SchoolRepository _repo;
  String? _selectedId;

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
      builder: (context, snapshot) {
        final classes = snapshot.data ?? const [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  Text('Classes', style: theme.textTheme.headlineSmall),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: _addClass,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add class'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: classes.isEmpty
                  ? const EmptyState(
                      icon: Icons.meeting_room_outlined,
                      title: 'No classes',
                      detail: 'Add one, or seed the demo data from the Dashboard.',
                    )
                  : Row(
                      children: [
                        SizedBox(width: 280, child: _classList(classes)),
                        const VerticalDivider(width: 1),
                        Expanded(child: _subjectPanel(classes)),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _classList(List<SchoolClass> classes) {
    final selected = _selectedId ??= classes.first.id;

    return StreamBuilder<Map<String, int>>(
      stream: _repo.watchClassSizes(),
      builder: (context, snapshot) {
        final sizes = snapshot.data ?? const <String, int>{};
        return ListView.separated(
          itemCount: classes.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final c = classes[i];
            return ListTile(
              selected: c.id == selected,
              title: Text('Class ${c.displayName}'),
              subtitle: Text([
                '${sizes[c.id] ?? 0} students',
                ?c.room,
              ].join(' · ')),
              onTap: () => setState(() => _selectedId = c.id),
            );
          },
        );
      },
    );
  }

  Widget _subjectPanel(List<SchoolClass> classes) {
    final schoolClass = classes.firstWhere(
      (c) => c.id == _selectedId,
      orElse: () => classes.first,
    );

    return StreamBuilder<List<Subject>>(
      stream: _repo.watchSubjects(schoolClass.id),
      builder: (context, snapshot) {
        final subjects = snapshot.data ?? const [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text('Subjects · Class ${schoolClass.displayName}',
                      style: Theme.of(context).textTheme.titleMedium),
                  const Spacer(),
                  OutlinedButton.icon(
                    onPressed: () => _addSubject(schoolClass, subjects.length),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add subject'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: subjects.isEmpty
                  ? const EmptyState(
                      icon: Icons.menu_book_outlined,
                      title: 'No subjects',
                      detail: 'Marks cannot be entered until this class has '
                          'subjects.',
                    )
                  : ListView.separated(
                      itemCount: subjects.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        final s = subjects[i];
                        return ListTile(
                          leading: const Icon(Icons.menu_book_outlined),
                          title: Text(s.name),
                          subtitle: Text([
                            ?s.code,
                            'out of ${s.totalMarks}',
                          ].join(' · ')),
                          trailing: IconButton(
                            tooltip: 'Remove',
                            icon: const Icon(Icons.delete_outline, size: 18),
                            onPressed: () => _repo.deleteSubject(s.id),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addClass() async {
    final school = await _repo.school();
    final year = await _repo.currentYear();
    if (school == null || year == null || !mounted) return;

    final grade = TextEditingController(text: '9');
    final section = TextEditingController(text: 'A');
    final room = TextEditingController();

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add class'),
        content: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: grade,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Grade (1–12)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: section,
                      decoration: const InputDecoration(
                        labelText: 'Section',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: room,
                decoration: const InputDecoration(
                  labelText: 'Room (optional)',
                  border: OutlineInputBorder(),
                ),
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
              child: const Text('Add')),
        ],
      ),
    );

    if (saved ?? false) {
      await _repo.saveClass(
        schoolId: school.id,
        academicYearId: year.id,
        grade: int.tryParse(grade.text.trim()) ?? 1,
        section: section.text.trim().toUpperCase(),
        room: room.text.trim().isEmpty ? null : room.text.trim(),
      );
    }
    for (final c in [grade, section, room]) {
      c.dispose();
    }
  }

  Future<void> _addSubject(SchoolClass schoolClass, int existingCount) async {
    final name = TextEditingController();
    final code = TextEditingController();
    final total = TextEditingController(text: '100');

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add subject to ${schoolClass.displayName}'),
        content: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Subject name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: code,
                      decoration: const InputDecoration(
                        labelText: 'Code',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: total,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Total marks',
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
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Add')),
        ],
      ),
    );

    if ((saved ?? false) && name.text.trim().isNotEmpty) {
      await _repo.saveSubject(
        schoolId: schoolClass.schoolId,
        classId: schoolClass.id,
        name: name.text.trim(),
        code: code.text.trim().isEmpty ? null : code.text.trim(),
        totalMarks: int.tryParse(total.text.trim()) ?? 100,
        sortOrder: existingCount,
      );
    }
    for (final c in [name, code, total]) {
      c.dispose();
    }
  }
}
