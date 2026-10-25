<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greenspace/main.dart';
import 'package:greenspace/services/garden_state.dart';

void main() {
  testWidgets('GreenSpaceApp launches and renders Home screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    final testGardenState = GardenState(seedDemoGarden: true);

    await tester.pumpWidget(GreenSpaceApp(gardenState: testGardenState));
    await tester.pumpAndSettle();

    // Verify app title and greeting exist
    expect(find.text('GreenSpace'), findsOneWidget);
    expect(find.text('Hello, Gardener! 👋'), findsOneWidget);
    expect(find.text('Your Garden'), findsOneWidget);
    expect(find.text('Popular Plants'), findsOneWidget);
    expect(find.text('Gardening Tip 🌱'), findsOneWidget);
  });

  testWidgets('Bottom navigation switches between screens smoothly', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    final testGardenState = GardenState(seedDemoGarden: true);

    await tester.pumpWidget(GreenSpaceApp(gardenState: testGardenState));
    await tester.pumpAndSettle();

    // Tap Explore destination in NavigationBar
    await tester.tap(find.byIcon(Icons.search_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Explore Plants 🌿'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Tap My Garden destination in NavigationBar
    await tester.tap(find.byIcon(Icons.yard_outlined));
    await tester.pumpAndSettle();

    expect(find.text('My Urban Garden 🪴'), findsOneWidget);

    // Tap Scan & ID destination in NavigationBar
    await tester.tap(find.byIcon(Icons.center_focus_weak_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Plant ID & Scanner 🔍'), findsOneWidget);
=======
// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:greenspace/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
>>>>>>> origin/main
  });
}
