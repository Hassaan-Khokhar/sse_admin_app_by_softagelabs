import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';
import 'package:drift/drift.dart' as drift;

import '../data/app_scope.dart';
import '../data/fee_repository.dart';
import '../widgets/empty_state.dart';

/// Fees — dashboard, student fees, custom challans, and the defaulter list.
class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  late final FeeRepository _repo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = FeeRepository(AppScope.databaseOf(context));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Fee Management', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              _ActionButtons(repo: _repo),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: Container(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recent Fee Batches', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 24),
                Expanded(
                  child: _BatchesView(repo: _repo),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.repo});

  final FeeRepository repo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilledButton.tonalIcon(
          onPressed: () => _showStudentFees(context, repo),
          icon: const Icon(Icons.people_outline),
          label: const Text('Student Fees'),
        ),
        const SizedBox(width: 12),
        FilledButton.tonalIcon(
          onPressed: () => _showDefaulters(context),
          icon: const Icon(Icons.warning_amber_rounded),
          label: const Text('Defaulters'),
        ),
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: () => _showInitiateChallan(context, repo),
          icon: const Icon(Icons.add),
          label: const Text('Initiate Challan'),
        ),
      ],
    );
  }

  void _showStudentFees(BuildContext context, FeeRepository repo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StudentFeesScreen(repo: repo),
      ),
    );
  }

  void _showDefaulters(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: SizedBox(
          width: 800,
          height: 600,
          child: _DefaultersDialog(),
        ),
      ),
    );
  }

  void _showInitiateChallan(BuildContext context, FeeRepository repo) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 500,
          child: _InitiateChallanDialog(repo: repo),
        ),
      ),
    );
  }
}

class _BatchesView extends StatelessWidget {
  const _BatchesView({required this.repo});

  final FeeRepository repo;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FeeChallan>>(
      stream: repo.watchChallans(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final challans = snapshot.data ?? [];
        if (challans.isEmpty) {
          return const EmptyState(
            icon: Icons.receipt_long_outlined,
            title: 'No fees generated yet',
            detail: 'Use "Initiate Challan" to bill students.',
          );
        }

        // Group by title, month, year
        final Map<String, List<FeeChallan>> batches = {};
        for (final c in challans) {
          final title = c.title ?? '${_monthName(c.month)} ${c.year} Tuition';
          batches.putIfAbsent(title, () => []).add(c);
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: 1.5,
          ),
          itemCount: batches.keys.length,
          itemBuilder: (context, index) {
            final title = batches.keys.elementAt(index);
            final batchChallans = batches[title]!;
            final totalAmount = batchChallans.fold<double>(0, (sum, c) => sum + c.totalAmount);
            final paidAmount = batchChallans.fold<double>(0, (sum, c) => sum + c.paidAmount);
            final progress = totalAmount > 0 ? paidAmount / totalAmount : 0.0;
            
            // Determine audience
            final classIds = batchChallans.map((c) => c.classId).toSet();
            final audience = classIds.length > 1 ? 'Multiple Classes' : 'Class ${classIds.firstOrNull ?? 'Unknown'}';

            return Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
              ),
              child: InkWell(
                onTap: () => _showBatchDetails(context, title, repo),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              audience,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${batchChallans.length} Challans',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(
                        '$currencySymbol ${totalAmount.toStringAsFixed(0)} Total',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: progress,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(progress * 100).toStringAsFixed(1)}% Collected',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showBatchDetails(BuildContext context, String title, FeeRepository repo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BatchDetailsScreen(title: title, repo: repo),
      ),
    );
  }

  static String _monthName(int m) => const [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December',
      ][m - 1];
}

class _InitiateChallanDialog extends StatefulWidget {
  const _InitiateChallanDialog({required this.repo});

  final FeeRepository repo;

  @override
  State<_InitiateChallanDialog> createState() => _InitiateChallanDialogState();
}

