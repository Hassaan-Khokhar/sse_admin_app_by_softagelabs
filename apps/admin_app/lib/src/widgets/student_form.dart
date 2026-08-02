import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

/// What the form collects.
typedef StudentFormData = ({
  String fullName,
  String? fatherName,
  String admissionNo,
  int? rollNo,
  String? classId,
  String? gender,
  String? guardianPhone,
  String? dateOfBirth,
  String? address,
});

/// Enrol or edit a student.
class StudentFormDialog extends StatefulWidget {
  const StudentFormDialog({
    required this.classes,
    required this.suggestedAdmissionNo,
    required this.onSave,
    this.student,
    super.key,
  });

  final List<SchoolClass> classes;
  final String suggestedAdmissionNo;
  final Student? student;
  final Future<void> Function(StudentFormData) onSave;

  @override
  State<StudentFormDialog> createState() => _StudentFormDialogState();
}

class _StudentFormDialogState extends State<StudentFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullName;
  late final TextEditingController _fatherName;
  late final TextEditingController _admissionNo;
  late final TextEditingController _rollNo;
  late final TextEditingController _guardianPhone;
  late final TextEditingController _dateOfBirth;
  late final TextEditingController _address;
  String? _classId;
  String? _gender;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final s = widget.student;
    _fullName = TextEditingController(text: s?.fullName ?? '');
    _fatherName = TextEditingController(text: s?.fatherName ?? '');
    _admissionNo =
        TextEditingController(text: s?.admissionNo ?? widget.suggestedAdmissionNo);
    _rollNo = TextEditingController(text: s?.rollNo?.toString() ?? '');
    _guardianPhone = TextEditingController(text: s?.guardianPhone ?? '');
    _dateOfBirth = TextEditingController(text: s?.dateOfBirth ?? '');
    _address = TextEditingController(text: s?.address ?? '');
    _classId = s?.classId ?? widget.classes.firstOrNull?.id;
    _gender = s?.gender;
  }

  @override
  void dispose() {
    for (final c in [
      _fullName,
      _fatherName,
      _admissionNo,
      _rollNo,
      _guardianPhone,
      _dateOfBirth,
      _address,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await widget.onSave((
      fullName: _fullName.text.trim(),
      fatherName: _nullIfBlank(_fatherName.text),
      admissionNo: _admissionNo.text.trim(),
      rollNo: int.tryParse(_rollNo.text.trim()),
      classId: _classId,
      gender: _gender,
      guardianPhone: _nullIfBlank(_guardianPhone.text),
      dateOfBirth: _nullIfBlank(_dateOfBirth.text),
      address: _nullIfBlank(_address.text),
    ));
    if (mounted) Navigator.pop(context);
  }

  String? _nullIfBlank(String value) =>
      value.trim().isEmpty ? null : value.trim();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.student == null ? 'Enrol student' : 'Edit student'),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _field(_fullName, 'Full name', required: true),
                _field(_fatherName, "Father's name"),
                Row(
                  children: [
                    // Permanent and school-wide. Distinct from roll no, which
                    // is per-class and resets each year (CLAUDE.md §8).
                    Expanded(
                      child: _field(_admissionNo, 'Admission no', required: true),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _field(_rollNo, 'Roll no', keyboard: TextInputType.number),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: _classId,
                        decoration: const InputDecoration(
                          labelText: 'Class',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          for (final c in widget.classes)
                            DropdownMenuItem(
                                value: c.id, child: Text(c.displayName)),
                        ],
                        onChanged: (v) => setState(() => _classId = v),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: _gender,
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          for (final g in Gender.values)
                            DropdownMenuItem(value: g.wire, child: Text(g.wire)),
                        ],
                        onChanged: (v) => setState(() => _gender = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Office use only. This must never be rendered in the student
                // app — these are minors (CLAUDE.md §7).
                _field(_guardianPhone, "Guardian's phone (office use only)"),
                _field(_dateOfBirth, 'Date of birth (YYYY-MM-DD)'),
                _field(_address, 'Address'),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving ? null : _submit,
          child: _saving
              ? const SizedBox(
                  width: 16, height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Save'),
        ),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool required = false,
    TextInputType? keyboard,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboard,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
          validator: required
              ? (v) => (v == null || v.trim().isEmpty) ? 'Required' : null
              : null,
        ),
      );
}
