import 'package:flutter_test/flutter_test.dart';

import 'package:before_go/main.dart';

void main() {
  testWidgets('App starts on the welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(const BeforeGoApp());

    expect(find.text('Welcome'), findsOneWidget);
  });

  testWidgets('Log in opens the tabs with the bottom bar', (WidgetTester tester) async {
    await tester.pumpWidget(const BeforeGoApp());

    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('Checklists'), findsOneWidget);
    expect(find.text('Settings'), findsWidgets);
  });
}