class _InitiateChallanDialogState extends State<_InitiateChallanDialog> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _studentIdCtrl = TextEditingController();
  String _audience = 'school'; // 'school', 'class', 'student'
  String? _classId;
  List<SchoolClass> _classes = [];
  bool _busy = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    final db = AppScope.databaseOf(context);
    final classes = await (db.select(db.classes)..where((c) => c.deletedAt.isNull())).get();
    if (mounted) setState(() => _classes = classes);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Initiate Challan', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 24),
          TextField(
            controller: _titleCtrl,
            decoration: const InputDecoration(labelText: 'Title / Reason', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountCtrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Amount', prefixText: '$currencySymbol ', border: const OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _audience,
            decoration: const InputDecoration(labelText: 'Audience', border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 'school', child: Text('Whole School')),
              DropdownMenuItem(value: 'class', child: Text('Specific Class')),
              DropdownMenuItem(value: 'student', child: Text('Specific Student')),
            ],
            onChanged: (v) => setState(() => _audience = v!),
          ),
          if (_audience == 'class') ...[
            const SizedBox(height: 16),
            DropdownButtonFormField<String?>(
              initialValue: _classId,
              decoration: const InputDecoration(labelText: 'Select Class', border: OutlineInputBorder()),
              items: [
                for (final c in _classes)
                  DropdownMenuItem(value: c.id, child: Text('Class ${c.displayName}')),
              ],
              onChanged: (v) => setState(() => _classId = v),
            ),
          ],
          if (_audience == 'student') ...[
            const SizedBox(height: 16),
            TextField(
              controller: _studentIdCtrl,
              decoration: const InputDecoration(labelText: 'Student Reg ID (e.g. 2026-0341)', border: OutlineInputBorder()),
            ),
          ],
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _busy ? null : _submit,
                child: _busy ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Generate'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final title = _titleCtrl.text.trim();
    final amount = double.tryParse(_amountCtrl.text.trim()) ?? 0;
    if (title.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter valid title and amount')));
      return;
    }

    setState(() => _busy = true);
    try {
      final db = AppScope.databaseOf(context);
      String? targetStudentId;
      
      if (_audience == 'student') {
        final regId = _studentIdCtrl.text.trim();
        final student = await (db.select(db.students)..where((s) => s.admissionNo.equals(regId))).getSingleOrNull();
        if (student == null) {
          throw Exception('Student with Reg ID $regId not found.');
        }
        targetStudentId = student.id;
      }

      final count = await widget.repo.initiateCustomChallan(
        title: title,
        amount: amount,
        dueDate: DateTime.now().add(const Duration(days: 10)),
        targetClassId: _audience == 'class' ? _classId : null,
        targetStudentId: targetStudentId,
      );
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Generated $count challan(s) successfully.')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

class BatchDetailsScreen extends StatefulWidget {
  const BatchDetailsScreen({super.key, required this.title, required this.repo});

  final String title;
  final FeeRepository repo;

  @override
  State<BatchDetailsScreen> createState() => _BatchDetailsScreenState();
}

class _BatchDetailsScreenState extends State<BatchDetailsScreen> {
  String? _classId;
  String _searchQuery = '';
  List<SchoolClass> _classes = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    final db = AppScope.databaseOf(context);
    final classes = await (db.select(db.classes)..where((c) => c.deletedAt.isNull())).get();
    if (mounted) setState(() => _classes = classes);
  }

  @override
  Widget build(BuildContext context) {
    final db = AppScope.databaseOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: DropdownButtonFormField<String?>(
                    initialValue: _classId,
                    decoration: const InputDecoration(labelText: 'Filter by Class', border: OutlineInputBorder(), isDense: true),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('All Classes')),
                      for (final c in _classes)
                        DropdownMenuItem(value: c.id, child: Text('Class ${c.displayName}')),
                    ],
                    onChanged: (v) => setState(() => _classId = v),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search Reg ID or Name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: StreamBuilder<List<FeeChallan>>(
              stream: widget.repo.watchChallans(),
              builder: (context, challanSnap) {
                if (!challanSnap.hasData) return const Center(child: CircularProgressIndicator());
                
                final batchChallans = challanSnap.data!.where((c) {
                  final m = c.month;
                  final mName = const ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'][m - 1];
                  final t = c.title ?? '$mName ${c.year} Tuition';
                  return t == widget.title;
                }).toList();

                return FutureBuilder<List<Student>>(
                  future: db.select(db.students).get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                    
                    final studentMap = {for (final s in snapshot.data!) s.id: s};
                    
                    var filteredChallans = batchChallans.where((c) {
                  final s = studentMap[c.studentId];
                  if (s == null) return false;
                  
                  if (_classId != null && s.classId != _classId) return false;
                  if (_searchQuery.isNotEmpty) {
                    if (!s.admissionNo.toLowerCase().contains(_searchQuery) &&
                        !s.fullName.toLowerCase().contains(_searchQuery)) {
                      return false;
                    }
                  }
                  return true;
                }).toList();

                if (filteredChallans.isEmpty) {
                  return const EmptyState(icon: Icons.people, title: 'No students found', detail: 'Adjust your filters');
                }

                return ListView.separated(
                  itemCount: filteredChallans.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final c = filteredChallans[i];
                    final s = studentMap[c.studentId]!;

                    final status = ChallanStatus.tryFromWire(c.status);
                    final isPaid = status == ChallanStatus.paid;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isPaid ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
                        child: Icon(
                          isPaid ? Icons.check : Icons.access_time,
                          color: isPaid ? Colors.green : Colors.orange,
                        ),
                      ),
                      title: Text('${s.fullName} (${s.admissionNo})'),
                      subtitle: Text('Due ${c.dueDate}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$currencySymbol ${c.totalAmount.toStringAsFixed(0)}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(width: 16),
                          if (isPaid)
                            OutlinedButton(
                              onPressed: () => _markUnpaid(context, c),
                              child: const Text('Mark Unpaid'),
                            )
                          else
                            FilledButton(
                              onPressed: () => _recordPayment(context, c),
                              child: const Text('Mark Paid'),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
        ],
      ),
    );
  }

  Future<void> _markUnpaid(BuildContext context, FeeChallan challan) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm'),
        content: const Text('Are you sure you want to mark this fee as unpaid? This will reverse the payment record.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes, Mark Unpaid')),
        ],
      ),
    );

    if (confirm == true) {
      await widget.repo.reversePayment(challan);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment reversed.')));
      }
    }
  }

  Future<void> _recordPayment(BuildContext context, FeeChallan challan) async {
    final controller = TextEditingController(
      text: (challan.totalAmount - challan.paidAmount).toStringAsFixed(0),
    );
    var method = PaymentMethod.cash.wire;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: Text('Payment · ${challan.challanNo}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Amount received',
                  prefixText: 'Rs ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: method,
                decoration: const InputDecoration(
                  labelText: 'Method',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final m in PaymentMethod.values)
                    DropdownMenuItem(value: m.wire, child: Text(m.wire)),
                ],
                onChanged: (v) => setLocal(() => method = v ?? method),
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
              child: const Text('Record'),
            ),
          ],
        ),
      ),
    );

    if (confirmed ?? false) {
      final amount = double.tryParse(controller.text.trim()) ?? 0;
      if (amount > 0) {
        if (!context.mounted) return;
        await widget.repo.recordPayment(
          challan: challan,
          amount: amount,
          method: method,
          receivedBy: AppScope.actorOf(context),
        );
      }
    }
    controller.dispose();
  }
}

