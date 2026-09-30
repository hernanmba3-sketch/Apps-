import 'package:flutter_test/flutter_test.dart';
import 'package:carrefour_app/main.dart';

void main() {
  testWidgets('Carrefour categories are displayed', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CarrefourApp());

    // Verify that categories appear.
    expect(find.text('Promotions'), findsOneWidget);
    expect(find.text('Household'), findsOneWidget);
    expect(find.text('Food'), findsOneWidget);
    expect(find.text('Electronics'), findsOneWidget);
  });
}
