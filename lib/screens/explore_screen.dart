import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlants = _plants.where((plant) {
      final matchesSearch = plant['name']!
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());

      final matchesCategory = _selectedCategory == 'All' ||
          plant['category'] == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Plants 🌿',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search plants...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: 8),
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
                      color:
                          selected ? Colors.white : AppTheme.darkGreen,
                      fontWeight: FontWeight.w600,
                    ),
                    side: BorderSide.none,
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  final columns = width >= 1000
                      ? 4
                      : width >= 650
                          ? 3
                          : 2;

                  if (filteredPlants.isEmpty) {
                    return const Center(
                      child: Text('No plants found 🌱'),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredPlants.length,
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlantDetailsScreen(
                                name: plant['name']!,
                                category: plant['category']!,
                                imageUrl: plant['image']!,
                                sunlight: plant['sunlight']!,
                                watering: plant['watering']!,
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