class StudentFeesScreen extends StatefulWidget {
  const StudentFeesScreen({super.key, required this.repo});

  final FeeRepository repo;

  @override
  State<StudentFeesScreen> createState() => _StudentFeesScreenState();
}

class _StudentFeesScreenState extends State<StudentFeesScreen> {
  String? _classId;
  String _searchQuery = '';
  String _filter = 'all'; // 'all', 'defaulters', 'passout', 'leftout'
  List<SchoolClass> _classes = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    final db = AppScope.databaseOf(context);
    final classes = await (db.select(db.classes)..where((c) => c.deletedAt.isNull())).get();
    if (mounted) setState(() => _classes = classes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Fees'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'all', label: Text('All')),
                    ButtonSegment(value: 'defaulters', label: Text('Defaulters')),
                    ButtonSegment(value: 'passout', label: Text('Passout')),
                    ButtonSegment(value: 'leftout', label: Text('Left Out')),
                  ],
                  selected: {_filter},
                  onSelectionChanged: (set) => setState(() => _filter = set.first),
                ),
                SizedBox(
                  width: 160,
                  child: DropdownButtonFormField<String?>(
                    initialValue: _classId,
                    decoration: const InputDecoration(labelText: 'Class', border: OutlineInputBorder(), isDense: true),
                    items: [
                      const DropdownMenuItem(value: null, child: Text('All')),
                      for (final c in _classes)
                        DropdownMenuItem(value: c.id, child: Text(c.displayName)),
                    ],
                    onChanged: (v) => setState(() => _classId = v),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search Reg ID or Name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
                  ),
                ),
              ],
            ),
          ),
        const Divider(height: 1),
        Expanded(
          child: StreamBuilder<List<Student>>(
            stream: _watchStudents(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              
              return StreamBuilder<List<FeeChallan>>(
                stream: widget.repo.watchChallans(),
                builder: (context, challanSnapshot) {
                  if (!challanSnapshot.hasData) return const SizedBox.shrink();
                  
                  final allChallans = challanSnapshot.data!;
                  var students = snapshot.data!;
                  
                  // Filter by search query
                  if (_searchQuery.isNotEmpty) {
                    students = students.where((s) => 
                      s.admissionNo.toLowerCase().contains(_searchQuery) ||
                      s.fullName.toLowerCase().contains(_searchQuery)
                    ).toList();
                  }

                  // Build challan map per student
                  final studentChallans = <String, List<FeeChallan>>{};
                  for (final c in allChallans) {
                    studentChallans.putIfAbsent(c.studentId, () => []).add(c);
                  }

                  // If filtering by defaulters, only keep those with outstanding > 0 past due
                  final today = encodeDate(DateTime.now());
                  final outstandingMap = <String, double>{};
                  
                  for (final s in students) {
                    final sChallans = studentChallans[s.id] ?? [];
                    final overdue = sChallans.where((c) {
                      final st = ChallanStatus.tryFromWire(c.status);
                      return st?.isOutstanding == true && c.dueDate.compareTo(today) < 0;
                    });
                    final owed = overdue.fold<double>(0, (sum, c) => sum + (c.totalAmount - c.paidAmount));
                    outstandingMap[s.id] = owed;
                  }

                  if (_filter == 'defaulters') {
                    students = students.where((s) => (outstandingMap[s.id] ?? 0) > 0).toList();
                  }

                  if (students.isEmpty) {
                    return const EmptyState(icon: Icons.people, title: 'No students found', detail: 'Try adjusting filters');
                  }

                  return ListView.separated(
                    itemCount: students.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final s = students[i];
                      final owed = outstandingMap[s.id] ?? 0;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: owed > 0 ? Colors.red.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1),
                          child: Icon(
                            owed > 0 ? Icons.warning_amber_rounded : Icons.check,
                            color: owed > 0 ? Colors.red : Colors.green,
                          ),
                        ),
                        title: Text('${s.fullName} (${s.admissionNo})'),
                        subtitle: Text('Status: ${s.status}'),
                        trailing: owed > 0 ? Text(
                          '$currencySymbol ${owed.toStringAsFixed(0)} Overdue',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                        ) : const Text('All Clear'),
                        onTap: () => _openStudentDetails(context, s),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
    );
  }

  Stream<List<Student>> _watchStudents() {
    final db = AppScope.databaseOf(context);
    var query = db.select(db.students)..where((s) => s.deletedAt.isNull());
    
    if (_classId != null) {
      query.where((s) => s.classId.equals(_classId!));
    }
    
    if (_filter == 'passout') {
      query.where((s) => s.status.equals(StudentStatus.graduated.wire));
    } else if (_filter == 'leftout') {
      query.where((s) => s.status.equals(StudentStatus.withdrawn.wire));
    } else if (_filter == 'defaulters') {
      // filtering happens in builder since we need challans
    }
    
    return query.watch();
  }
  
  void _openStudentDetails(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 700,
          height: 600,
          child: _StudentFeeDetailsDialog(repo: widget.repo, student: student),
        ),
      ),
    );
  }
}

