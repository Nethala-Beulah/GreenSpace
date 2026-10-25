import 'package:flutter_test/flutter_test.dart';
import 'package:greenspace/models/plant.dart';
import 'package:greenspace/services/garden_state.dart';

void main() {
  group('GardenState Unit Tests', () {
    test('initializes with catalog and optional demo garden', () {
      final stateWithDemo = GardenState(seedDemoGarden: true);
      expect(stateWithDemo.catalog.isNotEmpty, true);
      expect(stateWithDemo.myGarden.length, 2);

      final emptyState = GardenState(seedDemoGarden: false);
      expect(emptyState.myGarden.isEmpty, true);
      expect(emptyState.catalog.isNotEmpty, true);
    });

    test('adds plant to garden and notifies listeners', () {
      final state = GardenState(seedDemoGarden: false);
      var notificationCount = 0;
      state.addListener(() => notificationCount++);

      final plant = state.catalog.first;
      final entry = state.addToGarden(
        plant: plant,
        nickname: 'My Test Plant',
        location: 'Bedroom Shelf',
        notes: 'Thriving in indirect light',
      );

      expect(state.myGarden.length, 1);
      expect(state.isInGarden(plant.id), true);
      expect(entry.nickname, 'My Test Plant');
      expect(entry.location, 'Bedroom Shelf');
      expect(notificationCount, 1);
    });

    test('waters plant and updates timestamp', () {
      final state = GardenState(seedDemoGarden: true);
      final initialEntry = state.myGarden.first;
      final preWaterTimestamp = initialEntry.lastWatered;
      state.waterPlant(initialEntry.id);

      final updatedEntry = state.myGarden.firstWhere(
        (p) => p.id == initialEntry.id,
      );
      expect(updatedEntry.lastWatered.isAfter(preWaterTimestamp), true);
    });

    test('removes plant from garden', () {
      final state = GardenState(seedDemoGarden: true);
      expect(state.myGarden.length, 2);

      final idToRemove = state.myGarden.first.id;
      state.removeFromGarden(idToRemove);

      expect(state.myGarden.length, 1);
      expect(state.myGarden.any((p) => p.id == idToRemove), false);
    });

    test('toggles plant favorites', () {
      final state = GardenState(seedDemoGarden: false);
      const testId = 'fiddle_leaf_fig';

      expect(state.isFavorite(testId), false);

      state.toggleFavorite(testId);
      expect(state.isFavorite(testId), true);

      state.toggleFavorite(testId);
      expect(state.isFavorite(testId), false);
    });

    test('adds custom plant to catalog and finds it by ID', () {
      final state = GardenState(seedDemoGarden: false);
      const customPlant = Plant(
        id: 'bonsai_ficus',
        name: 'Ginseng Ficus Bonsai',
        scientificName: 'Ficus retusa',
        category: 'Indoor',
        imageUrl: '',
        sunlight: 'Bright indirect',
        watering: 'Every 5 days',
        wateringIntervalDays: 5,
        soil: 'Akadama bonsai mix',
        difficulty: 'Moderate',
        description: 'Compact miniature indoor tree.',
        growthHabit: 'Bonsai tree',
      );

      state.addCustomPlant(customPlant);
      expect(state.catalog.first.id, 'bonsai_ficus');

      final found = state.findPlantById('bonsai_ficus');
      expect(found?.name, 'Ginseng Ficus Bonsai');
    });
  });
}
