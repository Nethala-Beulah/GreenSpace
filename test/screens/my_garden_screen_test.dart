import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greenspace/screens/my_garden_screen.dart';
import 'package:greenspace/services/garden_state.dart';

void main() {
  testWidgets(
    'MyGardenScreen renders garden items, filters, and logs watering',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      final gardenState = GardenState(seedDemoGarden: true);

      await tester.pumpWidget(
        MaterialApp(
          home: GardenStateScope(
            notifier: gardenState,
            child: const MyGardenScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('My Urban Garden 🪴'), findsOneWidget);
      expect(find.text('Monty the Monstera'), findsOneWidget);
      expect(find.text('Kitchen Basil'), findsOneWidget);

      // Verify filter pills
      expect(find.text('All (2)'), findsOneWidget);

      // Find and tap 'Water' button on Monty the Monstera
      final waterButtons = find.widgetWithText(FilledButton, 'Water');
      expect(waterButtons, findsWidgets);

      await tester.tap(waterButtons.first);
      await tester.pumpAndSettle();

      // Verify snackbar feedback
      expect(find.textContaining('Watered'), findsOneWidget);
    },
  );
}