class _StudentFeeDetailsDialog extends StatefulWidget {
  const _StudentFeeDetailsDialog({required this.repo, required this.student});

  final FeeRepository repo;
  final Student student;

  @override
  State<_StudentFeeDetailsDialog> createState() => _StudentFeeDetailsDialogState();
}

class _StudentFeeDetailsDialogState extends State<_StudentFeeDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fee Details', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.primary)),
                  const SizedBox(height: 4),
                  Text('${widget.student.fullName} (${widget.student.admissionNo})', style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
              const Spacer(),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: StreamBuilder<List<FeeChallan>>(
            stream: widget.repo.watchChallans(), // In-memory filter below
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              
              final challans = snapshot.data!.where((c) => c.studentId == widget.student.id).toList();
              challans.sort((a, b) => b.issueDate.compareTo(a.issueDate));

              if (challans.isEmpty) {
                return const EmptyState(icon: Icons.receipt, title: 'No fee history', detail: 'No challans found for this student.');
              }

              return ListView.separated(
                itemCount: challans.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final c = challans[i];
                  final status = ChallanStatus.tryFromWire(c.status);
                  final isPaid = status == ChallanStatus.paid;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isPaid ? Colors.green.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
                      child: Icon(
                        isPaid ? Icons.check : Icons.access_time,
                        color: isPaid ? Colors.green : Colors.orange,
                      ),
                    ),
                    title: Text(c.title ?? 'Tuition'),
                    subtitle: Text('Due ${c.dueDate} · Challan ${c.challanNo}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$currencySymbol ${c.totalAmount.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 16),
                        if (isPaid)
                          OutlinedButton(
                            onPressed: () => _markUnpaid(context, c),
                            child: const Text('Mark Unpaid'),
                          )
                        else
                          FilledButton(
                            onPressed: () => _recordPayment(context, c),
                            child: const Text('Mark Paid'),
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
    );
  }

  Future<void> _markUnpaid(BuildContext context, FeeChallan challan) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm'),
        content: const Text('Are you sure you want to mark this fee as unpaid? This will reverse the payment record.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Yes, Mark Unpaid')),
        ],
      ),
    );

    if (confirm == true) {
      await widget.repo.reversePayment(challan);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment reversed.')));
      }
    }
  }

  Future<void> _recordPayment(BuildContext context, FeeChallan challan) async {
    final controller = TextEditingController(
      text: (challan.totalAmount - challan.paidAmount).toStringAsFixed(0),
    );
    var method = PaymentMethod.cash.wire;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: Text('Payment · ${challan.challanNo}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Amount received',
                  prefixText: 'Rs ',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: method,
                decoration: const InputDecoration(
                  labelText: 'Method',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final m in PaymentMethod.values)
                    DropdownMenuItem(value: m.wire, child: Text(m.wire)),
                ],
                onChanged: (v) => setLocal(() => method = v ?? method),
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
              child: const Text('Record'),
            ),
          ],
        ),
      ),
    );

    if (confirmed ?? false) {
      final amount = double.tryParse(controller.text.trim()) ?? 0;
      if (amount > 0) {
        if (!context.mounted) return;
        await widget.repo.recordPayment(
          challan: challan,
          amount: amount,
          method: method,
          receivedBy: AppScope.actorOf(context),
        );
      }
    }
    controller.dispose();
  }
}

