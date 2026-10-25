import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../models/plant.dart';
import '../services/garden_state.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';
import 'explore_screen.dart';
import 'my_garden_screen.dart';
import 'plant_details_screen.dart';
import 'plant_scanner_screen.dart';
=======
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';
>>>>>>> origin/main

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final gardenState = GardenStateScope.maybeOf(context);

    final totalPlants = gardenState?.totalPlantsInGarden ?? 0;
    final dueCount = gardenState?.wateringRemindersDueCount ?? 0;
    final favoritesCount = gardenState?.favoriteIds.length ?? 0;

    // Pick 4 popular plants from catalog for recommendations
    final popularPlants = (gardenState?.catalog ?? []).take(5).toList();

=======
>>>>>>> origin/main
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.eco, color: AppTheme.primaryGreen, size: 30),
            SizedBox(width: 8),
<<<<<<< HEAD
            Text('GreenSpace', style: TextStyle(fontWeight: FontWeight.bold)),
=======
            Text(
              'GreenSpace',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
>>>>>>> origin/main
          ],
        ),
        actions: [
          IconButton(
<<<<<<< HEAD
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    dueCount > 0
                        ? '🌱 Reminder: $dueCount plants need watering today!'
                        : '🌱 All plants are well cared for!',
                  ),
                ),
              );
            },
            tooltip: 'Notifications',
            icon: Badge(
              isLabelVisible: dueCount > 0,
              label: Text('$dueCount'),
              child: const Icon(Icons.notifications_none_rounded),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: AppTheme.lightGreen,
              child: IconButton(
                iconSize: 20,
                tooltip: 'Plant Scanner & ID',
                icon: const Icon(
                  Icons.center_focus_strong,
                  color: AppTheme.primaryGreen,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlantScannerScreen(),
                    ),
                  );
                },
              ),
=======
            onPressed: () {},
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: AppTheme.lightGreen,
              child: Icon(Icons.person, color: AppTheme.primaryGreen),
>>>>>>> origin/main
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 32 : 20,
                  vertical: 16,
                ),
                children: [
                  const Text(
                    'Hello, Gardener! 👋',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkGreen,
                    ),
                  ),
<<<<<<< HEAD
                  const SizedBox(height: 6),
=======
                  const SizedBox(height: 8),
>>>>>>> origin/main
                  const Text(
                    'Let’s make your space a little greener.',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
<<<<<<< HEAD
                  const SizedBox(height: 20),
=======
                  const SizedBox(height: 24),
>>>>>>> origin/main

                  // Hero banner
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
<<<<<<< HEAD
                        colors: [AppTheme.primaryGreen, AppTheme.darkGreen],
=======
                        colors: [
                          AppTheme.primaryGreen,
                          AppTheme.darkGreen,
                        ],
>>>>>>> origin/main
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
<<<<<<< HEAD
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryGreen.withValues(alpha: 0.25),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: isWide
                        ? Row(
                            children: [
                              Expanded(
                                child: _HeroText(
                                  onExploreTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ExploreScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Text('🪴', style: TextStyle(fontSize: 90)),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('🌿', style: TextStyle(fontSize: 55)),
                              const SizedBox(height: 12),
                              _HeroText(
                                onExploreTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ExploreScreen(),
                                    ),
                                  );
                                },
                              ),
=======
                    ),
                    child: isWide
                        ? const Row(
                            children: [
                              Expanded(child: _HeroText()),
                              SizedBox(width: 20),
                              Text('🪴', style: TextStyle(fontSize: 90)),
                            ],
                          )
                        : const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('🌿', style: TextStyle(fontSize: 55)),
                              SizedBox(height: 12),
                              _HeroText(),
>>>>>>> origin/main
                            ],
                          ),
                  ),

