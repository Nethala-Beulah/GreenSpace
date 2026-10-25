import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../services/garden_state.dart';
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
  String _selectedDifficulty = 'All';

  final List<String> _categories = ['All', 'Indoor', 'Outdoor', 'Herbs'];

  final List<String> _difficulties = ['All', 'Easy', 'Moderate', 'Advanced'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Plants 🌿',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Input with Clear Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
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
                ),
              ),
            ),

            // Category Chips
            SizedBox(
              height: 44,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
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
                      color: selected ? Colors.white : AppTheme.darkGreen,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    side: BorderSide(
                      color: selected
                          ? AppTheme.primaryGreen
                          : Colors.green.shade100,
                    ),
                  );
                },
              ),
            ),

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
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

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
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredPlants.length,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
