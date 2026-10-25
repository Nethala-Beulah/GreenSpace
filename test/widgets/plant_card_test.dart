import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greenspace/widgets/plant_card.dart';

void main() {
  testWidgets('PlantCard displays attributes and handles tap callbacks', (
    WidgetTester tester,
  ) async {
    var cardTapped = false;
    var favTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlantCard(
            name: 'Monstera Deliciosa',
            scientificName: 'Monstera deliciosa',
            category: 'Indoor',
            imageUrl: '',
            sunlight: 'Bright indirect',
            watering: 'Every 7 days',
            isPetSafe: true,
            isFavorite: false,
            onTap: () => cardTapped = true,
            onFavoriteToggle: () => favTapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Monstera Deliciosa'), findsOneWidget);
    expect(find.text('Monstera deliciosa'), findsOneWidget);
    expect(find.text('Indoor'), findsOneWidget);
    expect(find.text('Bright indirect'), findsOneWidget);
    expect(find.text('Every 7 days'), findsOneWidget);
    expect(find.text('Pet safe'), findsOneWidget);

    await tester.tap(find.text('Monstera Deliciosa'));
    expect(cardTapped, true);

    await tester.tap(find.byIcon(Icons.favorite_border));
    expect(favTapped, true);
  });
}
