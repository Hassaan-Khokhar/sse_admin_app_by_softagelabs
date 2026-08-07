import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';
import '../data/app_scope.dart';
import '../data/marks_repository.dart';
import '../widgets/empty_state.dart';

class StudentReportDialog extends StatefulWidget {
  const StudentReportDialog({required this.student, super.key});

  final Student student;

  @override
  State<StudentReportDialog> createState() => _StudentReportDialogState();
}

class _StudentReportDialogState extends State<StudentReportDialog> {
  late final MarksRepository _repo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = MarksRepository(AppScope.databaseOf(context));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 800,
        height: 600,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.school_outlined, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Academic Report Card',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        widget.student.fullName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: StreamBuilder<List<StudentReportItem>>(
                stream: _repo.watchStudentReport(widget.student.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  final items = snapshot.data ?? [];
                  if (items.isEmpty) {
                    return const EmptyState(
                      icon: Icons.history_edu,
                      title: 'No academic history',
                      detail: 'This student has no recorded marks in any exam.',
                    );
                  }

                  // Group by exam
                  final byExam = <String, List<StudentReportItem>>{};
                  for (final item in items) {
                    byExam.putIfAbsent(item.exam.id, () => []).add(item);
                  }

                  return ListView.separated(
                    itemCount: byExam.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 32),
                    itemBuilder: (context, i) {
                      final examId = byExam.keys.elementAt(i);
                      final examItems = byExam[examId]!;
                      final exam = examItems.first.exam;

                      double totalObtained = 0;
                      double totalPossible = 0;
                      
                      for (final item in examItems) {
                         if (item.mark.isAbsent) continue;
                         if (item.mark.obtainedMarks != null) {
                           totalObtained += item.mark.obtainedMarks!;
                           totalPossible += item.mark.totalMarks;
                         }
                      }
                      
                      final overallPercent = totalPossible > 0 
                          ? (totalObtained / totalPossible * 100).toStringAsFixed(1) 
                          : '-';

                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Theme.of(context).dividerColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                              ),
                              child: Row(
                                children: [
                                  Text(exam.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  Text('Overall: $overallPercent%', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            DataTable(
                              headingRowHeight: 40,
                              dataRowMinHeight: 48,
                              dataRowMaxHeight: 48,
                              columns: const [
                                DataColumn(label: Text('Subject')),
                                DataColumn(label: Text('Marks', textAlign: TextAlign.right), numeric: true),
                                DataColumn(label: Text('Grade', textAlign: TextAlign.center)),
                              ],
                              rows: examItems.map((item) {
                                final isAbsent = item.mark.isAbsent;
                                final obtained = item.mark.obtainedMarks;
                                
                                return DataRow(cells: [
                                  DataCell(Text(item.subject.name)),
                                  DataCell(
                                    Text(
                                      isAbsent
                                          ? 'Absent'
                                          : obtained != null
                                              ? '${obtained.toStringAsFixed(0)} / ${item.mark.totalMarks.toStringAsFixed(0)}'
                                              : '— / ${item.mark.totalMarks.toStringAsFixed(0)}',
                                      style: TextStyle(
                                        color: isAbsent ? Theme.of(context).colorScheme.error : null,
                                        fontStyle: isAbsent || obtained == null ? FontStyle.italic : null,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(
                                        item.mark.grade ?? '—',
                                        style: TextStyle(
                                          color: item.mark.grade == failingGrade ? Theme.of(context).colorScheme.error : null,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]);
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    },
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
