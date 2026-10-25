import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greenspace/widgets/care_info_card.dart';

void main() {
  testWidgets('CareInfoCard renders title, description, and badge', (
    WidgetTester tester,
  ) async {
    var wasTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CareInfoCard(
            icon: Icons.wb_sunny_outlined,
            title: 'Sunlight',
            description: 'Filtered bright light',
            badgeText: 'Exposure',
            color: Colors.orange,
            onTap: () => wasTapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Sunlight'), findsOneWidget);
    expect(find.text('Filtered bright light'), findsOneWidget);
    expect(find.text('Exposure'), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny_outlined), findsOneWidget);

    await tester.tap(find.byType(CareInfoCard));
    expect(wasTapped, true);
  });
}