<<<<<<< HEAD
                  const SizedBox(height: 24),

                  // Quick Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _QuickActionButton(
                          icon: Icons.search,
                          label: 'Explore',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ExploreScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _QuickActionButton(
                          icon: Icons.yard_outlined,
                          label: 'My Garden',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyGardenScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _QuickActionButton(
                          icon: Icons.center_focus_strong,
                          label: 'Scan & ID',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PlantScannerScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  SectionHeader(
                    title: 'Your Garden',
                    actionText: 'Manage',
                    onActionTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyGardenScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // Dynamic summary cards
                  LayoutBuilder(
                    builder: (context, cardConstraints) {
                      final columns = cardConstraints.maxWidth >= 600 ? 3 : 2;
=======
                  const SizedBox(height: 28),

                  const SectionHeader(title: 'Your Garden'),
                  const SizedBox(height: 12),

                  // Summary cards
                  LayoutBuilder(
                    builder: (context, cardConstraints) {
                      final columns =
                          cardConstraints.maxWidth >= 600 ? 3 : 2;
>>>>>>> origin/main

                      return GridView.count(
                        crossAxisCount: columns,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: isWide ? 1.8 : 1.25,
<<<<<<< HEAD
                        children: [
                          _SummaryCard(
                            icon: Icons.yard_outlined,
                            title: 'My Plants',
                            value:
                                '$totalPlants ${totalPlants == 1 ? "plant" : "plants"}',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyGardenScreen(),
                                ),
                              );
                            },
=======
                        children: const [
                          _SummaryCard(
                            icon: Icons.yard_outlined,
                            title: 'My Plants',
                            value: '0 plants',
>>>>>>> origin/main
                          ),
                          _SummaryCard(
                            icon: Icons.water_drop_outlined,
                            title: 'Watering',
<<<<<<< HEAD
                            value: dueCount > 0
                                ? '$dueCount due today!'
                                : 'All hydrated',
                            iconColor: dueCount > 0
                                ? Colors.orange
                                : Colors.blue,
                            valueColor: dueCount > 0
                                ? Colors.orange.shade800
                                : null,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyGardenScreen(),
                                ),
                              );
                            },
                          ),
                          _SummaryCard(
                            icon: Icons.favorite_border,
                            title: 'Favorites',
                            value: '$favoritesCount saved',
                            iconColor: Colors.pink,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ExploreScreen(),
                                ),
                              );
                            },
=======
                            value: '0 reminders',
                          ),
                          _SummaryCard(
                            icon: Icons.favorite_border,
                            title: 'Plant Care',
                            value: 'Grow daily',
>>>>>>> origin/main
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  SectionHeader(
                    title: 'Popular Plants',
<<<<<<< HEAD
                    actionText: 'See all',
                    onActionTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExploreScreen(),
=======
                    onActionTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Explore screen coming soon!'),
>>>>>>> origin/main
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

<<<<<<< HEAD
                  // Popular Plants horizontal carousel with real plant data
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularPlants.length,
                      itemBuilder: (context, index) {
                        final plant = popularPlants[index];
                        return _PopularPlantCard(
                          plant: plant,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlantDetailsScreen(
                                  plant: plant,
                                  name: plant.name,
                                  category: plant.category,
                                  imageUrl: plant.imageUrl,
                                  sunlight: plant.sunlight,
                                  watering: plant.watering,
                                ),
                              ),
                            );
                          },
                        );
                      },
=======
                  SizedBox(
                    height: 175,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        _PopularPlant(
                          emoji: '🌵',
                          name: 'Aloe Vera',
                          subtitle: 'Easy care',
                        ),
                        _PopularPlant(
                          emoji: '🌻',
                          name: 'Sunflower',
                          subtitle: 'Loves sunlight',
                        ),
                        _PopularPlant(
                          emoji: '🌿',
                          name: 'Tulsi',
                          subtitle: 'Aromatic herb',
                        ),
                        _PopularPlant(
                          emoji: '🌹',
                          name: 'Rose',
                          subtitle: 'Flowering plant',
                        ),
                      ],
>>>>>>> origin/main
                    ),
                  ),

                  const SizedBox(height: 28),

                  const SectionHeader(title: 'Gardening Tip 🌱'),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGreen,
                      borderRadius: BorderRadius.circular(20),
