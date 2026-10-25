import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greenspace/screens/plant_scanner_screen.dart';
import 'package:greenspace/services/garden_state.dart';

void main() {
  testWidgets('PlantScannerScreen runs simulation and displays safety notice', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    final gardenState = GardenState(seedDemoGarden: false);

    await tester.pumpWidget(
      MaterialApp(
        home: GardenStateScope(
          notifier: gardenState,
          child: const PlantScannerScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Plant ID & Scanner 🔍'), findsOneWidget);
    expect(find.text('Identify Plant'), findsOneWidget);
    expect(find.text('Select Specimen to Inspect:'), findsOneWidget);

    // Tap Identify Plant
    await tester.tap(find.text('Identify Plant'));
    await tester.pump(); // Start progress indicator

    // Advance clock past the simulation delay (900ms)
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Verify identification results and mandatory safety warning appear
    expect(find.text('Identification Results'), findsOneWidget);
    expect(find.text('Crucial Safety & Edibility Notice'), findsOneWidget);
    expect(find.text('View Profile'), findsOneWidget);
    expect(find.text('Add to Garden'), findsOneWidget);
  });
}
