import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../services/garden_state.dart';
import '../theme/app_theme.dart';
import 'explore_screen.dart';
import 'plant_details_screen.dart';

class MyGardenScreen extends StatefulWidget {
  const MyGardenScreen({super.key});

  @override
  State<MyGardenScreen> createState() => _MyGardenScreenState();
}

class _MyGardenScreenState extends State<MyGardenScreen> {
  String _filter = 'All'; // 'All', 'Needs Water', 'Hydrated'

  @override
  Widget build(BuildContext context) {
    final gardenState = GardenStateScope.maybeOf(context);
    final allPlants = gardenState?.myGarden ?? [];

    final dueCount = gardenState?.wateringRemindersDueCount ?? 0;

    final filteredPlants = allPlants.where((gp) {
      if (_filter == 'Needs Water') {
        return gp.isWateringDue();
      } else if (_filter == 'Hydrated') {
        return !gp.isWateringDue();
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Urban Garden 🪴',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (dueCount > 0 && gardenState != null)
            TextButton.icon(
              onPressed: () {
                gardenState.waterAllDuePlants();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppTheme.primaryGreen,
                    content: Text('All thirsty plants watered! 💧'),
                  ),
                );
              },
              icon: const Icon(Icons.water_drop, size: 18),
              label: const Text('Water All'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue.shade700,
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _showAddOptions(context, gardenState),
        icon: const Icon(Icons.add),
        label: const Text('Add Plant'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Watering Alert Banner if any plants are due
            if (dueCount > 0)
              Container(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.water_drop, color: Colors.amber.shade800),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$dueCount ${dueCount == 1 ? "plant needs" : "plants need"} water today!',
                        style: TextStyle(
                          color: Colors.amber.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    FilledButton.tonal(
                      onPressed: () {
                        setState(() {
                          _filter = 'Needs Water';
                        });
                      },
                      style: FilledButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text('View'),
                    ),
                  ],
                ),
              ),

            // Filter Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                children: [
                  _FilterPill(
                    label: 'All (${allPlants.length})',
                    isSelected: _filter == 'All',
                    onTap: () => setState(() => _filter = 'All'),
                  ),
                  const SizedBox(width: 8),
                  _FilterPill(
                    label: 'Thirsty ($dueCount)',
                    isSelected: _filter == 'Needs Water',
                    badgeColor: dueCount > 0 ? Colors.red.shade100 : null,
                    textColor: dueCount > 0 ? Colors.red.shade800 : null,
                    onTap: () => setState(() => _filter = 'Needs Water'),
                  ),
                  const SizedBox(width: 8),
                  _FilterPill(
                    label: 'Hydrated (${allPlants.length - dueCount})',
                    isSelected: _filter == 'Hydrated',
                    onTap: () => setState(() => _filter = 'Hydrated'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Garden List
            Expanded(
              child: filteredPlants.isEmpty
                  ? _buildEmptyState(context, allPlants.isEmpty)
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                      itemCount: filteredPlants.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = filteredPlants[index];
                        return _GardenPlantCard(
                          entry: item,
                          onWater: () {
                            gardenState?.waterPlant(item.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text('Watered ${item.nickname}! 💧'),
                              ),
                            );
                          },
                          onEdit: () =>
                              _showEditDialog(context, gardenState, item),
                          onDelete: () =>
                              _confirmDelete(context, gardenState, item),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlantDetailsScreen(
                                  plant: item.plant,
                                  name: item.plant.name,
                                  category: item.plant.category,
                                  imageUrl: item.plant.imageUrl,
                                  sunlight: item.plant.sunlight,
                                  watering: item.plant.watering,
                                ),
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

  Widget _buildEmptyState(BuildContext context, bool isEntireGardenEmpty) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.yard_outlined,
              size: 64,
              color: AppTheme.primaryGreen,
            ),
            const SizedBox(height: 16),
            Text(
              isEntireGardenEmpty
                  ? 'Your Garden is Empty'
                  : 'No plants match this filter',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isEntireGardenEmpty
                  ? 'Start your urban garden by exploring catalog plants or adding your own custom houseplant.'
                  : 'All your plants are currently happy and well-hydrated!',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppTheme.mutedText, fontSize: 14),
            ),
            const SizedBox(height: 20),
            if (isEntireGardenEmpty)
              FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExploreScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text('Explore Catalog Plants'),
              )
            else
              FilledButton.tonal(
                onPressed: () => setState(() => _filter = 'All'),
                child: const Text('View All Plants'),
              ),
          ],
        ),
      ),
    );
  }

  void _showAddOptions(BuildContext context, GardenState? gardenState) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add to Your Garden',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkGreen,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppTheme.lightGreen,
                  child: Icon(Icons.explore, color: AppTheme.primaryGreen),
                ),
                title: const Text('Pick from Plant Catalog'),
                subtitle: const Text(
                  'Choose from popular indoor and outdoor plants',
                ),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExploreScreen(),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppTheme.lightGreen,
                  child: Icon(Icons.add_circle, color: AppTheme.primaryGreen),
                ),
                title: const Text('Add Custom Urban Plant'),
                subtitle: const Text(
                  'Enter custom species, schedule, and notes',
                ),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  _showCustomPlantDialog(context, gardenState);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomPlantDialog(BuildContext context, GardenState? gardenState) {
    if (gardenState == null) return;

    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final nicknameCtrl = TextEditingController();
    final locationCtrl = TextEditingController(text: 'Living Room');
    final intervalCtrl = TextEditingController(text: '7');
    final sunlightCtrl = TextEditingController(text: 'Bright indirect light');
    final notesCtrl = TextEditingController();
    String category = 'Indoor';

    showDialog(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Custom Plant'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Plant Species Name *',
                      hintText: 'e.g. Jade Plant, Calathea',
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Please enter plant name'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: nicknameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Nickname',
                      hintText: 'e.g. Lucky Jade',
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: category,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: const [
                      DropdownMenuItem(value: 'Indoor', child: Text('Indoor')),
                      DropdownMenuItem(
                        value: 'Outdoor',
                        child: Text('Outdoor'),
                      ),
                      DropdownMenuItem(value: 'Herbs', child: Text('Herbs')),
                      DropdownMenuItem(
                        value: 'Succulents',
                        child: Text('Succulents'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() => category = val);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: locationCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Location / Room',
                      hintText: 'e.g. Balcony, Kitchen, Bedroom',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: intervalCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Watering Interval (Days) *',
                      hintText: 'e.g. 7',
                    ),
                    validator: (v) {
                      final n = int.tryParse(v ?? '');
                      if (n == null || n <= 0) {
                        return 'Enter a valid positive number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: sunlightCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Sunlight Requirements',
                      hintText: 'e.g. Full sun, Moderate light',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: notesCtrl,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                      hintText: 'Optional care notes or origin...',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final interval = int.tryParse(intervalCtrl.text) ?? 7;
                  final customPlant = Plant(
                    id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
                    name: nameCtrl.text.trim(),
                    scientificName: '',
                    category: category,
                    imageUrl:
                        'https://images.unsplash.com/photo-1545241047-6083a3684587?w=600',
                    sunlight: sunlightCtrl.text.trim(),
                    watering: 'Every $interval days',
                    wateringIntervalDays: interval,
                    soil: 'Well-draining potting soil',
                    difficulty: 'Moderate',
                    description: 'Custom plant in urban garden collection.',
                    growthHabit: 'Houseplant',
                    isPetSafe: true,
                    toxicityNotes: 'Monitor pets around novel houseplants.',
                    gardeningTip: 'Maintain regular watering schedule.',
                  );

                  gardenState.addCustomPlant(customPlant);
                  gardenState.addToGarden(
                    plant: customPlant,
                    nickname: nicknameCtrl.text.trim().isNotEmpty
                        ? nicknameCtrl.text.trim()
                        : nameCtrl.text.trim(),
                    location: locationCtrl.text.trim(),
                    notes: notesCtrl.text.trim(),
                  );

                  Navigator.pop(dialogCtx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppTheme.primaryGreen,
                      content: Text(
                        'Added ${nameCtrl.text.trim()} to garden! 🌱',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Save Plant'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    GardenState? gardenState,
    GardenPlant entry,
  ) {
    if (gardenState == null) return;

    final nicknameCtrl = TextEditingController(text: entry.nickname);
    final locationCtrl = TextEditingController(text: entry.location);
    final notesCtrl = TextEditingController(text: entry.notes);

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text('Edit ${entry.nickname}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nicknameCtrl,
                decoration: const InputDecoration(labelText: 'Nickname'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: locationCtrl,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              gardenState.updateGardenPlant(
                id: entry.id,
                nickname: nicknameCtrl.text,
                location: locationCtrl.text,
                notes: notesCtrl.text,
              );
              Navigator.pop(dialogCtx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Updated plant details!')),
              );
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(
    BuildContext context,
    GardenState? gardenState,
    GardenPlant entry,
  ) {
    if (gardenState == null) return;

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Remove from Garden?'),
        content: Text(
          'Are you sure you want to remove "${entry.nickname}" from your garden collection?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.errorRed),
            onPressed: () {
              gardenState.removeFromGarden(entry.id);
              Navigator.pop(dialogCtx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Removed ${entry.nickname}')),
              );
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? badgeColor;
  final Color? textColor;

  const _FilterPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.badgeColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryGreen
              : (badgeColor ?? Colors.white),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryGreen : Colors.green.shade100,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Colors.white
                : (textColor ?? AppTheme.darkGreen),
          ),
        ),
      ),
    );
  }
}

class _GardenPlantCard extends StatelessWidget {
  final GardenPlant entry;
  final VoidCallback onWater;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const _GardenPlantCard({
    required this.entry,
    required this.onWater,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDue = entry.isWateringDue();
    final daysRemaining = entry.daysUntilWatering();

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: isDue ? Colors.amber.shade300 : Colors.green.shade50,
          width: isDue ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                    entry.plant.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppTheme.lightGreen,
                      child: const Icon(
                        Icons.local_florist,
                        color: AppTheme.primaryGreen,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            entry.nickname,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppTheme.darkGreen,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          iconSize: 20,
                          onSelected: (val) {
                            if (val == 'edit') onEdit();
                            if (val == 'delete') onDelete();
                          },
                          itemBuilder: (context) => const [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 18),
                                  SizedBox(width: 8),
                                  Text('Edit details'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Remove',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      entry.plant.name,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.mutedText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.place_outlined,
                          size: 14,
                          color: AppTheme.mutedText,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            entry.location,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.mutedText,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Watering Status & Quick Action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isDue
                                ? Colors.amber.shade100
                                : Colors.green.shade50,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isDue
                                    ? Icons.water_drop
                                    : Icons.check_circle_outline,
                                size: 12,
                                color: isDue
                                    ? Colors.amber.shade900
                                    : AppTheme.primaryGreen,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                isDue
                                    ? 'Needs Water Today'
                                    : 'Water in $daysRemaining d',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: isDue
                                      ? Colors.amber.shade900
                                      : AppTheme.primaryGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FilledButton.tonalIcon(
                          onPressed: onWater,
                          icon: const Icon(Icons.water_drop_outlined, size: 14),
                          label: const Text('Water'),
                          style: FilledButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
