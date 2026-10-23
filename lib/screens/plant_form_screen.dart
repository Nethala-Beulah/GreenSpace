import 'package:flutter/material.dart';

class PlantFormData {
  final String name;
  final String category;
  final String species;
  final String location;
  final String wateringFrequency;
  final String sunlight;
  final String notes;

  const PlantFormData({
    required this.name,
    this.category = '',
    required this.species,
    required this.location,
    required this.wateringFrequency,
    required this.sunlight,
    this.notes = '',
  });
}

class PlantFormScreen extends StatefulWidget {
  final PlantFormData? initialData;
  const PlantFormScreen({super.key, this.initialData});

  @override
  State<PlantFormScreen> createState() => _PlantFormScreenState();
}

class _PlantFormScreenState extends State<PlantFormScreen> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _category;
  late final TextEditingController _species;
  late final TextEditingController _location;
  late final TextEditingController _notes;
  String? _watering;
  String? _sunlight;
  static const _baseWateringOptions = [
    'Daily',
    'Every 2 days',
    'Every 3 days',
    'Every 5 days',
    'Every 7 days',
    'Weekly',
    'Every 2 weeks',
  ];
  static const _baseSunlightOptions = [
    'Low light',
    'Low to bright',
    'Indirect light',
    'Indirect sunlight',
    'Bright indirect',
    'Bright indirect light',
    'Full sunlight',
    'Partial shade',
  ];

  List<String> get _wateringOptions {
    final suppliedValue = widget.initialData?.wateringFrequency;
    return [
      ..._baseWateringOptions,
      if (suppliedValue != null &&
          !_baseWateringOptions.contains(suppliedValue))
        suppliedValue,
    ];
  }

  List<String> get _sunlightOptions {
    final suppliedValue = widget.initialData?.sunlight;
    return [
      ..._baseSunlightOptions,
      if (suppliedValue != null &&
          !_baseSunlightOptions.contains(suppliedValue))
        suppliedValue,
    ];
  }

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;
    _name = TextEditingController(text: data?.name ?? '');
    _category = TextEditingController(text: data?.category ?? '');
    _species = TextEditingController(text: data?.species ?? '');
    _location = TextEditingController(text: data?.location ?? '');
    _notes = TextEditingController(text: data?.notes ?? '');
    _watering = data?.wateringFrequency;
    _sunlight = data?.sunlight;
  }

  @override
  void dispose() {
    _name.dispose();
    _category.dispose();
    _species.dispose();
    _location.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _save() {
    if (!_key.currentState!.validate()) return;
    Navigator.pop(
      context,
      PlantFormData(
        name: _name.text.trim(),
        category: _category.text.trim(),
        species: _species.text.trim(),
        location: _location.text.trim(),
        wateringFrequency: _watering!,
        sunlight: _sunlight!,
        notes: _notes.text.trim(),
      ),
    );
  }

  String? _required(String? value) =>
      (value?.trim().isEmpty ?? true) ? 'This field is required' : null;

  @override
  Widget build(BuildContext context) {
    final editing = widget.initialData != null;
    return Scaffold(
      appBar: AppBar(title: Text(editing ? 'Edit Plant' : 'Add Plant')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Plant name'),
                  validator: _required,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _category,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _species,
                  decoration: const InputDecoration(labelText: 'Species'),
                  validator: _required,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _location,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: _required,
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _watering,
                  decoration: const InputDecoration(
                    labelText: 'Watering frequency',
                  ),
                  items: _wateringOptions
                      .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                      .toList(),
                  onChanged: (v) => setState(() => _watering = v),
                  validator: (v) =>
                      v == null ? 'Choose a watering frequency' : null,
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _sunlight,
                  decoration: const InputDecoration(
                    labelText: 'Sunlight requirements',
                  ),
                  items: _sunlightOptions
                      .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                      .toList(),
                  onChanged: (v) => setState(() => _sunlight = v),
                  validator: (v) =>
                      v == null ? 'Choose a sunlight requirement' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _notes,
                  maxLines: 3,
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
}