<<<<<<< HEAD
                      border: Border.all(color: Colors.green.shade100),
=======
>>>>>>> origin/main
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: AppTheme.primaryGreen,
                          size: 30,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
<<<<<<< HEAD
                                'Check the soil moisture first!',
=======
                                'Every plant is different!',
>>>>>>> origin/main
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkGreen,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
<<<<<<< HEAD
                                'Push your finger about 2 inches into the soil. If it feels dry to the touch, your plant is ready for a thorough watering. If damp, wait another day.',
                                style: TextStyle(height: 1.5, fontSize: 13),
=======
                                'Check the soil before watering. Too much '
                                'water can harm some plants.',
                                style: TextStyle(height: 1.5),
>>>>>>> origin/main
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
<<<<<<< HEAD
                  const SizedBox(height: 28),
=======
                  const SizedBox(height: 20),
>>>>>>> origin/main
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
<<<<<<< HEAD
  final VoidCallback onExploreTap;

  const _HeroText({required this.onExploreTap});
=======
  const _HeroText();
>>>>>>> origin/main

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'GROW A GREENER LIFE',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Your little garden,\nyour happy place.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            height: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Discover plants and bring nature into your everyday life.',
          style: TextStyle(color: Colors.white70, height: 1.5),
        ),
        const SizedBox(height: 16),
        FilledButton(
<<<<<<< HEAD
          onPressed: onExploreTap,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.darkGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
=======
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('We will connect Explore Plants next!'),
              ),
            );
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.darkGreen,
>>>>>>> origin/main
          ),
          child: const Text('Explore Plants'),
        ),
      ],
    );
  }
}

<<<<<<< HEAD
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.shade50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryGreen, size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkGreen,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

=======
>>>>>>> origin/main
class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
<<<<<<< HEAD
  final Color? iconColor;
  final Color? valueColor;
  final VoidCallback? onTap;
=======
>>>>>>> origin/main

  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
<<<<<<< HEAD
    this.iconColor,
    this.valueColor,
    this.onTap,
=======
>>>>>>> origin/main
  });

  @override
  Widget build(BuildContext context) {
    return Container(
<<<<<<< HEAD
=======
      padding: const EdgeInsets.all(14),
>>>>>>> origin/main
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.green.shade50),
<<<<<<< HEAD
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor ?? AppTheme.primaryGreen, size: 27),
                const SizedBox(height: 10),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: valueColor ?? AppTheme.primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
=======
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppTheme.primaryGreen, size: 27),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.primaryGreen,
              fontSize: 13,
            ),
          ),
        ],
>>>>>>> origin/main
      ),
    );
  }
}

<<<<<<< HEAD
class _PopularPlantCard extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const _PopularPlantCard({required this.plant, required this.onTap});
=======
class _PopularPlant extends StatelessWidget {
  final String emoji;
  final String name;
  final String subtitle;

  const _PopularPlant({
    required this.emoji,
    required this.name,
    required this.subtitle,
  });
>>>>>>> origin/main

  @override
  Widget build(BuildContext context) {
    return Container(
<<<<<<< HEAD
      width: 155,
      margin: const EdgeInsets.only(right: 12),
=======
      width: 145,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
>>>>>>> origin/main
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade50),
      ),
<<<<<<< HEAD
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    plant.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppTheme.lightGreen,
                      child: const Center(
                        child: Icon(
                          Icons.local_florist,
                          color: AppTheme.primaryGreen,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        plant.category,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      plant.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppTheme.darkGreen,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      plant.watering,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
=======
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 42)),
          const Spacer(),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
>>>>>>> origin/main
