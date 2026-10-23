import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'plant_form_screen.dart';

class PlantDetailsScreen extends StatefulWidget {
  final String name;
  final String category;
  final String imageUrl;
  final String sunlight;
  final String watering;
  final String notes;
  final ValueChanged<PlantFormData>? onPlantUpdated;

  const PlantDetailsScreen({
    super.key,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.sunlight,
    required this.watering,
    this.notes = '',
    this.onPlantUpdated,
  });

  @override
  State<PlantDetailsScreen> createState() => _PlantDetailsScreenState();
}

class _PlantDetailsScreenState extends State<PlantDetailsScreen> {
  late PlantFormData _plant;

  @override
  void initState() {
    super.initState();
    _plant = PlantFormData(
      name: widget.name,
      category: widget.category,
      species: widget.name,
      location: 'Home',
      wateringFrequency: widget.watering,
      sunlight: widget.sunlight,
      notes: widget.notes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppTheme.background,
            foregroundColor: AppTheme.darkGreen,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.lightGreen,
                    child: const Icon(
                      Icons.local_florist,
                      size: 100,
                      color: AppTheme.primaryGreen,
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.lightGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _plant.category,
                          style: const TextStyle(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _plant.name,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkGreen,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bring more greenery into your space!',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'Care Guide',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkGreen,
                        ),
                      ),
                      const SizedBox(height: 14),

                      _CareCard(
                        icon: Icons.wb_sunny_outlined,
                        title: 'Sunlight',
                        description: _plant.sunlight,
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 12),
                      _CareCard(
                        icon: Icons.water_drop_outlined,
                        title: 'Watering',
                        description: _plant.wateringFrequency,
                        color: Colors.blue,
                      ),
                      if (_plant.notes.trim().isNotEmpty) ...[
                        const SizedBox(height: 12),
                        _CareCard(
                          icon: Icons.notes_outlined,
                          title: 'Notes',
                          description: _plant.notes,
                          color: AppTheme.primaryGreen,
                        ),
                      ],
                      const SizedBox(height: 24),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppTheme.lightGreen,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.eco, color: AppTheme.primaryGreen),
                                SizedBox(width: 8),
                                Text(
                                  'Gardening Tip',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.darkGreen,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Check the soil before watering. '
                              'Different plants need different amounts '
                              'of water, so avoid overwatering.',
                              style: TextStyle(fontSize: 15, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            '/plant/add',
                            arguments: _plant,
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text('Add to My Garden'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppTheme.primaryGreen,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final result = await Navigator.pushNamed<dynamic>(
                              context,
                              '/plant/edit',
                              arguments: _plant,
                            );
                            if (!context.mounted || result is! PlantFormData) {
                              return;
                            }
                            setState(() => _plant = result);
                            widget.onPlantUpdated?.call(result);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Updated ${result.name} details for this session.',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('Edit Plant'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CareCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _CareCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
