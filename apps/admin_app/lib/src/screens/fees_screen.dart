import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/fee_repository.dart';
import '../widgets/empty_state.dart';

/// Fees — structures, bulk generation, and the defaulter list.
class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Fees',
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
          const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(text: 'Challans'),
              Tab(text: 'Defaulters'),
              Tab(text: 'Fee structure'),
            ],
          ),
          const Divider(height: 1),
          const Expanded(
            child: TabBarView(
              children: [
                _ChallansTab(),
                _DefaultersTab(),
                _StructureTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallansTab extends StatefulWidget {
  const _ChallansTab();

  @override
  State<_ChallansTab> createState() => _ChallansTabState();
}

class _ChallansTabState extends State<_ChallansTab> {
  late final FeeRepository _repo;
  late int _month;
  late int _year;
  bool _busy = false;
  String? _message;
  late String _actor;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = now.month;
    _year = now.year;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = FeeRepository(AppScope.databaseOf(context));
    _actor = AppScope.actorOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
          child: Row(
            children: [
              DropdownButton<int>(
                value: _month,
                onChanged: (v) => setState(() => _month = v ?? _month),
                items: [
                  for (var m = 1; m <= 12; m++)
                    DropdownMenuItem(value: m, child: Text(_monthName(m))),
                ],
              ),
              const SizedBox(width: 12),
              DropdownButton<int>(
                value: _year,
                onChanged: (v) => setState(() => _year = v ?? _year),
                items: [
                  for (var y = DateTime.now().year - 1;
                      y <= DateTime.now().year + 1;
                      y++)
                    DropdownMenuItem(value: y, child: Text('$y')),
                ],
              ),
              const Spacer(),
              if (_message case final msg?) ...[
                Text(msg, style: theme.textTheme.bodySmall),
                const SizedBox(width: 12),
              ],
              FilledButton.icon(
                onPressed: _busy ? null : _generate,
                icon: _busy
                    ? const SizedBox(
                        width: 16, height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.bolt, size: 18),
                label: Text('Generate for ${_monthName(_month)}'),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: StreamBuilder<List<FeeChallan>>(
            stream: _repo.watchChallans(month: _month, year: _year),
            builder: (context, snapshot) {
              final challans = snapshot.data ?? const [];
              if (challans.isEmpty) {
                return EmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: 'No challans for ${_monthName(_month)} $_year',
                  detail: 'Set a fee structure first, then generate. One '
                      'challan per active student, in a single transaction.',
                );
              }
              return ListView.separated(
                itemCount: challans.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) => _ChallanTile(
                  challan: challans[i],
                  onPay: () => _recordPayment(challans[i]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _generate() async {
    setState(() {
      _busy = true;
      _message = null;
    });
    final watch = Stopwatch()..start();
    try {
      final count = await _repo.generateForMonth(
        month: _month,
        year: _year,
        // Due on the 10th, the usual convention in Pakistani schools.
        dueDate: DateTime(_year, _month, 10),
      );
      if (mounted) {
        setState(() => _message =
            '$count challans in ${watch.elapsedMilliseconds} ms');
      }
    } on FeeGenerationException catch (error) {
      // Already phrased for a human — show it as-is.
      if (mounted) setState(() => _message = error.message);
    } on Object catch (error) {
      if (mounted) setState(() => _message = 'Failed: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _recordPayment(FeeChallan challan) async {
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
        await _repo.recordPayment(
          challan: challan,
          amount: amount,
          method: method,
          receivedBy: _actor,
        );
      }
    }
    controller.dispose();
  }

  static String _monthName(int m) => const [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December',
      ][m - 1];
}

class _ChallanTile extends StatelessWidget {
  const _ChallanTile({required this.challan, required this.onPay});

  final FeeChallan challan;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = ChallanStatus.tryFromWire(challan.status);
    final outstanding = challan.totalAmount - challan.paidAmount;

    return ListTile(
      leading: Icon(
        status == ChallanStatus.paid
            ? Icons.check_circle
            : Icons.receipt_long_outlined,
        color: status == ChallanStatus.paid ? Colors.green : null,
      ),
      title: Text(challan.challanNo),
      subtitle: Text([
        'Total $currencySymbol ${challan.totalAmount.toStringAsFixed(0)}',
        if (challan.arrears > 0)
          'incl. arrears $currencySymbol ${challan.arrears.toStringAsFixed(0)}',
        'due ${challan.dueDate}',
      ].join(' · ')),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            label: Text(status?.wire ?? '?',
                style: const TextStyle(fontSize: 11)),
            backgroundColor: switch (status) {
              ChallanStatus.paid => Colors.green.withValues(alpha: 0.15),
              ChallanStatus.partial => Colors.orange.withValues(alpha: 0.15),
              _ => theme.colorScheme.errorContainer.withValues(alpha: 0.4),
            },
            visualDensity: VisualDensity.compact,
          ),
          const SizedBox(width: 8),
          if (status?.isOutstanding ?? false)
            OutlinedButton(
              onPressed: onPay,
              child: Text('Take $currencySymbol ${outstanding.toStringAsFixed(0)}'),
            ),
        ],
      ),
    );
  }
}

/// Unpaid and past the due date.
class _DefaultersTab extends StatelessWidget {
  const _DefaultersTab();

  @override
  Widget build(BuildContext context) {
    final repo = FeeRepository(AppScope.databaseOf(context));
    final today = encodeDate(DateTime.now());

    return StreamBuilder<List<FeeChallan>>(
      stream: repo.watchChallans(unpaidOnly: true),
      builder: (context, snapshot) {
        final overdue = (snapshot.data ?? const <FeeChallan>[])
            .where((c) => c.dueDate.compareTo(today) < 0)
            .toList();

        if (overdue.isEmpty) {
          return const EmptyState(
            icon: Icons.verified_outlined,
            title: 'No defaulters',
            detail: 'Every issued challan is either paid or not yet due.',
          );
        }

        final owed = overdue.fold<double>(
            0, (sum, c) => sum + (c.totalAmount - c.paidAmount));

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Text('${overdue.length} overdue',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(width: 16),
                  Text(
                    '$currencySymbol ${owed.toStringAsFixed(0)} outstanding',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                itemCount: overdue.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) => ListTile(
                  leading: const Icon(Icons.warning_amber_outlined),
                  title: Text(overdue[i].challanNo),
                  subtitle: Text('Due ${overdue[i].dueDate}'),
                  trailing: Text(
                    '$currencySymbol ${(overdue[i].totalAmount - overdue[i].paidAmount).toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StructureTab extends StatefulWidget {
  const _StructureTab();

  @override
  State<_StructureTab> createState() => _StructureTabState();
}

class _StructureTabState extends State<_StructureTab> {
  late final FeeRepository _repo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = FeeRepository(AppScope.databaseOf(context));
  }

  @override
  Widget build(BuildContext context) {
    final db = AppScope.databaseOf(context);

    return StreamBuilder<List<FeeStructure>>(
      stream: _repo.watchStructures(),
      builder: (context, snapshot) {
        final structures = snapshot.data ?? const [];

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Amounts charged each month. A structure with no class '
                      'applies school-wide; a class-specific one overrides it.',
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: () => _edit(db),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add structure'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: structures.isEmpty
                  ? const EmptyState(
                      icon: Icons.payments_outlined,
                      title: 'No fee structure yet',
                      detail: 'Challan generation needs one — it has no amounts '
                          'to bill without it.',
                    )
                  : ListView.separated(
                      itemCount: structures.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, i) {
                        final s = structures[i];
                        final total = s.tuitionFee +
                            s.admissionFee +
                            s.examFee +
                            s.otherFee;
                        return ListTile(
                          leading: const Icon(Icons.payments_outlined),
                          title: Text(s.classId == null
                              ? 'School-wide'
                              : 'Class-specific'),
                          subtitle: Text(
                            'Tuition ${s.tuitionFee.toStringAsFixed(0)} · '
                            'Admission ${s.admissionFee.toStringAsFixed(0)} · '
                            'Exam ${s.examFee.toStringAsFixed(0)} · '
                            'Other ${s.otherFee.toStringAsFixed(0)}',
                          ),
                          trailing: Text(
                            '$currencySymbol ${total.toStringAsFixed(0)}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          onTap: () => _edit(db, existing: s),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _edit(AppDatabase db, {FeeStructure? existing}) async {
    final school = await db.select(db.schools).getSingleOrNull();
    final year = await (db.select(db.academicYears)
          ..where((y) => y.isCurrent.equals(true)))
        .getSingleOrNull();
    if (school == null || year == null || !mounted) return;

    final classes = await (db.select(db.classes)
          ..where((c) => c.deletedAt.isNull()))
        .get();

    final tuition = TextEditingController(
        text: (existing?.tuitionFee ?? 4500).toStringAsFixed(0));
    final admission = TextEditingController(
        text: (existing?.admissionFee ?? 0).toStringAsFixed(0));
    final exam =
        TextEditingController(text: (existing?.examFee ?? 500).toStringAsFixed(0));
    final other =
        TextEditingController(text: (existing?.otherFee ?? 0).toStringAsFixed(0));
    var classId = existing?.classId;

    if (!mounted) return;
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: Text(existing == null ? 'Add fee structure' : 'Edit structure'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String?>(
                  initialValue: classId,
                  decoration: const InputDecoration(
                    labelText: 'Applies to',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem(
                        value: null, child: Text('All classes (school-wide)')),
                    for (final c in classes)
                      DropdownMenuItem(
                          value: c.id, child: Text('Class ${c.displayName}')),
                  ],
                  onChanged: (v) => setLocal(() => classId = v),
                ),
                const SizedBox(height: 12),
                _money(tuition, 'Tuition fee'),
                _money(admission, 'Admission fee'),
                _money(exam, 'Exam fee'),
                _money(other, 'Other'),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Save')),
          ],
        ),
      ),
    );

    if (saved ?? false) {
      await _repo.saveStructure(
        schoolId: school.id,
        academicYearId: year.id,
        id: existing?.id,
        classId: classId,
        tuition: double.tryParse(tuition.text) ?? 0,
        admission: double.tryParse(admission.text) ?? 0,
        exam: double.tryParse(exam.text) ?? 0,
        other: double.tryParse(other.text) ?? 0,
      );
    }
    for (final c in [tuition, admission, exam, other]) {
      c.dispose();
    }
  }

  Widget _money(TextEditingController controller, String label) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: label,
            prefixText: '$currencySymbol ',
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
      );
}
