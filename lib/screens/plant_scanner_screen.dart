import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../services/garden_state.dart';
import '../theme/app_theme.dart';
import 'plant_details_screen.dart';

class PlantScannerScreen extends StatefulWidget {
  const PlantScannerScreen({super.key});

  @override
  State<PlantScannerScreen> createState() => _PlantScannerScreenState();
}

class _PlantScannerScreenState extends State<PlantScannerScreen> {
  int _selectedPresetIndex = 0;
  bool _isAnalyzing = false;
  bool _hasAnalyzed = false;

  final List<Map<String, dynamic>> _presetSamples = [
    {
      'title': 'Fenestrated Leaf',
      'label': 'Monstera Specimen',
      'imageUrl':
          'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?w=600',
      'matchedPlantId': 'monstera',
      'confidence': 95,
      'alternatives': ['Split-Leaf Philodendron (78%)', 'Epipremnum (58%)'],
    },
    {
      'title': 'Aromatic Herb',
      'label': 'Sweet Basil Sprig',
      'imageUrl':
          'https://images.unsplash.com/photo-1618164436241-4473940d1f5c?w=600',
      'matchedPlantId': 'basil',
      'confidence': 92,
      'alternatives': ['Thai Basil (81%)', 'Mint (62%)'],
    },
    {
      'title': 'Sword-like Succulent',
      'label': 'Snake Plant Specimen',
      'imageUrl':
          'https://images.unsplash.com/photo-1593482892290-f54927ae1bb6?w=600',
      'matchedPlantId': 'snake_plant',
      'confidence': 96,
      'alternatives': ['Sansevieria Cylindrica (74%)', 'Agave (61%)'],
    },
    {
      'title': 'Fragrant Bloom',
      'label': 'Lavender Cluster',
      'imageUrl':
          'https://images.unsplash.com/photo-1499002238440-d264edd596ec?w=600',
      'matchedPlantId': 'lavender',
      'confidence': 89,
      'alternatives': ['Russian Sage (77%)', 'Hyssop (65%)'],
    },
    {
      'title': 'Unidentified Wild Foliage',
      'label': 'Unknown Garden Weed',
      'imageUrl':
          'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?w=600',
      'matchedPlantId': null,
      'confidence': 41,
      'alternatives': ['Wild Sorrel (41%)', 'Woodland Fern (38%)'],
    },
  ];

  Future<void> _runAnalysis() async {
    setState(() {
      _isAnalyzing = true;
      _hasAnalyzed = false;
    });

    // Realistic scanning simulation delay
    await Future.delayed(const Duration(milliseconds: 900));

    if (mounted) {
      setState(() {
        _isAnalyzing = false;
        _hasAnalyzed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final gardenState = GardenStateScope.maybeOf(context);
    final activeSample = _presetSamples[_selectedPresetIndex];
    final matchedId = activeSample['matchedPlantId'] as String?;
    final Plant? matchedPlant = matchedId != null
        ? gardenState?.findPlantById(matchedId)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plant ID & Scanner 🔍',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Identification Engine Disclaimer
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.lightGreen,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.primaryGreen,
                      size: 22,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Interactive botanical scanner demonstration. Match sample leaf images against catalog features with transparent confidence ratings.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.darkGreen,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Specimen Viewfinder Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 240,
                          width: double.infinity,
                          child: Image.network(
                            activeSample['imageUrl'] as String,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: AppTheme.lightGreen,
                                  child: const Icon(
                                    Icons.image_search,
                                    size: 80,
                                    color: AppTheme.primaryGreen,
                                  ),
                                ),
                          ),
                        ),
                        // Reticle Overlay
                        Container(
                          height: 240,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.6),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppTheme.primaryGreen,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        if (_isAnalyzing)
                          Container(
                            height: 240,
                            color: Colors.black.withValues(alpha: 0.5),
                            child: const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Extracting leaf features & venation...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activeSample['title'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  activeSample['label'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.mutedText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FilledButton.icon(
                            onPressed: _isAnalyzing ? null : _runAnalysis,
                            icon: const Icon(
                              Icons.center_focus_strong,
                              size: 18,
                            ),
                            label: const Text('Identify Plant'),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Specimen Selector Carousel
              const Text(
                'Select Specimen to Inspect:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppTheme.darkGreen,
                ),
              ),
              const SizedBox(height: 8),

              SizedBox(
                height: 72,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _presetSamples.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final item = _presetSamples[index];
                    final isSelected = _selectedPresetIndex == index;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedPresetIndex = index;
                          _hasAnalyzed = false;
                        });
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        width: 140,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.lightGreen
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.primaryGreen
                                : Colors.green.shade50,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item['imageUrl'] as String,
                                width: 38,
                                height: 38,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.grass, size: 28),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item['title'] as String,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? AppTheme.darkGreen
                                      : AppTheme.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Analysis Results Section
              if (_hasAnalyzed) ...[
                const Text(
                  'Identification Results',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.darkGreen,
                  ),
                ),
                const SizedBox(height: 10),

                if (matchedPlant != null) ...[
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.green.shade100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.lightGreen,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${activeSample["confidence"]}% Match Confidence',
                                  style: const TextStyle(
                                    color: AppTheme.primaryGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                'Simulated Botanical Match',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.mutedText,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            matchedPlant.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.darkGreen,
                            ),
                          ),
                          Text(
                            matchedPlant.scientificName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: AppTheme.mutedText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            matchedPlant.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppTheme.textColor,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Alternative suggestions
                          const Text(
                            'Possible Close Matches:',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.mutedText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 6,
                            children:
                                (activeSample['alternatives'] as List<dynamic>)
                                    .map(
                                      (alt) => Chip(
                                        label: Text(
                                          alt.toString(),
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                        backgroundColor: AppTheme.background,
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                    )
                                    .toList(),
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PlantDetailsScreen(
                                              plant: matchedPlant,
                                              name: matchedPlant.name,
                                              category: matchedPlant.category,
                                              imageUrl: matchedPlant.imageUrl,
                                              sunlight: matchedPlant.sunlight,
                                              watering: matchedPlant.watering,
                                            ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.info_outline,
                                    size: 16,
                                  ),
                                  label: const Text('View Profile'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: () {
                                    if (gardenState != null) {
                                      gardenState.addToGarden(
                                        plant: matchedPlant,
                                        nickname: matchedPlant.name,
                                        location: 'Identified Specimen',
                                      );
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              AppTheme.primaryGreen,
                                          content: Text(
                                            'Added ${matchedPlant.name} to My Garden!',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.add, size: 16),
                                  label: const Text('Add to Garden'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  // Low confidence or unknown match
                  Card(
                    color: Colors.amber.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.amber.shade300),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.help_outline,
                                color: Colors.orange,
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Low Confidence Match (41%)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Visual characteristics could not definitively identify this specimen. Avoid pruning, ingesting, or harvesting unknown plants without verified expert confirmation.',
                            style: TextStyle(fontSize: 13, height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // CRITICAL SAFETY & TOXICITY WARNING (Prompt requirement 4.F)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: AppTheme.errorRed,
                        size: 26,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Crucial Safety & Edibility Notice',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppTheme.errorRed,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Never declare any plant safe to consume or touch based solely on automated image pattern matching. Many edible plants have lookalikes with severe toxicity. Always seek qualified botanical verification before ingesting any wild plant.',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.4,
                                color: AppTheme.textColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
