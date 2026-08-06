import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/attendance_repository.dart';
import '../data/marks_repository.dart';
import '../widgets/empty_state.dart';
import '../widgets/page_shell.dart';

/// Exams and mark entry.
class MarksScreen extends StatefulWidget {
  const MarksScreen({super.key});

  @override
  State<MarksScreen> createState() => _MarksScreenState();
}

class _MarksScreenState extends State<MarksScreen> {
  late final MarksRepository _repo;
  late final AttendanceRepository _roster;
  Exam? _exam;
  String? _classId;
  Subject? _subject;
  late String _actor;

  /// Paper total for the selected exam + subject.
  ///
  /// Null until loaded. `subjects.total_marks` is only the default — a class
  /// test out of 10 is not a subject-level property, it belongs to this
  /// particular paper.
  double? _paperTotal;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final db = AppScope.databaseOf(context);
    _repo = MarksRepository(db);
    _roster = AttendanceRepository(db);
    _actor = AppScope.actorOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<Exam>>(
      stream: _repo.watchExams(),
      builder: (context, examSnapshot) {
        final exams = examSnapshot.data ?? const [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  Text('Marks', style: theme.textTheme.headlineSmall),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: _createExam,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('New exam'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            if (exams.isEmpty)
              const Expanded(
                child: EmptyState(
                  icon: Icons.school_outlined,
                  title: 'No exams yet',
                  detail: 'Create one — First Term, Mid Term or Final — then '
                      'enter marks subject by subject.',
                ),
              )
            else
              Expanded(child: _buildBody(exams)),
          ],
        );
      },
    );
  }

  Widget _buildBody(List<Exam> exams) {
    final exam = _exam ??= exams.first;

    return Column(
      children: [
        _ExamBar(
          exams: exams,
          selected: exam,
          onExamChanged: (e) => setState(() {
            _exam = e;
            _subject = null;
          }),
          onTogglePublish: () => _repo.setPublished(
            exam,
            published: !exam.isPublished,
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: StreamBuilder<List<SchoolClass>>(
            stream: _roster.watchClasses(),
            builder: (context, classSnapshot) {
              final classes = classSnapshot.data ?? const [];
              if (classes.isEmpty) {
                return const EmptyState(
                  icon: Icons.meeting_room_outlined,
                  title: 'No classes',
                  detail: 'Seed the demo data from the Dashboard.',
                );
              }
              final classId = _classId ??= classes.first.id;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: classId,
                          onChanged: (id) => setState(() {
                            _classId = id;
                            _subject = null;
                          }),
                          items: [
                            for (final c in classes)
                              DropdownMenuItem(
                                  value: c.id, child: Text('Class ${c.displayName}')),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(child: _subjectPicker(classId)),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(child: _markEntry(exam, classId)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _subjectPicker(String classId) {
    return StreamBuilder<List<Subject>>(
      stream: _repo.watchSubjects(classId),
      builder: (context, snapshot) {
        final subjects = snapshot.data ?? const [];
        if (subjects.isEmpty) return const Text('No subjects for this class');
        final current = _subject != null &&
                subjects.any((s) => s.id == _subject!.id)
            ? _subject!
            : subjects.first;
        if (_subject?.id != current.id) {
          _subject = current;
          _loadPaperTotal(current);
        } else {
          _subject = current;
        }

        return Wrap(
          spacing: 8,
          children: [
            for (final subject in subjects)
              ChoiceChip(
                label: Text(subject.name),
                selected: subject.id == current.id,
                onSelected: (_) => setState(() => _subject = subject),
              ),
          ],
        );
      },
    );
  }

  Widget _markEntry(Exam exam, String classId) {
    final subject = _subject;
    if (subject == null) {
      return const EmptyState(
        icon: Icons.menu_book_outlined,
        title: 'Pick a subject',
        detail: 'Marks are entered one subject at a time.',
      );
    }

    final total = _paperTotal ?? subject.totalMarks.toDouble();

    return StreamBuilder<List<Student>>(
      stream: _roster.watchRoster(classId),
      builder: (context, rosterSnapshot) {
        final roster = rosterSnapshot.data ?? const [];
        if (roster.isEmpty) {
          return const EmptyState(
            icon: Icons.people_outline,
            title: 'No students',
            detail: 'This class has nobody enrolled.',
          );
        }

        return StreamBuilder<Map<String, Mark>>(
          stream: _repo.watchMarks(examId: exam.id, subjectId: subject.id),
          builder: (context, marksSnapshot) {
            final marks = marksSnapshot.data ?? const <String, Mark>{};

            double totalObtained = 0;
            double totalPossible = 0;
            
            for (final mark in marks.values) {
               if (mark.isAbsent) continue;
               if (mark.obtainedMarks != null) {
                 totalObtained += mark.obtainedMarks!;
                 totalPossible += mark.totalMarks;
               }
            }
            final overallPercent = totalPossible > 0 ? (totalObtained / totalPossible * 100).toStringAsFixed(1) : '-';

            return Column(
              children: [
                ListSummaryBar(children: [
                  Text('Class Average: $overallPercent%', style: Theme.of(context).textTheme.titleSmall),
                ]),
                Expanded(
                  child: ListView.separated(
                    itemCount: roster.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) => _MarkRow(
                      student: roster[i],
                      mark: marks[roster[i].id],
                      totalMarks: total,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _loadPaperTotal(Subject subject) async {
    final exam = _exam;
    if (exam == null) return;
    final stored = await _repo.currentPaperTotal(
      examId: exam.id,
      subjectId: subject.id,
    );
    if (!mounted) return;
    setState(() => _paperTotal = stored ?? subject.totalMarks.toDouble());
  }

  Future<void> _applyPaperTotal(Exam exam, double total) async {
    final subject = _subject;
    if (subject == null || total <= 0) return;
    setState(() => _paperTotal = total);
    // Re-grades anything already entered, so a correction to the paper total
    // does not leave half the class graded against the old denominator.
    await _repo.setPaperTotal(
      examId: exam.id,
      subjectId: subject.id,
      total: total,
      enteredBy: _actor,
    );
  }

  Future<void> _createExam() async {
    final db = AppScope.databaseOf(context);
    final school = await db.select(db.schools).getSingleOrNull();
    final year = await (db.select(db.academicYears)
          ..where((y) => y.isCurrent.equals(true)))
        .getSingleOrNull();
    if (school == null || year == null || !mounted) return;

    final name = TextEditingController(text: 'First Term');
    var type = ExamType.firstTerm.wire;

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: const Text('New exam'),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: type,
                  decoration: const InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (final t in ExamType.values)
                      DropdownMenuItem(value: t.wire, child: Text(t.wire)),
                  ],
                  onChanged: (v) => setLocal(() => type = v ?? type),
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
                child: const Text('Create')),
          ],
        ),
      ),
    );

    if (saved ?? false) {
      await _repo.saveExam(
        schoolId: school.id,
        academicYearId: year.id,
        name: name.text.trim(),
        examType: type,
        startDate: encodeDate(DateTime.now()),
      );
    }
    name.dispose();
  }
}

class _ExamBar extends StatelessWidget {
  const _ExamBar({
    required this.exams,
    required this.selected,
    required this.onExamChanged,
    required this.onTogglePublish,
  });

  final List<Exam> exams;
  final Exam selected;
  final ValueChanged<Exam> onExamChanged;
  final VoidCallback onTogglePublish;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          DropdownButton<String>(
            value: selected.id,
            onChanged: (id) => onExamChanged(exams.firstWhere((e) => e.id == id)),
            items: [
              for (final e in exams)
                DropdownMenuItem(value: e.id, child: Text(e.name)),
            ],
          ),
          const SizedBox(width: 16),
          // The gate. Until this is on, students see nothing — enforced by RLS,
          // not just here.
          Chip(
            avatar: Icon(
              selected.isPublished ? Icons.visibility : Icons.visibility_off,
              size: 16,
            ),
            label: Text(selected.isPublished ? 'Published' : 'Hidden from students'),
            backgroundColor: selected.isPublished
                ? Colors.green.withValues(alpha: 0.15)
                : theme.disabledColor.withValues(alpha: 0.12),
          ),
          const Spacer(),
          FilledButton.tonalIcon(
            onPressed: onTogglePublish,
            icon: Icon(
              selected.isPublished ? Icons.lock_outline : Icons.publish_outlined,
              size: 18,
            ),
            label: Text(selected.isPublished ? 'Unpublish' : 'Publish results'),
          ),
        ],
      ),
    );
  }
}

class _MarkRow extends StatelessWidget {
  const _MarkRow({
    required this.student,
    required this.mark,
    required this.totalMarks,
    super.key,
  });

  final Student student;
  final Mark? mark;
  final double totalMarks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAbsent = mark?.isAbsent ?? false;
    final grade = mark?.grade;
    final obtained = mark?.obtainedMarks;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text('${student.rollNo ?? '—'}',
                style: TextStyle(color: theme.disabledColor)),
          ),
          Expanded(child: Text(student.fullName)),
          SizedBox(
            width: 100,
            child: Text(
              isAbsent
                  ? 'Absent'
                  : obtained != null
                      ? '${obtained.toStringAsFixed(0)} / ${totalMarks.toStringAsFixed(0)}'
                      : '— / ${totalMarks.toStringAsFixed(0)}',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: isAbsent ? theme.colorScheme.error : null,
                fontStyle: isAbsent || obtained == null ? FontStyle.italic : null,
              ),
            ),
          ),
          const SizedBox(width: 24),
          SizedBox(
            width: 44,
            child: Text(
              grade ?? '—',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: grade == failingGrade ? theme.colorScheme.error : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
