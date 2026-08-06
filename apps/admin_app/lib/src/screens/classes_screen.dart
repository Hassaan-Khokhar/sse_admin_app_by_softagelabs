import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/school_repository.dart';
import '../data/student_repository.dart';
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
  late final StudentRepository _studentRepo;
  String? _selectedId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final db = AppScope.databaseOf(context);
    _repo = SchoolRepository(db);
    _studentRepo = StudentRepository(db);
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
                    onPressed: () => _showPromoteDialog(schoolClass, classes),
                    icon: const Icon(Icons.arrow_upward, size: 16),
                    label: const Text('Promote'),
                  ),
                  const SizedBox(width: 8),
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
                  : StreamBuilder<List<Teacher>>(
                      stream: _repo.watchTeachers(),
                      builder: (context, teacherSnap) {
                        final teachers = teacherSnap.data ?? const [];
                        final teacherMap = {
                          for (final t in teachers) t.id: t,
                        };
                        return ListView.separated(
                          itemCount: subjects.length,
                          separatorBuilder: (_, _) => const Divider(height: 1),
                          itemBuilder: (context, i) {
                            final s = subjects[i];
                            final teacher = s.teacherId != null
                                ? teacherMap[s.teacherId]
                                : null;
                            return ListTile(
                              leading: const Icon(Icons.menu_book_outlined),
                              title: Text(s.name),
                              subtitle: teacher != null
                                  ? Text(teacher.fullName,
                                      style: const TextStyle(fontSize: 12))
                                  : const Text('No teacher assigned',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontStyle: FontStyle.italic)),
                              trailing: IconButton(
                                tooltip: 'Remove',
                                icon: const Icon(Icons.delete_outline, size: 18),
                                onPressed: () => _repo.deleteSubject(s.id),
                              ),
                              onTap: () => _editSubject(schoolClass, s),
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

  Future<void> _addClass() async {
    final school = await _repo.school();
    final year = await _repo.currentYear();
    final teachers = await _repo.watchTeachers().first;
    if (school == null || year == null || !mounted) return;

    final result = await showDialog<({int grade, String section, String? room, String? classTeacherId})>(
      context: context,
      builder: (context) => _AddClassDialog(teachers: teachers),
    );

    if (result != null) {
      await _repo.saveClass(
        schoolId: school.id,
        academicYearId: year.id,
        grade: result.grade,
        section: result.section,
        room: result.room,
        classTeacherId: result.classTeacherId,
      );
    }
  }

  Future<void> _addSubject(SchoolClass schoolClass, int existingCount) async {
    // Fetch teachers once for the dialog.
    final teachers = await _repo.watchTeachers().first;

    if (!mounted) return;

    final result = await showDialog<({String name, String? teacherId})>(
      context: context,
      builder: (context) => _AddSubjectDialog(
        className: schoolClass.displayName,
        teachers: teachers,
      ),
    );

    if (result != null && result.name.trim().isNotEmpty) {
      await _repo.saveSubject(
        schoolId: schoolClass.schoolId,
        classId: schoolClass.id,
        name: result.name.trim(),
        teacherId: result.teacherId,
        sortOrder: existingCount,
      );
    }
  }

  Future<void> _editSubject(SchoolClass schoolClass, Subject subject) async {
    final teachers = await _repo.watchTeachers().first;
    if (!mounted) return;

    final result = await showDialog<({String name, String? teacherId})>(
      context: context,
      builder: (context) => _AddSubjectDialog(
        className: schoolClass.displayName,
        teachers: teachers,
        subject: subject,
      ),
    );

    if (result != null && result.name.trim().isNotEmpty) {
      await _repo.saveSubject(
        id: subject.id,
        schoolId: schoolClass.schoolId,
        classId: schoolClass.id,
        name: result.name.trim(),
        teacherId: result.teacherId,
        sortOrder: subject.sortOrder,
      );
    }
  }

  Future<void> _showPromoteDialog(
      SchoolClass fromClass, List<SchoolClass> allClasses) async {
    // Only classes that are logically valid for promotion (same or higher grade).
    final validClasses = allClasses
        .where((c) => c.id != fromClass.id && c.grade >= fromClass.grade)
        .toList();
        
    final isHighestGrade = !allClasses.any((c) => c.grade > fromClass.grade);

    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (context) => _PromoteDialog(
        fromClass: fromClass,
        targetClasses: validClasses,
        isHighestGrade: isHighestGrade,
        studentRepo: _studentRepo,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Add Subject dialog
// ─────────────────────────────────────────────────────────────────────────────

class _AddSubjectDialog extends StatefulWidget {
  const _AddSubjectDialog({
    required this.className,
    required this.teachers,
    this.subject,
  });

  final String className;
  final List<Teacher> teachers;
  final Subject? subject;

  @override
  State<_AddSubjectDialog> createState() => _AddSubjectDialogState();
}

class _AddSubjectDialogState extends State<_AddSubjectDialog> {
  late final _nameController = TextEditingController(text: widget.subject?.name);
  late String? _selectedTeacherId = widget.subject?.teacherId;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.subject == null 
          ? 'Add subject to ${widget.className}'
          : 'Edit subject'),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Subject name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String?>(
              value: _selectedTeacherId,
              decoration: const InputDecoration(
                labelText: 'Assign teacher (optional)',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('No teacher'),
                ),
                ...widget.teachers.map(
                  (t) => DropdownMenuItem(
                    value: t.id,
                    child: Text(t.fullName),
                  ),
                ),
              ],
              onChanged: (val) => setState(() => _selectedTeacherId = val),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(
              context,
              (name: _nameController.text, teacherId: _selectedTeacherId),
            );
          },
          child: Text(widget.subject == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Promote dialog
// ─────────────────────────────────────────────────────────────────────────────

class _PromoteDialog extends StatefulWidget {
  const _PromoteDialog({
    required this.fromClass,
    required this.targetClasses,
    required this.isHighestGrade,
    required this.studentRepo,
  });

  final SchoolClass fromClass;
  final List<SchoolClass> targetClasses;
  final bool isHighestGrade;
  final StudentRepository studentRepo;

  @override
  State<_PromoteDialog> createState() => _PromoteDialogState();
}

class _PromoteDialogState extends State<_PromoteDialog> {
  late String _targetClassId;
  final Set<String> _selected = {};
  bool _promoting = false;

  @override
  void initState() {
    super.initState();
    // Default to the first valid target class, or 'graduate' if highest grade, or 'withdraw'.
    _targetClassId = widget.targetClasses.isNotEmpty 
        ? widget.targetClasses.first.id 
        : (widget.isHighestGrade ? 'graduate' : 'withdraw');
  }

  Future<void> _promote(List<Student> students) async {
    final toPromote =
        students.where((s) => _selected.contains(s.id)).toList();
    if (toPromote.isEmpty) return;

    setState(() => _promoting = true);
    try {
      if (_targetClassId == 'graduate') {
        await widget.studentRepo.graduateStudents(students: toPromote);
      } else if (_targetClassId == 'withdraw') {
        for (final student in toPromote) {
          await widget.studentRepo.withdraw(
              student: student, reason: 'Withdrawn via Promote dialog');
        }
      } else {
        await widget.studentRepo.promoteStudents(
          students: toPromote,
          targetClassId: _targetClassId,
        );
      }
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _promoting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isGraduating = _targetClassId == 'graduate';
    final isWithdrawing = _targetClassId == 'withdraw';
    final isAction = isGraduating || isWithdrawing;
    final targetClass = isAction
        ? null
        : widget.targetClasses.firstWhere((c) => c.id == _targetClassId);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 680),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 0),
              child: Row(
                children: [
                  const Icon(Icons.arrow_upward),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Promote from Class ${widget.fromClass.displayName}',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Text(
                'Select students to promote, then choose their new class.',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.outline),
              ),
            ),
            const Divider(height: 1),

            // ── Target class dropdown ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: DropdownButtonFormField<String>(
                value: _targetClassId,
                decoration: const InputDecoration(
                  labelText: 'Promote to class',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school_outlined),
                ),
                items: [
                  ...widget.targetClasses.map((c) => DropdownMenuItem(
                        value: c.id,
                        child: Text('Class ${c.displayName}'),
                      )),
                  if (widget.isHighestGrade)
                    const DropdownMenuItem(
                      value: 'graduate',
                      child: Text('Graduate or Alumni'),
                    ),
                  const DropdownMenuItem(
                    value: 'withdraw',
                    child: Text('Withdraw or Expel'),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _targetClassId = val);
                },
              ),
            ),
            const Divider(height: 1),

            // ── Student checklist ─────────────────────────────────────────
            Expanded(
              child: StreamBuilder<List<Student>>(
                stream: widget.studentRepo
                    .watchStudents(classId: widget.fromClass.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final students = snapshot.data ?? const [];

                  if (students.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text('No active students in this class.'),
                      ),
                    );
                  }

                  // Select-all row.
                  final allSelected = _selected.length == students.length;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Select all toggle.
                      CheckboxListTile(
                        value: allSelected,
                        tristate: false,
                        title: Text(
                          allSelected
                              ? 'Deselect all'
                              : 'Select all (${students.length})',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        onChanged: (_) {
                          setState(() {
                            if (allSelected) {
                              _selected.clear();
                            } else {
                              _selected
                                  .addAll(students.map((s) => s.id));
                            }
                          });
                        },
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: ListView.separated(
                          itemCount: students.length,
                          separatorBuilder: (_, _) =>
                              const Divider(height: 1),
                          itemBuilder: (context, i) {
                            final s = students[i];
                            return CheckboxListTile(
                              value: _selected.contains(s.id),
                              title: Text(s.fullName),
                              subtitle: Text(
                                [
                                  if (s.rollNo != null)
                                    'Roll ${s.rollNo}',
                                  s.admissionNo,
                                ].join(' · '),
                                style: const TextStyle(fontSize: 12),
                              ),
                              onChanged: (checked) {
                                setState(() {
                                  if (checked ?? false) {
                                    _selected.add(s.id);
                                  } else {
                                    _selected.remove(s.id);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // ── Footer ───────────────────────────────────────────────────
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder<List<Student>>(
                stream: widget.studentRepo
                    .watchStudents(classId: widget.fromClass.id),
                builder: (context, snapshot) {
                  final students = snapshot.data ?? const [];
                  return Row(
                    children: [
                      Text(
                        '${_selected.length} of ${students.length} selected',
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: theme.colorScheme.outline),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed:
                            _promoting ? null : () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      FilledButton.icon(
                        onPressed: (_selected.isEmpty || _promoting)
                            ? null
                            : () => _promote(students),
                        icon: _promoting
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2),
                              )
                            : Icon(
                                isGraduating
                                    ? Icons.school
                                    : isWithdrawing
                                        ? Icons.person_off
                                        : Icons.arrow_upward,
                                size: 16),
                        label: Text(
                          _promoting
                              ? (isGraduating
                                  ? 'Graduating…'
                                  : isWithdrawing
                                      ? 'Withdrawing…'
                                      : 'Promoting…')
                              : (isGraduating
                                  ? 'Graduate selected'
                                  : isWithdrawing
                                      ? 'Withdraw selected'
                                      : 'Promote to ${targetClass!.displayName}'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddClassDialog extends StatefulWidget {
  const _AddClassDialog({required this.teachers});

  final List<Teacher> teachers;

  @override
  State<_AddClassDialog> createState() => _AddClassDialogState();
}

class _AddClassDialogState extends State<_AddClassDialog> {
  final _grade = TextEditingController(text: '9');
  final _section = TextEditingController(text: 'A');
  final _room = TextEditingController();
  String? _classTeacherId;

  @override
  void dispose() {
    _grade.dispose();
    _section.dispose();
    _room.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                    controller: _grade,
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
                    controller: _section,
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
              controller: _room,
              decoration: const InputDecoration(
                labelText: 'Room (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _classTeacherId,
              decoration: const InputDecoration(
                labelText: 'Class incharge (optional)',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('No teacher')),
                for (final t in widget.teachers)
                  DropdownMenuItem(value: t.id, child: Text(t.fullName)),
              ],
              onChanged: (v) => setState(() => _classTeacherId = v),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        FilledButton(
            onPressed: () => Navigator.pop(
                context,
                (
                  grade: int.tryParse(_grade.text.trim()) ?? 1,
                  section: _section.text.trim().toUpperCase(),
                  room: _room.text.trim().isEmpty ? null : _room.text.trim(),
                  classTeacherId: _classTeacherId,
                ),
            ),
            child: const Text('Add'),
        ),
      ],
    );
  }
}
