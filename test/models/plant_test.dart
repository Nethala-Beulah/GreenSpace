import 'package:flutter_test/flutter_test.dart';
import 'package:greenspace/models/plant.dart';

void main() {
  group('Plant Model Tests', () {
    test('creates Plant correctly and serializes to/from JSON', () {
      const plant = Plant(
        id: 'test_pothos',
        name: 'Golden Pothos',
        scientificName: 'Epipremnum aureum',
        category: 'Indoor',
        imageUrl: 'https://example.com/pothos.jpg',
        sunlight: 'Low to bright indirect',
        watering: 'Every 7 days',
        wateringIntervalDays: 7,
        soil: 'Standard potting mix',
        difficulty: 'Easy',
        description: 'Hardy trailing houseplant.',
        growthHabit: 'Trailing vine',
        isPetSafe: false,
        toxicityNotes: 'Toxic to pets.',
        gardeningTip: 'Prune for bushier growth.',
      );

      final json = plant.toJson();
      expect(json['id'], 'test_pothos');
      expect(json['name'], 'Golden Pothos');
      expect(json['wateringIntervalDays'], 7);

      final fromJson = Plant.fromJson(json);
      expect(fromJson.id, plant.id);
      expect(fromJson.name, plant.name);
      expect(fromJson.scientificName, plant.scientificName);
      expect(fromJson.isPetSafe, false);
    });

    test('copyWith updates specified fields', () {
      const plant = Plant(
        id: 'test_fern',
        name: 'Boston Fern',
        scientificName: 'Nephrolepis exaltata',
        category: 'Outdoor',
        imageUrl: '',
        sunlight: 'Partial shade',
        watering: 'Every 3 days',
        wateringIntervalDays: 3,
        soil: 'Loamy soil',
        difficulty: 'Moderate',
        description: 'Lush fronds.',
        growthHabit: 'Clump',
      );

      final updated = plant.copyWith(
        name: 'Super Fern',
        wateringIntervalDays: 4,
        isPetSafe: true,
      );

      expect(updated.name, 'Super Fern');
      expect(updated.wateringIntervalDays, 4);
      expect(updated.isPetSafe, true);
      expect(updated.id, 'test_fern');
    });
  });

  group('GardenPlant Model Tests', () {
    test('calculates nextWateringDate and isWateringDue accurately', () {
      const plant = Plant(
        id: 'mint',
        name: 'Mint',
        scientificName: 'Mentha',
        category: 'Herbs',
        imageUrl: '',
        sunlight: 'Sun',
        watering: 'Every 2 days',
        wateringIntervalDays: 2,
        soil: 'Moist soil',
        difficulty: 'Easy',
        description: 'Herbal plant',
        growthHabit: 'Spreading',
      );

      final fixedDate = DateTime(2026, 10, 20);
      final entry = GardenPlant(
        id: 'entry_1',
        plant: plant,
        nickname: 'My Mint',
        location: 'Balcony',
        dateAdded: fixedDate,
        lastWatered: fixedDate,
      );

      // 2 days interval -> next watering date is Oct 22
      expect(entry.nextWateringDate, DateTime(2026, 10, 22));

      // On Oct 21, 1 day remaining, not due
      expect(entry.daysUntilWatering(DateTime(2026, 10, 21)), 1);
      expect(entry.isWateringDue(DateTime(2026, 10, 21)), false);

      // On Oct 22, 0 days remaining, due!
      expect(entry.daysUntilWatering(DateTime(2026, 10, 22)), 0);
      expect(entry.isWateringDue(DateTime(2026, 10, 22)), true);

      // On Oct 23, overdue (-1 days)
      expect(entry.daysUntilWatering(DateTime(2026, 10, 23)), -1);
      expect(entry.isWateringDue(DateTime(2026, 10, 23)), true);
    });

    test('GardenPlant serializes to/from JSON', () {
      const plant = Plant(
        id: 'basil',
        name: 'Sweet Basil',
        scientificName: 'Ocimum basilicum',
        category: 'Herbs',
        imageUrl: '',
        sunlight: 'Full sun',
        watering: 'Every 2 days',
        wateringIntervalDays: 2,
        soil: 'Loamy',
        difficulty: 'Easy',
        description: 'Herb',
        growthHabit: 'Bush',
      );

      final entry = GardenPlant(
        id: 'gp_1',
        plant: plant,
        nickname: 'Kitchen Basil',
        location: 'Window',
        dateAdded: DateTime(2026, 10, 1),
        lastWatered: DateTime(2026, 10, 15),
        notes: 'Delicious in tomato sauce',
      );

      final json = entry.toJson();
      final revived = GardenPlant.fromJson(json);

      expect(revived.id, 'gp_1');
      expect(revived.nickname, 'Kitchen Basil');
      expect(revived.location, 'Window');
      expect(revived.plant.name, 'Sweet Basil');
      expect(revived.notes, 'Delicious in tomato sauce');
    });
  });
}
