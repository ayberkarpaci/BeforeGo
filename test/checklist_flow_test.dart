import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:before_go/models/checklist.dart';
import 'package:before_go/models/dummy_data.dart';
import 'package:before_go/routes.dart';
import 'package:before_go/screens/main_shell.dart';
import 'package:before_go/utils/app_theme.dart';

final Checklist gym = dummyChecklists.firstWhere((c) => c.id == 'gym');
final Checklist trip = dummyChecklists.firstWhere((c) => c.id == 'weekend-trip');

/// Starts the app and opens [route] with [checklist] as the argument,
/// the same way the detail screen does.
Future<NavigatorState> openRoute(
  WidgetTester tester,
  String route,
  Checklist checklist,
) async {
  final navigatorKey = GlobalKey<NavigatorState>();
  await tester.pumpWidget(
    MaterialApp(
      navigatorKey: navigatorKey,
      theme: AppTheme.light,
      routes: AppRoutes.routes,
    ),
  );
  navigatorKey.currentState!.pushNamed(route, arguments: checklist);
  await tester.pumpAndSettle();
  return navigatorKey.currentState!;
}

void main() {
  testWidgets('Packing shows the checklist that was opened', (tester) async {
    await openRoute(tester, AppRoutes.packing, gym);

    expect(find.text('Packing · Gym'), findsOneWidget);
    expect(find.text('Towel'), findsOneWidget);
    expect(find.text('0 of ${gym.items.length} ready'), findsOneWidget);
  });

  testWidgets("I'm ready goes back to Home without a back arrow", (tester) async {
    final navigator = await openRoute(tester, AppRoutes.packing, gym);

    await tester.scrollUntilVisible(
      find.text("I'm ready"),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text("I'm ready"));
    await tester.pumpAndSettle();

    expect(find.byType(MainShell), findsOneWidget);
    expect(find.text('Have a good trip!'), findsOneWidget);
    expect(navigator.canPop(), isFalse);
  });

  testWidgets('Forgot Report shows the checklist that was opened', (tester) async {
    await openRoute(tester, AppRoutes.forgotReport, gym);

    expect(find.text('Gym · last session'), findsOneWidget);
    expect(find.text('Towel'), findsOneWidget);
  });

  testWidgets('Forgot Report asks for an item before saving', (tester) async {
    final navigator = await openRoute(tester, AppRoutes.forgotReport, gym);

    await tester.scrollUntilVisible(
      find.text('Save'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Select an item or type one'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Umbrella');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Saved. Scores will update next session.'), findsOneWidget);
    expect(navigator.canPop(), isFalse);
  });

  testWidgets('Editing a checklist whose city was removed does not crash',
      (tester) async {
    savedCities.remove('Tekirdağ');
    addTearDown(() => savedCities.insert(1, 'Tekirdağ'));

    await openRoute(tester, AppRoutes.checklistForm, trip);

    expect(tester.takeException(), isNull);
    expect(find.text('Edit Checklist'), findsOneWidget);
    expect(find.text(defaultCity), findsOneWidget);
  });

  testWidgets('Saving an edited checklist says it was updated', (tester) async {
    await openRoute(tester, AppRoutes.checklistForm, gym);

    await tester.scrollUntilVisible(
      find.text('Save'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Checklist saved'), findsOneWidget);
    expect(find.text('"Gym" was updated with ${gym.items.length} items.'), findsOneWidget);
  });
}
