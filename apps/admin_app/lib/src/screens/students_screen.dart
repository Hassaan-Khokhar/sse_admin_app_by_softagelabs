import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/student_repository.dart';
import '../widgets/empty_state.dart';
import '../widgets/student_form.dart';

/// The roll — enrol, edit, withdraw.
class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  late final StudentRepository _repo;
  final _search = TextEditingController();
  String? _classId;
  bool _includeInactive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = StudentRepository(AppScope.databaseOf(context));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
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
                  Text('Students', style: theme.textTheme.headlineSmall),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: 240,
                    child: TextField(
                      controller: _search,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(Icons.search, size: 18),
                        hintText: 'Name or admission no',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<String?>(
                    value: _classId,
                    hint: const Text('All classes'),
                    onChanged: (id) => setState(() => _classId = id),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('All classes')),
                      for (final c in classes)
                        DropdownMenuItem(value: c.id, child: Text(c.displayName)),
                    ],
                  ),
                  const SizedBox(width: 12),
                  // Withdrawn students are never deleted, so they have to stay
                  // findable — a leaving certificate gets requested months on.
                  FilterChip(
                    label: const Text('Include withdrawn'),
                    selected: _includeInactive,
                    onSelected: (v) => setState(() => _includeInactive = v),
                  ),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: classes.isEmpty ? null : () => _openForm(classes),
                    icon: const Icon(Icons.person_add_alt, size: 18),
                    label: const Text('Enrol student'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: StreamBuilder<List<Student>>(
                stream: _repo.watchStudents(
                  classId: _classId,
                  search: _search.text,
                  includeInactive: _includeInactive,
                ),
                builder: (context, snapshot) {
                  final students = snapshot.data ?? const [];
                  if (students.isEmpty) {
                    return const EmptyState(
                      icon: Icons.people_outline,
                      title: 'No students',
                      detail: 'Enrol one, or seed the demo data from the Dashboard.',
                    );
                  }
                  return ListView.separated(
                    itemCount: students.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) => _StudentTile(
                      student: students[i],
                      classes: classes,
                      onEdit: () => _openForm(classes, student: students[i]),
                      onWithdraw: () => _confirmWithdraw(students[i]),
                      onReadmit: () => _repo.readmit(students[i]),
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

  Future<void> _openForm(List<SchoolClass> classes, {Student? student}) async {
    final schoolId = classes.first.schoolId;
    final suggested =
        student?.admissionNo ?? await _repo.nextAdmissionNo(schoolId);
    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (_) => StudentFormDialog(
        classes: classes,
        student: student,
        suggestedAdmissionNo: suggested,
        onSave: (data) => _repo.save(
          schoolId: schoolId,
          id: student?.id,
          fullName: data.fullName,
          fatherName: data.fatherName,
          admissionNo: data.admissionNo,
          rollNo: data.rollNo,
          classId: data.classId,
          gender: data.gender,
          guardianPhone: data.guardianPhone,
          dateOfBirth: data.dateOfBirth,
          address: data.address,
        ),
      ),
    );
  }

  Future<void> _confirmWithdraw(Student student) async {
    final reasonController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Withdraw ${student.fullName}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Their record is kept in full — attendance, marks and fee '
              'history all survive. They are removed from class registers and '
              'their app account is deactivated.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Reason',
                hintText: 'Transferred to another school',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      await _repo.withdraw(
        student: student,
        reason: reasonController.text.trim().isEmpty
            ? 'Not stated'
            : reasonController.text.trim(),
      );
    }
    reasonController.dispose();
  }
}

class _StudentTile extends StatelessWidget {
  const _StudentTile({
    required this.student,
    required this.classes,
    required this.onEdit,
    required this.onWithdraw,
    required this.onReadmit,
  });

  final Student student;
  final List<SchoolClass> classes;
  final VoidCallback onEdit;
  final VoidCallback onWithdraw;
  final VoidCallback onReadmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = StudentStatus.tryFromWire(student.status);
    final isActive = status?.isEnrolled ?? false;
    final className = classes
        .where((c) => c.id == student.classId)
        .map((c) => c.displayName)
        .firstOrNull;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isActive
            ? theme.colorScheme.primaryContainer
            : theme.disabledColor.withValues(alpha: 0.2),
        child: Text('${student.rollNo ?? '—'}', style: const TextStyle(fontSize: 13)),
      ),
      title: Row(
        children: [
          Text(student.fullName),
          if (!isActive) ...[
            const SizedBox(width: 8),
            Chip(
              label: Text(status?.wire ?? 'unknown',
                  style: const TextStyle(fontSize: 11)),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
            ),
          ],
        ],
      ),
      subtitle: Text([
        student.admissionNo,
        if (className != null) 'Class $className',
        if (student.fatherName case final f?) 'S/D of $f',
      ].join(' · ')),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            tooltip: 'Edit',
            icon: const Icon(Icons.edit_outlined, size: 18),
            onPressed: onEdit,
          ),
          if (isActive)
            IconButton(
              tooltip: 'Withdraw',
              icon: const Icon(Icons.person_remove_outlined, size: 18),
              onPressed: onWithdraw,
            )
          else
            IconButton(
              tooltip: 'Re-admit',
              icon: const Icon(Icons.person_add_alt_1_outlined, size: 18),
              onPressed: onReadmit,
            ),
        ],
      ),
    );
  }
}
