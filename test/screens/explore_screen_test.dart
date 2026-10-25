import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greenspace/screens/explore_screen.dart';
import 'package:greenspace/services/garden_state.dart';

void main() {
  testWidgets('ExploreScreen filters plants by search query and categories', (
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
          child: const ExploreScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify initial search bar and chips are present
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Monstera Deliciosa'), findsOneWidget);
    expect(find.text('Sweet Basil'), findsOneWidget);

    // Enter search query 'basil'
    await tester.enterText(find.byType(TextField), 'basil');
    await tester.pumpAndSettle();

    expect(find.text('Sweet Basil'), findsOneWidget);
    expect(find.text('Monstera Deliciosa'), findsNothing);

    // Clear search using suffix icon button
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pumpAndSettle();

    expect(find.text('Monstera Deliciosa'), findsOneWidget);

    // Enter search query that matches nothing
    await tester.enterText(find.byType(TextField), 'XYZNonExistentPlant');
    await tester.pumpAndSettle();

    expect(find.text('No plants found 🌱'), findsOneWidget);
    expect(find.text('Reset All Filters'), findsOneWidget);

    // Tap Reset All Filters
    await tester.tap(find.text('Reset All Filters'));
    await tester.pumpAndSettle();

    expect(find.text('Monstera Deliciosa'), findsOneWidget);
  });
}
