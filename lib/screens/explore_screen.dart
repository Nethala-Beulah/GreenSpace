import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../models/plant.dart';
import '../services/garden_state.dart';
=======
>>>>>>> origin/main
import '../theme/app_theme.dart';
import '../widgets/plant_card.dart';
import 'plant_details_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedCategory = 'All';
<<<<<<< HEAD
  String _selectedDifficulty = 'All';

  final List<String> _categories = ['All', 'Indoor', 'Outdoor', 'Herbs'];

  final List<String> _difficulties = ['All', 'Easy', 'Moderate', 'Advanced'];
=======

  final List<Map<String, String>> _plants = [
    {
      'name': 'Monstera',
      'category': 'Indoor',
      'image':
          'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?w=600',
      'sunlight': 'Indirect light',
      'watering': 'Every 7 days',
    },
    {
      'name': 'Snake Plant',
      'category': 'Indoor',
      'image':
          'https://images.unsplash.com/photo-1593482892290-f54927ae1bb6?w=600',
      'sunlight': 'Low to bright',
      'watering': 'Every 2 weeks',
    },
    {
      'name': 'Basil',
      'category': 'Herbs',
      'image':
          'https://images.unsplash.com/photo-1618164436241-4473940d1f5c?w=600',
      'sunlight': 'Full sunlight',
      'watering': 'Every 2 days',
    },
    {
      'name': 'Lavender',
      'category': 'Outdoor',
      'image':
          'https://images.unsplash.com/photo-1499002238440-d264edd596ec?w=600',
      'sunlight': 'Full sunlight',
      'watering': 'Every 3 days',
    },
    {
      'name': 'Aloe Vera',
      'category': 'Indoor',
      'image':
          'https://images.unsplash.com/photo-1509423350716-97f9360b4e09?w=600',
      'sunlight': 'Bright indirect',
      'watering': 'Every 2 weeks',
    },
    {
      'name': 'Rosemary',
      'category': 'Herbs',
      'image':
          'https://images.unsplash.com/photo-1515586000433-45406d8e6662?w=600',
      'sunlight': 'Full sunlight',
      'watering': 'Every 5 days',
    },
    {
      'name': 'Fern',
      'category': 'Outdoor',
      'image':
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=600',
      'sunlight': 'Partial shade',
      'watering': 'Keep soil moist',
    },
    {
      'name': 'Peace Lily',
      'category': 'Indoor',
      'image':
          'https://images.unsplash.com/photo-1593691509543-c55fb32e5cee?w=600',
      'sunlight': 'Indirect light',
      'watering': 'Every 5 days',
    },
  ];

  final List<String> _categories = [
    'All',
    'Indoor',
    'Outdoor',
    'Herbs',
  ];
>>>>>>> origin/main

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

