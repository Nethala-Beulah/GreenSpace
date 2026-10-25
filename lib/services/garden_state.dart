import 'package:flutter/material.dart';
import '../data/sample_plants.dart';
import '../models/plant.dart';

class GardenState extends ChangeNotifier {
  final List<Plant> _catalog = List.from(initialCatalog);
  final List<GardenPlant> _myGarden = [];
  final Set<String> _favoriteIds = {'monstera', 'basil'};

  GardenState({bool seedDemoGarden = true}) {
    if (seedDemoGarden) {
      _seedInitialGarden();
    }
  }

  void _seedInitialGarden() {
    final monstera = _catalog.firstWhere(
      (p) => p.id == 'monstera',
      orElse: () => _catalog.first,
    );
    final basil = _catalog.firstWhere(
      (p) => p.id == 'basil',
      orElse: () => _catalog[1],
    );

    final now = DateTime.now();

    _myGarden.addAll([
      GardenPlant(
        id: 'garden_1',
        plant: monstera,
        nickname: 'Monty the Monstera',
        location: 'Living Room Corner',
        dateAdded: now.subtract(const Duration(days: 30)),
        lastWatered: now.subtract(const Duration(days: 6)),
        notes: 'Needs misting twice a week; growing a new leaf!',
      ),
      GardenPlant(
        id: 'garden_2',
        plant: basil,
        nickname: 'Kitchen Basil',
        location: 'Sunny Kitchen Sill',
        dateAdded: now.subtract(const Duration(days: 14)),
        lastWatered: now.subtract(const Duration(days: 2)),
        notes: 'Pruned tips on Sunday for homemade pasta.',
      ),
    ]);
  }

  // Getters
  List<Plant> get catalog => List.unmodifiable(_catalog);
  List<GardenPlant> get myGarden => List.unmodifiable(_myGarden);
  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  int get totalPlantsInGarden => _myGarden.length;

  int get wateringRemindersDueCount =>
      _myGarden.where((gp) => gp.isWateringDue()).length;

  int get healthyCount => _myGarden.where((gp) => !gp.isWateringDue()).length;

  List<GardenPlant> get plantsDueForWatering =>
      _myGarden.where((gp) => gp.isWateringDue()).toList();

  bool isFavorite(String plantId) => _favoriteIds.contains(plantId);

  bool isInGarden(String plantId) =>
      _myGarden.any((gp) => gp.plant.id == plantId);

  GardenPlant? getGardenEntry(String plantId) {
    try {
      return _myGarden.firstWhere((gp) => gp.plant.id == plantId);
    } catch (_) {
      return null;
    }
  }

  // Actions
  void toggleFavorite(String plantId) {
    if (_favoriteIds.contains(plantId)) {
      _favoriteIds.remove(plantId);
    } else {
      _favoriteIds.add(plantId);
    }
    notifyListeners();
  }

  GardenPlant addToGarden({
    required Plant plant,
    String? nickname,
    String? location,
    String? notes,
  }) {
    final newEntry = GardenPlant(
      id: 'garden_${DateTime.now().millisecondsSinceEpoch}',
      plant: plant,
      nickname: (nickname != null && nickname.trim().isNotEmpty)
          ? nickname.trim()
          : plant.name,
      location: (location != null && location.trim().isNotEmpty)
          ? location.trim()
          : 'Home Garden',
      dateAdded: DateTime.now(),
      lastWatered: DateTime.now(),
      notes: notes ?? '',
    );

    _myGarden.insert(0, newEntry);
    notifyListeners();
    return newEntry;
  }

  void removeFromGarden(String gardenPlantId) {
    _myGarden.removeWhere((gp) => gp.id == gardenPlantId);
    notifyListeners();
  }

  void waterPlant(String gardenPlantId) {
    final index = _myGarden.indexWhere((gp) => gp.id == gardenPlantId);
    if (index != -1) {
      final existing = _myGarden[index];
      _myGarden[index] = existing.copyWith(lastWatered: DateTime.now());
      notifyListeners();
    }
  }

  void waterAllDuePlants() {
    final now = DateTime.now();
    for (int i = 0; i < _myGarden.length; i++) {
      if (_myGarden[i].isWateringDue()) {
        _myGarden[i] = _myGarden[i].copyWith(lastWatered: now);
      }
    }
    notifyListeners();
  }

  void updateGardenPlant({
    required String id,
    String? nickname,
    String? location,
    String? notes,
  }) {
    final index = _myGarden.indexWhere((gp) => gp.id == id);
    if (index != -1) {
      final existing = _myGarden[index];
      _myGarden[index] = existing.copyWith(
        nickname: nickname ?? existing.nickname,
        location: location ?? existing.location,
        notes: notes ?? existing.notes,
      );
      notifyListeners();
    }
  }

  void addCustomPlant(Plant plant) {
    _catalog.insert(0, plant);
    notifyListeners();
  }

  Plant? findPlantById(String id) {
    try {
      return _catalog.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}

class GardenStateScope extends InheritedNotifier<GardenState> {
  const GardenStateScope({
    super.key,
    required GardenState notifier,
    required super.child,
  }) : super(notifier: notifier);

  static GardenState of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<GardenStateScope>();
    assert(scope != null, 'No GardenStateScope found in context');
    return scope!.notifier!;
  }

  static GardenState? maybeOf(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<GardenStateScope>();
    return scope?.notifier;
  }
}