class _DefaultersDialog extends StatefulWidget {
  const _DefaultersDialog();

  @override
  State<_DefaultersDialog> createState() => _DefaultersDialogState();
}

class _DefaultersDialogState extends State<_DefaultersDialog> {
  String _filter = 'all'; // 'all', 'class', 'passout', 'leftout'
  String? _classId;
  List<SchoolClass> _classes = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    final db = AppScope.databaseOf(context);
    final classes = await (db.select(db.classes)..where((c) => c.deletedAt.isNull())).get();
    if (mounted) setState(() => _classes = classes);
  }

  @override
  Widget build(BuildContext context) {
    final db = AppScope.databaseOf(context);
    final today = encodeDate(DateTime.now());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Text('Defaulters', style: Theme.of(context).textTheme.headlineSmall),
              const Spacer(),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'all', label: Text('All')),
                  ButtonSegment(value: 'class', label: Text('By Class')),
                  ButtonSegment(value: 'passout', label: Text('Passout')),
                  ButtonSegment(value: 'leftout', label: Text('Left Out')),
                ],
                selected: {_filter},
                onSelectionChanged: (set) => setState(() => _filter = set.first),
              ),
              if (_filter == 'class') ...[
                const SizedBox(width: 16),
                SizedBox(
                  width: 150,
                  child: DropdownButtonFormField<String?>(
                    initialValue: _classId,
                    decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                    items: [
                      for (final c in _classes)
                        DropdownMenuItem(value: c.id, child: Text(c.displayName)),
                    ],
                    onChanged: (v) => setState(() => _classId = v),
                  ),
                ),
              ],
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: StreamBuilder<List<drift.TypedResult>>(
            stream: _watchDefaulters(db, today),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
              
              final results = snapshot.data ?? [];
              if (results.isEmpty) {
                return const EmptyState(icon: Icons.verified, title: 'No defaulters found', detail: 'Everyone is paid up!');
              }

              final totalOwed = results.fold<double>(0, (sum, row) {
                final c = row.readTable(db.feeChallans);
                return sum + (c.totalAmount - c.paidAmount);
              });

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    color: Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.3),
                    child: Row(
                      children: [
                        Text('${results.length} Overdue Challans', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text('Total Outstanding: $currencySymbol ${totalOwed.toStringAsFixed(0)}', 
                          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.error)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: results.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        final row = results[i];
                        final c = row.readTable(db.feeChallans);
                        final s = row.readTable(db.students);
                        
                        return ListTile(
                          leading: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                          title: Text('${s.fullName} (${s.admissionNo})'),
                          subtitle: Text('${c.title ?? 'Tuition'} · Due ${c.dueDate} · Status: ${s.status}'),
                          trailing: Text(
                            '$currencySymbol ${(c.totalAmount - c.paidAmount).toStringAsFixed(0)}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.error),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Stream<List<drift.TypedResult>> _watchDefaulters(AppDatabase db, String today) {
    var query = db.select(db.feeChallans).join([
      drift.innerJoin(db.students, db.students.id.equalsExp(db.feeChallans.studentId)),
    ])..where(
      db.feeChallans.deletedAt.isNull() & 
      db.feeChallans.dueDate.isSmallerThanValue(today) &
      (db.feeChallans.status.equals(ChallanStatus.unpaid.wire) | db.feeChallans.status.equals(ChallanStatus.partial.wire))
    );

    if (_filter == 'class' && _classId != null) {
      query.where(db.students.classId.equals(_classId!));
    } else if (_filter == 'passout') {
      query.where(db.students.status.equals(StudentStatus.graduated.wire));
    } else if (_filter == 'leftout') {
      query.where(db.students.status.equals(StudentStatus.withdrawn.wire));
    } else {
      // all includes active, graduated, withdrawn, etc.
    }

    return query.watch();
  }
}

