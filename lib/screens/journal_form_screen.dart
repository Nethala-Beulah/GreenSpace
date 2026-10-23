import 'package:flutter/material.dart';

class JournalEntryData {
  final String plant;
  final String activity;
  final DateTime date;
  final String notes;
  const JournalEntryData({
    required this.plant,
    required this.activity,
    required this.date,
    required this.notes,
  });
}

class JournalFormScreen extends StatefulWidget {
  final List<String> plants;
  const JournalFormScreen({super.key, this.plants = const []});

  @override
  State<JournalFormScreen> createState() => _JournalFormScreenState();
}

class _JournalFormScreenState extends State<JournalFormScreen> {
  final _key = GlobalKey<FormState>();
  final _notes = TextEditingController();
  final _plantName = TextEditingController();
  String? _plant;
  String _activity = 'Watering';
  DateTime _date = DateTime.now();
  static const _activities = [
    'Watering',
    'Fertilizing',
    'Pruning',
    'Repotting',
  ];

  @override
  void dispose() {
    _notes.dispose();
    _plantName.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) setState(() => _date = picked);
  }

  void _save() {
    if (!_key.currentState!.validate()) return;
    Navigator.pop(
      context,
      JournalEntryData(
        plant: widget.plants.isEmpty ? _plantName.text.trim() : _plant!,
        activity: _activity,
        date: _date,
        notes: _notes.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Plant-care Journal')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Form(
          key: _key,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (widget.plants.isEmpty)
                TextFormField(
                  controller: _plantName,
                  decoration: const InputDecoration(labelText: 'Plant'),
                  validator: (v) =>
                      (v?.trim().isEmpty ?? true) ? 'Enter a plant name' : null,
                )
              else
                DropdownButtonFormField<String>(
                  initialValue: _plant,
                  decoration: const InputDecoration(labelText: 'Plant'),
                  items: widget.plants
                      .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                      .toList(),
                  onChanged: (v) => setState(() => _plant = v),
                  validator: (v) => v == null ? 'Select a plant' : null,
                ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _activity,
                decoration: const InputDecoration(labelText: 'Activity'),
                items: _activities
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) => setState(() => _activity = v ?? _activity),
              ),
              const SizedBox(height: 14),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Date'),
                subtitle: Text('${_date.day}/${_date.month}/${_date.year}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              TextFormField(
                controller: _notes,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _save,
                      child: const Text('Save'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
