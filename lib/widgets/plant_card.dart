import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PlantCard extends StatelessWidget {
  final String name;
  final String category;
  final String imageUrl;
  final String sunlight;
  final String watering;
  final VoidCallback onTap;
<<<<<<< HEAD
  final String? scientificName;
  final String? difficulty;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final bool? isPetSafe;
=======
>>>>>>> origin/main

  const PlantCard({
    super.key,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.sunlight,
    required this.watering,
    required this.onTap,
<<<<<<< HEAD
    this.scientificName,
    this.difficulty,
    this.isFavorite = false,
    this.onFavoriteToggle,
    this.isPetSafe,
=======
>>>>>>> origin/main
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
<<<<<<< HEAD
        side: BorderSide(color: Colors.green.shade50, width: 1),
=======
>>>>>>> origin/main
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppTheme.lightGreen,
                        child: const Center(
                          child: Icon(
                            Icons.local_florist,
<<<<<<< HEAD
                            size: 48,
=======
                            size: 55,
>>>>>>> origin/main
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
<<<<<<< HEAD
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(16),
=======
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(20),
>>>>>>> origin/main
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: AppTheme.primaryGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
<<<<<<< HEAD
                  if (onFavoriteToggle != null)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Material(
                        color: Colors.white.withValues(alpha: 0.88),
                        shape: const CircleBorder(),
                        child: IconButton(
                          iconSize: 18,
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : AppTheme.darkGreen,
                          ),
                          onPressed: onFavoriteToggle,
                          tooltip: isFavorite
                              ? 'Remove from favorites'
                              : 'Add to favorites',
                        ),
                      ),
                    ),
                  if (isPetSafe != null && isPetSafe!)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.pets,
                              size: 10,
                              color: AppTheme.primaryGreen,
                            ),
                            SizedBox(width: 3),
                            Text(
                              'Pet safe',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
=======
>>>>>>> origin/main
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
<<<<<<< HEAD
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppTheme.darkGreen,
                          ),
                        ),
                        if (scientificName != null)
                          Text(
                            scientificName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                              color: AppTheme.mutedText,
                            ),
                          ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.wb_sunny_outlined,
                              size: 13,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                sunlight,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.water_drop_outlined,
                              size: 13,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                watering,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppTheme.textColor,
                                ),
                              ),
                            ),
                          ],
=======
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppTheme.darkGreen,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.wb_sunny_outlined,
                          size: 15,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            sunlight,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.water_drop_outlined,
                          size: 15,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            watering,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11),
                          ),
>>>>>>> origin/main
                        ),
                      ],
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
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/main
