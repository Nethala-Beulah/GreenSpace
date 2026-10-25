# GreenSpace — Plant Discovery & Urban Garden Management

GreenSpace is a modern, polished Flutter application designed to help novice and experienced gardeners discover houseplants, understand their precise botanical care requirements, and manage their personal urban garden with watering schedules and care logs.

---

## 🌟 Key Features

### 1. 🪴 Intelligent Urban Garden Management
- **Personal Garden Tracker**: Track houseplants in your living space with custom nicknames, locations (e.g., *Sunny Kitchen Sill*, *Balcony Corner*), and personal care notes.
- **Smart Watering Countdown**: Calculates upcoming watering schedules based on plant-specific watering intervals and last-watered timestamps.
- **One-Tap Watering**: Log plant watering with instant visual feedback and timestamp updates.
- **"Water All Due" Action**: Quickly hydrate all plants requiring attention today with a single tap.
- **Garden Status Filters**: Filter your collection by *All Plants*, *Thirsty (Needs Water Today)*, and *Hydrated*.
- **Full CRUD Support**: Add plants from the catalog, create custom urban plant entries, edit notes and locations, or remove plants.

### 2. 🔍 Plant Discovery & Advanced Search (Explore)
- **Comprehensive Botanical Catalog**: Rich dataset featuring popular indoor houseplants, herbs, succulents, and outdoor balcony greens.
- **Real-Time Search**: Search instantly across plant common names, scientific binomials, categories, and care attributes.
- **Multi-Factor Filtering**: Filter by category (*Indoor*, *Outdoor*, *Herbs*) and difficulty level (*Easy*, *Moderate*, *Advanced*).
- **Favorites & Bookmarks**: Save preferred plants for quick reference.
- **Responsive Adaptive Grid**: Optimized layout for smartphones, tablets, and wide desktop/web viewports.
- **Graceful Empty States**: Intuitive empty state with one-click filter reset.

### 3. 📖 In-Depth Plant Care Profiles
- **Botanical Specifications**: Displays common name, scientific name, description, difficulty rating, and growth habit.
- **Visual Care Cards**: Dedicated cards for Sunlight exposure, Watering frequency, Soil substrate, and Growth habit using the reusable `CareInfoCard`.
- **Pet Safety & Toxicity Alerts**: Prominent ASPCA-aligned warnings for pet-safe plants versus those containing toxic compounds (e.g., insoluble calcium oxalates).
- **Pro Gardening Tips**: Actionable practical advice for healthy foliage and proper moisture monitoring.
- **Direct Garden Integration**: Add any explored plant directly to your garden with custom nicknames and room placement.

### 4. 🔬 Plant ID Assistant & Scanner (Demonstration Engine)
- **Interactive Leaf Pattern Recognition**: Matches specimen photos against botanical catalog features.
- **Confidence Scoring & Alternatives**: Displays top match percentage along with potential lookalike species.
- **Critical Safety & Edibility Notice**: Explicit botanical disclaimer warning users never to consume or touch unknown wild flora based solely on visual pattern matching.

---

## 🏗️ Project Architecture & Structure

The codebase adheres to clean separation of concerns, null-safety, and reactive state management:

```
lib/
├── data/
│   └── sample_plants.dart         # Realistic botanical catalog dataset
├── models/
│   └── plant.dart                 # Plant & GardenPlant models, serialization, care interval logic
├── screens/
│   ├── explore_screen.dart        # Plant discovery with real-time search & filter chips
│   ├── home_screen.dart           # Dashboard with live garden stats, quick actions & tips
│   ├── main_navigation_shell.dart # Unified Material 3 NavigationBar shell
│   ├── my_garden_screen.dart      # Urban garden management, CRUD, watering logs & filters
│   ├── plant_details_screen.dart  # Detailed care guide, pet safety alerts, add-to-garden
│   └── plant_scanner_screen.dart  # Interactive plant ID simulation with safety warnings
├── services/
│   └── garden_state.dart          # Central ChangeNotifier & InheritedNotifier state provider
├── theme/
│   └── app_theme.dart             # Nature-inspired palette, typography & widget themes
├── widgets/
│   ├── care_info_card.dart        # Reusable care metric card with icon & badge
│   ├── plant_card.dart            # Standardized catalog plant card with network fallbacks
│   └── section_header.dart        # Section header with action button
└── main.dart                      # Application entry point with state injection & routes
```

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: version 3.22+ (verified on Flutter 3.47.8 / Dart 3.13.7).
- **Supported Targets**: Web (Chrome, Edge), Windows desktop, Android, iOS, macOS, Linux.

### Setup & Installation
1. Clone or open the workspace:
   ```bash
   cd GreenSpace-main
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the App
- Run on Web (Chrome):
  ```bash
  flutter run -d chrome
  ```
- Run on Windows Desktop:
  ```bash
  flutter run -d windows
  ```
- Run on Edge:
  ```bash
  flutter run -d edge
  ```

### Static Analysis & Code Formatting
- Check code formatting:
  ```bash
  dart format --output=none --set-exit-if-changed lib test
  ```
- Format all code:
  ```bash
  dart format lib test
  ```
- Run static analyzer:
  ```bash
  flutter analyze
  ```

### Running Automated Tests
- Run all unit and widget tests:
  ```bash
  flutter test
  ```

---

## 🔒 Configuration & Data Source Transparency

- **Data Source**: GreenSpace includes an embedded educational botanical dataset in `lib/data/sample_plants.dart`.
- **Plant Identification**: The scanner provides an interactive simulation demonstrating computer-vision matching principles against known catalog specimens. It does not require paid third-party cloud credentials.
- **Edibility & Toxicity Policy**: In accordance with botanical safety standards, the application explicitly disclaims wild plant edibility verification from automated image scans.

---

## 🧪 Testing Coverage

The automated test suite in `test/` covers:
- **`test/widget_test.dart`**: App launch smoke test and bottom navigation screen switching.
- **`test/models/plant_test.dart`**: Model serialization, deserialization, `copyWith`, watering countdown arithmetic, and due date calculations.
- **`test/services/garden_state_test.dart`**: Garden state CRUD, watering logs, favorites toggling, custom plant addition.
- **`test/widgets/care_info_card_test.dart`**: Component rendering, icon/badge styling, tap interactions.
- **`test/widgets/plant_card_test.dart`**: Attribute display, pet-friendly tags, favorite toggle callbacks, network image error fallbacks.
- **`test/screens/explore_screen_test.dart`**: Search query filtering, category chip selection, empty state reset flow.
- **`test/screens/my_garden_screen_test.dart`**: Garden listing, category filtering, one-tap watering feedback.
- **`test/screens/plant_scanner_test.dart`**: Specimen selection, simulated recognition scan, confidence output, and safety notice rendering.