<<<<<<< HEAD
  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedCategory = 'All';
      _selectedDifficulty = 'All';
    });
  }

  @override
  Widget build(BuildContext context) {
    final gardenState = GardenStateScope.maybeOf(context);
    final List<Plant> sourcePlants = gardenState?.catalog ?? [];

    final query = _searchController.text.trim().toLowerCase();

    final filteredPlants = sourcePlants.where((plant) {
      final matchesSearch =
          query.isEmpty ||
          plant.name.toLowerCase().contains(query) ||
          plant.scientificName.toLowerCase().contains(query) ||
          plant.category.toLowerCase().contains(query) ||
          plant.description.toLowerCase().contains(query);

      final matchesCategory =
          _selectedCategory == 'All' ||
          plant.category.toLowerCase() == _selectedCategory.toLowerCase();

      final matchesDifficulty =
          _selectedDifficulty == 'All' ||
          plant.difficulty.toLowerCase() == _selectedDifficulty.toLowerCase();

      return matchesSearch && matchesCategory && matchesDifficulty;
=======
  @override
  Widget build(BuildContext context) {
    final filteredPlants = _plants.where((plant) {
      final matchesSearch = plant['name']!
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());

      final matchesCategory = _selectedCategory == 'All' ||
          plant['category'] == _selectedCategory;

      return matchesSearch && matchesCategory;
>>>>>>> origin/main
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Plants 🌿',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
<<<<<<< HEAD
        actions: [
          if (query.isNotEmpty ||
              _selectedCategory != 'All' ||
              _selectedDifficulty != 'All')
            IconButton(
              tooltip: 'Reset filters',
              icon: const Icon(Icons.filter_alt_off),
              onPressed: _resetFilters,
            ),
          const SizedBox(width: 8),
        ],
=======
>>>>>>> origin/main
      ),
      body: SafeArea(
        child: Column(
          children: [
<<<<<<< HEAD
            // Search Input with Clear Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
=======
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
>>>>>>> origin/main
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
<<<<<<< HEAD
                  hintText: 'Search by name, category, or care...',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppTheme.primaryGreen,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
=======
                  hintText: 'Search plants...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
>>>>>>> origin/main
                ),
              ),
            ),

<<<<<<< HEAD
            // Category Chips
            SizedBox(
              height: 44,
=======
            SizedBox(
              height: 48,
>>>>>>> origin/main
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
<<<<<<< HEAD
                separatorBuilder: (_, __) => const SizedBox(width: 8),
=======
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 8),
>>>>>>> origin/main
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final selected = _selectedCategory == category;

                  return ChoiceChip(
                    label: Text(category),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor: AppTheme.primaryGreen,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
<<<<<<< HEAD
                      color: selected ? Colors.white : AppTheme.darkGreen,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    side: BorderSide(
                      color: selected
                          ? AppTheme.primaryGreen
                          : Colors.green.shade100,
                    ),
=======
                      color:
                          selected ? Colors.white : AppTheme.darkGreen,
                      fontWeight: FontWeight.w600,
                    ),
                    side: BorderSide.none,
>>>>>>> origin/main
                  );
                },
              ),
            ),

<<<<<<< HEAD
            const SizedBox(height: 6),

            // Difficulty Chips
            SizedBox(
              height: 38,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _difficulties.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final difficulty = _difficulties[index];
                  final selected = _selectedDifficulty == difficulty;

                  return FilterChip(
                    label: Text(
                      difficulty == 'All' ? 'All Levels' : difficulty,
                      style: TextStyle(
                        fontSize: 12,
                        color: selected ? Colors.white : AppTheme.textColor,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        _selectedDifficulty = difficulty;
                      });
                    },
                    selectedColor: AppTheme.darkGreen,
                    backgroundColor: Colors.white,
                    showCheckmark: false,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    side: BorderSide(
                      color: selected
                          ? AppTheme.darkGreen
                          : Colors.grey.shade300,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Plant Grid
=======
            const SizedBox(height: 12),

>>>>>>> origin/main
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

<<<<<<< HEAD
                  final columns = width >= 1100
                      ? 4
                      : width >= 720
                      ? 3
                      : 2;

                  if (filteredPlants.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off_rounded,
                              size: 64,
                              color: AppTheme.primaryGreen,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No plants found 🌱',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.darkGreen,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Try adjusting your search keywords or filter selections.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppTheme.mutedText,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            FilledButton.tonal(
                              onPressed: _resetFilters,
                              child: const Text('Reset All Filters'),
                            ),
                          ],
                        ),
                      ),
=======
                  final columns = width >= 1000
                      ? 4
                      : width >= 650
                          ? 3
                          : 2;

                  if (filteredPlants.isEmpty) {
                    return const Center(
                      child: Text('No plants found 🌱'),
>>>>>>> origin/main
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredPlants.length,
<<<<<<< HEAD
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final plant = filteredPlants[index];
                      final isFav = gardenState?.isFavorite(plant.id) ?? false;

                      return PlantCard(
                        name: plant.name,
                        scientificName: plant.scientificName,
                        category: plant.category,
                        imageUrl: plant.imageUrl,
                        sunlight: plant.sunlight,
                        watering: plant.watering,
                        difficulty: plant.difficulty,
                        isPetSafe: plant.isPetSafe,
                        isFavorite: isFav,
                        onFavoriteToggle: gardenState != null
                            ? () => gardenState.toggleFavorite(plant.id)
                            : null,
=======
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (context, index) {
                      final plant = filteredPlants[index];

                      return PlantCard(
                        name: plant['name']!,
                        category: plant['category']!,
                        imageUrl: plant['image']!,
                        sunlight: plant['sunlight']!,
                        watering: plant['watering']!,
>>>>>>> origin/main
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
<<<<<<< HEAD
                              builder: (context) => PlantDetailsScreen(
                                plant: plant,
                                name: plant.name,
                                category: plant.category,
                                imageUrl: plant.imageUrl,
                                sunlight: plant.sunlight,
                                watering: plant.watering,
=======
                              builder: (context) =>
                                  PlantDetailsScreen(
                                name: plant['name']!,
                                category: plant['category']!,
                                imageUrl: plant['image']!,
                                sunlight: plant['sunlight']!,
                                watering: plant['watering']!,
>>>>>>> origin/main
                              ),
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
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/main
