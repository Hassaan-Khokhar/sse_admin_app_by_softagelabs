import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';
import 'package:uuid/uuid.dart';
import '../data/app_scope.dart';
import '../data/faculty_repository.dart';
import '../data/school_repository.dart';
import '../widgets/empty_state.dart';
import '../widgets/page_shell.dart';

class FacultyManagementScreen extends StatefulWidget {
  const FacultyManagementScreen({super.key});

  @override
  State<FacultyManagementScreen> createState() => _FacultyManagementScreenState();
}

class _FacultyManagementScreenState extends State<FacultyManagementScreen> {
  late final FacultyRepository _facultyRepo;
  late final SchoolRepository _schoolRepo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final db = AppScope.databaseOf(context);
    _facultyRepo = FacultyRepository(db);
    _schoolRepo = SchoolRepository(db);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PageShell(
      title: 'Faculty',
      subtitle: 'Manage faculty profiles and class assignments.',
      actions: [
        FilledButton.icon(
          onPressed: () => _openForm(null, []), // We'll pass classes inside
          icon: const Icon(Icons.person_add_alt_1_rounded, size: 17),
          label: const Text('Add faculty'),
        ),
      ],
      child: StreamBuilder<List<Teacher>>(
        stream: _facultyRepo.watchTeachers(),
        builder: (context, snapshot) {
          final teachers = snapshot.data ?? const [];
          if (teachers.isEmpty) {
            return const EmptyState(
              icon: Icons.badge_outlined,
              title: 'No faculty',
              detail: 'Add a teacher or seed demo data.',
            );
          }

          return StreamBuilder<List<SchoolClass>>(
            stream: _schoolRepo.watchClasses(),
            builder: (context, classSnapshot) {
              final classes = classSnapshot.data ?? const [];
              
              return StreamBuilder<Map<String, AttendanceSummary>>(
                stream: _facultyRepo.watchSummaries(),
                builder: (context, summarySnap) {
                  final summaries = summarySnap.data ?? const {};

                  return Column(
                    children: [
                      ListSummaryBar(children: [
                        Text('${teachers.length} teachers',
                            style: theme.textTheme.titleSmall),
                      ]),
                      Expanded(
                        child: ListView.separated(
                          itemCount: teachers.length,
                          separatorBuilder: (_, _) => const Divider(height: 1),
                          itemBuilder: (context, i) {
                            final teacher = teachers[i];
                            final summary = summaries[teacher.id];
                            final assignedClasses = classes
                                .where((c) => c.classTeacherId == teacher.id)
                                .map((c) => c.displayName)
                                .join(', ');

                            return ListTile(
                              title: Text(teacher.fullName),
                              subtitle: Text([
                                if (teacher.employeeNo != null && teacher.employeeNo!.isNotEmpty) 
                                  'Emp ${teacher.employeeNo}',
                                if (assignedClasses.isNotEmpty) 'Incharge: $assignedClasses'
                                else 'No class assigned',
                              ].join(' · ')),
                              trailing: summary != null 
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('${summary.percentage?.toStringAsFixed(0) ?? '-'}% present',
                                            style: theme.textTheme.bodySmall),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: (summary.percentage ?? 0) >= 90 
                                                ? Colors.green.shade50 
                                                : Colors.orange.shade50,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            (summary.percentage ?? 0) >= 90 ? 'Good' : 'Review',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: (summary.percentage ?? 0) >= 90 
                                                  ? Colors.green.shade700 
                                                  : Colors.orange.shade700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : null,
                              onTap: () => _openForm(teacher, classes),
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
      ),
    );
  }

  Future<void> _openForm(Teacher? teacher, List<SchoolClass> currentClasses) async {
    final school = await _schoolRepo.school();
    if (school == null || !mounted) return;

    // Use current classes if provided, else load them (e.g. for the Add button)
    List<SchoolClass> classes = currentClasses;
    if (classes.isEmpty) {
       classes = await _schoolRepo.watchClasses().first;
    }

    // Find if the teacher is already an incharge of a class
    SchoolClass? currentInchargeClass;
    if (teacher != null) {
      currentInchargeClass = classes.where((c) => c.classTeacherId == teacher.id).firstOrNull;
    }

    if (!mounted) return;

    final result = await showDialog<({
      String fullName,
      String? employeeNo,
      String? phone,
      String? qualification,
      SchoolClass? inchargeOf,
    })>(
      context: context,
      builder: (context) => _FacultyForm(
        teacher: teacher,
        classes: classes,
        currentInchargeClass: currentInchargeClass,
      ),
    );

    if (result != null && result.fullName.trim().isNotEmpty) {
      final teacherId = teacher?.id ?? const Uuid().v7();
      
      await _facultyRepo.saveTeacher(
        id: teacherId,
        schoolId: school.id,
        fullName: result.fullName.trim(),
        employeeNo: result.employeeNo?.trim().isEmpty ?? true ? null : result.employeeNo!.trim(),
        phone: result.phone?.trim().isEmpty ?? true ? null : result.phone!.trim(),
        qualification: result.qualification?.trim().isEmpty ?? true ? null : result.qualification!.trim(),
      );

      // If they changed the class they are in charge of, update the class
      if (result.inchargeOf?.id != currentInchargeClass?.id) {
        // Clear previous class if any
        if (currentInchargeClass != null) {
          await _schoolRepo.saveClass(
            schoolId: school.id,
            academicYearId: currentInchargeClass.academicYearId,
            id: currentInchargeClass.id,
            grade: currentInchargeClass.grade,
            section: currentInchargeClass.section,
            room: currentInchargeClass.room,
            classTeacherId: null,
          );
        }
        // Set new class if selected
        if (result.inchargeOf != null) {
          await _schoolRepo.saveClass(
            schoolId: school.id,
            academicYearId: result.inchargeOf!.academicYearId,
            id: result.inchargeOf!.id,
            grade: result.inchargeOf!.grade,
            section: result.inchargeOf!.section,
            room: result.inchargeOf!.room,
            classTeacherId: teacherId,
          );
        }
      }
    }
  }
}

class _FacultyForm extends StatefulWidget {
  const _FacultyForm({this.teacher, required this.classes, this.currentInchargeClass});

  final Teacher? teacher;
  final List<SchoolClass> classes;
  final SchoolClass? currentInchargeClass;

  @override
  State<_FacultyForm> createState() => _FacultyFormState();
}

class _FacultyFormState extends State<_FacultyForm> {
  late final _fullName = TextEditingController(text: widget.teacher?.fullName);
  late final _employeeNo = TextEditingController(text: widget.teacher?.employeeNo);
  late final _phone = TextEditingController(text: widget.teacher?.phone);
  late final _qualification = TextEditingController(text: widget.teacher?.qualification);
  
  late SchoolClass? _selectedClass = widget.currentInchargeClass;

  @override
  void dispose() {
    _fullName.dispose();
    _employeeNo.dispose();
    _phone.dispose();
    _qualification.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.teacher == null ? 'Add faculty' : 'Edit faculty'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _fullName,
              autofocus: widget.teacher == null,
              decoration: const InputDecoration(
                labelText: 'Full name *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _employeeNo,
              decoration: const InputDecoration(
                labelText: 'Employee No',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _qualification,
              decoration: const InputDecoration(
                labelText: 'Qualification',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<SchoolClass?>(
              value: _selectedClass,
              decoration: const InputDecoration(
                labelText: 'Class incharge (optional)',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text('— Not a class incharge —')),
                for (final c in widget.classes)
                  DropdownMenuItem(value: c, child: Text('Class ${c.displayName}')),
              ],
              onChanged: (v) => setState(() => _selectedClass = v),
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
            if (_fullName.text.trim().isEmpty) return;
            Navigator.pop(context, (
              fullName: _fullName.text,
              employeeNo: _employeeNo.text,
              phone: _phone.text,
              qualification: _qualification.text,
              inchargeOf: _selectedClass,
            ));
          },
          child: Text(widget.teacher == null ? 'Add' : 'Save'),
        ),
      ],
    );
  }
}
