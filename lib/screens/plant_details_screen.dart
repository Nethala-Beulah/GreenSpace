import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../models/plant.dart';
import '../services/garden_state.dart';
import '../theme/app_theme.dart';
import '../widgets/care_info_card.dart';

class PlantDetailsScreen extends StatelessWidget {
  final Plant? plant;
=======
import '../theme/app_theme.dart';

class PlantDetailsScreen extends StatelessWidget {
>>>>>>> origin/main
  final String name;
  final String category;
  final String imageUrl;
  final String sunlight;
  final String watering;

  const PlantDetailsScreen({
    super.key,
<<<<<<< HEAD
    this.plant,
    this.name = '',
    this.category = 'Indoor',
    this.imageUrl = '',
    this.sunlight = 'Indirect light',
    this.watering = 'Moderate',
=======
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.sunlight,
    required this.watering,
>>>>>>> origin/main
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final gardenState = GardenStateScope.maybeOf(context);

    // Resolve effective plant object
    final effectivePlant =
        plant ??
        (gardenState != null
            ? gardenState.catalog.firstWhere(
                (p) => p.name.toLowerCase() == name.toLowerCase(),
                orElse: () => Plant(
                  id: name.toLowerCase().replaceAll(' ', '_'),
                  name: name.isNotEmpty ? name : 'Plant',
                  scientificName: '',
                  category: category,
                  imageUrl: imageUrl,
                  sunlight: sunlight,
                  watering: watering,
                  wateringIntervalDays: 7,
                  soil: 'Well-draining potting soil',
                  difficulty: 'Easy',
                  description:
                      'A wonderful plant selection for indoor and urban gardeners.',
                  growthHabit: 'Foliage houseplant',
                ),
              )
            : Plant(
                id: name.toLowerCase().replaceAll(' ', '_'),
                name: name.isNotEmpty ? name : 'Plant',
                scientificName: '',
                category: category,
                imageUrl: imageUrl,
                sunlight: sunlight,
                watering: watering,
                wateringIntervalDays: 7,
                soil: 'Well-draining potting soil',
                difficulty: 'Easy',
                description:
                    'A wonderful plant selection for indoor and urban gardeners.',
                growthHabit: 'Foliage houseplant',
              ));

    final isFavorite = gardenState?.isFavorite(effectivePlant.id) ?? false;
    final isInGarden = gardenState?.isInGarden(effectivePlant.id) ?? false;
    final gardenEntry = gardenState?.getGardenEntry(effectivePlant.id);

=======
>>>>>>> origin/main
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
<<<<<<< HEAD
            expandedHeight: 320,
            pinned: true,
            backgroundColor: AppTheme.background,
            foregroundColor: AppTheme.darkGreen,
            actions: [
              if (gardenState != null)
                IconButton(
                  tooltip: isFavorite
                      ? 'Remove from favorites'
                      : 'Add to favorites',
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : AppTheme.darkGreen,
                  ),
                  onPressed: () {
                    gardenState.toggleFavorite(effectivePlant.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text(
                          isFavorite
                              ? 'Removed ${effectivePlant.name} from favorites'
                              : 'Added ${effectivePlant.name} to favorites ❤️',
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                effectivePlant.imageUrl.isNotEmpty
                    ? effectivePlant.imageUrl
                    : imageUrl,
=======
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppTheme.background,
            foregroundColor: AppTheme.darkGreen,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                imageUrl,
>>>>>>> origin/main
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.lightGreen,
<<<<<<< HEAD
                    child: const Center(
                      child: Icon(
                        Icons.local_florist,
                        size: 90,
                        color: AppTheme.primaryGreen,
                      ),
=======
                    child: const Icon(
                      Icons.local_florist,
                      size: 100,
                      color: AppTheme.primaryGreen,
>>>>>>> origin/main
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
<<<<<<< HEAD
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category & difficulty badges
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
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
                              effectivePlant.category,
                              style: const TextStyle(
                                color: AppTheme.primaryGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.amber.shade200),
                            ),
                            child: Text(
                              'Difficulty: ${effectivePlant.difficulty}',
                              style: TextStyle(
                                color: Colors.amber.shade900,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          if (effectivePlant.isPetSafe)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blue.shade200),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.pets,
                                    size: 14,
                                    color: AppTheme.accentBlue,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Pet Safe',
                                    style: TextStyle(
                                      color: AppTheme.accentBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Plant Title & Scientific Name
                      Text(
                        effectivePlant.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkGreen,
                        ),
                      ),
                      if (effectivePlant.scientificName.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          effectivePlant.scientificName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: AppTheme.mutedText,
                          ),
                        ),
                      ],
                      const SizedBox(height: 14),

                      // Description
                      if (effectivePlant.description.isNotEmpty) ...[
                        Text(
                          effectivePlant.description,
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppTheme.textColor,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // In Garden Status Banner if already added
                      if (isInGarden && gardenEntry != null) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.green.shade200),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: AppTheme.primaryGreen,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'In Your Garden (${gardenEntry.nickname})',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.darkGreen,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Location: ${gardenEntry.location} • Status: ${gardenEntry.isWateringDue() ? "Thirsty! Needs water today" : "Well hydrated"}',
                                      style: TextStyle(
                                        color: gardenEntry.isWateringDue()
                                            ? AppTheme.accentOrange
                                            : AppTheme.mutedText,
                                        fontSize: 12,
                                        fontWeight: gardenEntry.isWateringDue()
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Care Guide Section
                      const Text(
                        'Care Guide',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkGreen,
                        ),
                      ),
                      const SizedBox(height: 12),

                      CareInfoCard(
                        icon: Icons.wb_sunny_outlined,
                        title: 'Sunlight',
                        description: effectivePlant.sunlight,
                        badgeText: 'Exposure',
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 10),
                      CareInfoCard(
                        icon: Icons.water_drop_outlined,
                        title: 'Watering Frequency',
                        description: effectivePlant.watering,
                        badgeText:
                            'Every ${effectivePlant.wateringIntervalDays}d',
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 10),
                      CareInfoCard(
                        icon: Icons.grass_outlined,
                        title: 'Soil Requirements',
                        description: effectivePlant.soil,
                        badgeText: 'Substrate',
                        color: Colors.brown,
                      ),
                      const SizedBox(height: 10),
                      CareInfoCard(
                        icon: Icons.alt_route_rounded,
                        title: 'Growth Habit',
                        description: effectivePlant.growthHabit,
                        badgeText: 'Form',
                        color: AppTheme.primaryGreen,
                      ),
                      const SizedBox(height: 18),

                      // Safety & Toxicity Box
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: effectivePlant.isPetSafe
                              ? Colors.green.shade50
                              : Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: effectivePlant.isPetSafe
                                ? Colors.green.shade200
                                : Colors.amber.shade300,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              effectivePlant.isPetSafe
                                  ? Icons.pets
                                  : Icons.warning_amber_rounded,
                              color: effectivePlant.isPetSafe
                                  ? AppTheme.primaryGreen
                                  : Colors.orange.shade800,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    effectivePlant.isPetSafe
                                        ? 'Pet Friendly Plant'
                                        : 'Toxicity & Pet Safety Notice',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: effectivePlant.isPetSafe
                                          ? AppTheme.darkGreen
                                          : Colors.orange.shade900,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    effectivePlant.toxicityNotes,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.textColor,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Gardening Tip Box
=======
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
                          category,
                          style: const TextStyle(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkGreen,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bring more greenery into your space!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
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
                        description: sunlight,
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 12),
                      _CareCard(
                        icon: Icons.water_drop_outlined,
                        title: 'Watering',
                        description: watering,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 24),

>>>>>>> origin/main
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppTheme.lightGreen,
                          borderRadius: BorderRadius.circular(18),
                        ),
<<<<<<< HEAD
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.eco, color: AppTheme.primaryGreen),
                                SizedBox(width: 8),
                                Text(
                                  'Pro Gardening Tip',
                                  style: TextStyle(
                                    fontSize: 16,
=======
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.eco,
                                  color: AppTheme.primaryGreen,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Gardening Tip',
                                  style: TextStyle(
                                    fontSize: 18,
>>>>>>> origin/main
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.darkGreen,
                                  ),
                                ),
                              ],
                            ),
<<<<<<< HEAD
                            const SizedBox(height: 8),
                            Text(
                              effectivePlant.gardeningTip,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: AppTheme.textColor,
                              ),
=======
                            SizedBox(height: 10),
                            Text(
                              'Check the soil before watering. '
                              'Different plants need different amounts '
                              'of water, so avoid overwatering.',
                              style: TextStyle(fontSize: 15, height: 1.5),
>>>>>>> origin/main
                            ),
                          ],
                        ),
                      ),
<<<<<<< HEAD
                      const SizedBox(height: 28),

                      // Action Button: Add to garden / Manage garden
=======
                      const SizedBox(height: 24),

>>>>>>> origin/main
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () {
<<<<<<< HEAD
                            if (gardenState == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${effectivePlant.name} added to your garden!',
                                  ),
                                ),
                              );
                              return;
                            }

