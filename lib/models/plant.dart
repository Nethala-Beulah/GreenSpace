class Plant {
  final String id;
  final String name;
  final String scientificName;
  final String category;
  final String imageUrl;
  final String sunlight;
  final String watering;
  final int wateringIntervalDays;
  final String soil;
  final String difficulty;
  final String description;
  final String growthHabit;
  final bool isPetSafe;
  final String toxicityNotes;
  final String gardeningTip;

  const Plant({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.category,
    required this.imageUrl,
    required this.sunlight,
    required this.watering,
    required this.wateringIntervalDays,
    required this.soil,
    required this.difficulty,
    required this.description,
    required this.growthHabit,
    this.isPetSafe = false,
    this.toxicityNotes =
        'Keep away from pets and small children as a precaution.',
    this.gardeningTip = 'Check soil moisture before watering.',
  });

  Plant copyWith({
    String? id,
    String? name,
    String? scientificName,
    String? category,
    String? imageUrl,
    String? sunlight,
    String? watering,
    int? wateringIntervalDays,
    String? soil,
    String? difficulty,
    String? description,
    String? growthHabit,
    bool? isPetSafe,
    String? toxicityNotes,
    String? gardeningTip,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      sunlight: sunlight ?? this.sunlight,
      watering: watering ?? this.watering,
      wateringIntervalDays: wateringIntervalDays ?? this.wateringIntervalDays,
      soil: soil ?? this.soil,
      difficulty: difficulty ?? this.difficulty,
      description: description ?? this.description,
      growthHabit: growthHabit ?? this.growthHabit,
      isPetSafe: isPetSafe ?? this.isPetSafe,
      toxicityNotes: toxicityNotes ?? this.toxicityNotes,
      gardeningTip: gardeningTip ?? this.gardeningTip,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'scientificName': scientificName,
      'category': category,
      'imageUrl': imageUrl,
      'sunlight': sunlight,
      'watering': watering,
      'wateringIntervalDays': wateringIntervalDays,
      'soil': soil,
      'difficulty': difficulty,
      'description': description,
      'growthHabit': growthHabit,
      'isPetSafe': isPetSafe,
      'toxicityNotes': toxicityNotes,
      'gardeningTip': gardeningTip,
    };
  }

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      scientificName: json['scientificName'] as String? ?? '',
      category: json['category'] as String? ?? 'Indoor',
      imageUrl: json['imageUrl'] as String? ?? '',
      sunlight: json['sunlight'] as String? ?? 'Indirect light',
      watering: json['watering'] as String? ?? 'Moderate',
      wateringIntervalDays:
          (json['wateringIntervalDays'] as num?)?.toInt() ?? 7,
      soil: json['soil'] as String? ?? 'Well-draining potting mix',
      difficulty: json['difficulty'] as String? ?? 'Easy',
      description: json['description'] as String? ?? '',
      growthHabit: json['growthHabit'] as String? ?? 'Upright',
      isPetSafe: json['isPetSafe'] as bool? ?? false,
      toxicityNotes: json['toxicityNotes'] as String? ?? '',
      gardeningTip: json['gardeningTip'] as String? ?? '',
    );
  }
}

class GardenPlant {
  final String id;
  final Plant plant;
  final String nickname;
  final String location;
  final DateTime dateAdded;
  final DateTime lastWatered;
  final String notes;

  const GardenPlant({
    required this.id,
    required this.plant,
    required this.nickname,
    required this.location,
    required this.dateAdded,
    required this.lastWatered,
    this.notes = '',
  });

  DateTime get nextWateringDate =>
      lastWatered.add(Duration(days: plant.wateringIntervalDays));

  int daysUntilWatering([DateTime? currentDate]) {
    final now = currentDate ?? DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(
      nextWateringDate.year,
      nextWateringDate.month,
      nextWateringDate.day,
    );
    return target.difference(today).inDays;
  }

  bool isWateringDue([DateTime? currentDate]) {
    return daysUntilWatering(currentDate) <= 0;
  }

  GardenPlant copyWith({
    String? id,
    Plant? plant,
    String? nickname,
    String? location,
    DateTime? dateAdded,
    DateTime? lastWatered,
    String? notes,
  }) {
    return GardenPlant(
      id: id ?? this.id,
      plant: plant ?? this.plant,
      nickname: nickname ?? this.nickname,
      location: location ?? this.location,
      dateAdded: dateAdded ?? this.dateAdded,
      lastWatered: lastWatered ?? this.lastWatered,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plant': plant.toJson(),
      'nickname': nickname,
      'location': location,
      'dateAdded': dateAdded.toIso8601String(),
      'lastWatered': lastWatered.toIso8601String(),
      'notes': notes,
    };
  }

  factory GardenPlant.fromJson(Map<String, dynamic> json) {
    return GardenPlant(
      id: json['id'] as String,
      plant: Plant.fromJson(json['plant'] as Map<String, dynamic>),
      nickname: json['nickname'] as String? ?? '',
      location: json['location'] as String? ?? 'Home',
      dateAdded:
          DateTime.tryParse(json['dateAdded'] as String? ?? '') ??
          DateTime.now(),
      lastWatered:
          DateTime.tryParse(json['lastWatered'] as String? ?? '') ??
          DateTime.now(),
      notes: json['notes'] as String? ?? '',
    );
  }
}