                            if (!isInGarden) {
                              _showAddToGardenDialog(
                                context,
                                gardenState,
                                effectivePlant,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${effectivePlant.name} is already in your garden. View My Garden tab to manage.',
                                  ),
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            isInGarden ? Icons.check : Icons.add_circle_outline,
                          ),
                          label: Text(
                            isInGarden
                                ? 'Already in My Garden'
                                : 'Add to My Garden',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: isInGarden
                                ? AppTheme.darkGreen
                                : AppTheme.primaryGreen,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
=======
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$name added to your garden!'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add to My Garden'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppTheme.primaryGreen,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
>>>>>>> origin/main
                            ),
                          ),
                        ),
                      ),
<<<<<<< HEAD
                      const SizedBox(height: 20),
=======
>>>>>>> origin/main
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
<<<<<<< HEAD

  void _showAddToGardenDialog(
    BuildContext context,
    GardenState gardenState,
    Plant plant,
  ) {
    final nicknameController = TextEditingController(text: plant.name);
    final locationController = TextEditingController(text: 'Living Room');
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text('Add ${plant.name} to Garden'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nicknameController,
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  hintText: 'e.g. Monty, Sunny',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location / Space',
                  hintText: 'e.g. Balcony, Desk, Bedroom',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: notesController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Care Notes (Optional)',
                  hintText: 'Special instructions or notes...',
                ),
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
              gardenState.addToGarden(
                plant: plant,
                nickname: nicknameController.text,
                location: locationController.text,
                notes: notesController.text,
              );
              Navigator.pop(dialogCtx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppTheme.primaryGreen,
                  content: Text(
                    'Added ${nicknameController.text.isNotEmpty ? nicknameController.text : plant.name} to My Garden! 🪴',
                  ),
                ),
              );
            },
            child: const Text('Add to Garden'),
=======
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
>>>>>>> origin/main
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/main
