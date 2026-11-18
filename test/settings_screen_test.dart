import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:before_go/models/dummy_data.dart';
import 'package:before_go/screens/settings_screen.dart';
import 'package:before_go/utils/app_theme.dart';

Future<void> pumpSettings(WidgetTester tester) async {
  // Settings changes the shared city list, so put it back after each test.
  final originalCities = List.of(savedCities);
  final originalDefault = defaultCity;
  addTearDown(() {
    savedCities
      ..clear()
      ..addAll(originalCities);
    defaultCity = originalDefault;
  });

  await tester.pumpWidget(
    MaterialApp(theme: AppTheme.light, home: const SettingsScreen()),
  );
  await tester.pumpAndSettle();
}

Future<void> openAddCityDialog(WidgetTester tester) async {
  await tester.tap(find.text('Add city'));
  await tester.pumpAndSettle();
}

Future<void> submitCity(WidgetTester tester, String name) async {
  await tester.enterText(find.byType(TextFormField), name);
  await tester.tap(find.widgetWithText(TextButton, 'Add'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Settings lists the saved cities and marks the default', (tester) async {
    await pumpSettings(tester);

    for (final city in savedCities) {
      expect(find.text(city), findsOneWidget);
    }
    expect(find.text('Default'), findsOneWidget);
    expect(find.text('Signed in as $dummyUserEmail'), findsOneWidget);
  });

  testWidgets('Adding a city with an empty name shows an error', (tester) async {
    await pumpSettings(tester);
    await openAddCityDialog(tester);

    await submitCity(tester, '   ');

    expect(find.text('Please enter a city name'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('Adding a city that is already saved shows an error', (tester) async {
    await pumpSettings(tester);
    await openAddCityDialog(tester);

    await submitCity(tester, 'istanbul');

    expect(find.text('This city is already saved'), findsOneWidget);
  });

  testWidgets('A valid city is added to the list', (tester) async {
    await pumpSettings(tester);
    await openAddCityDialog(tester);

    await submitCity(tester, 'Izmir');

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Izmir'), findsOneWidget);
    expect(savedCities, contains('Izmir'));
  });

  testWidgets('Tapping a city makes it the default', (tester) async {
    await pumpSettings(tester);

    await tester.tap(find.text('Ankara'));
    await tester.pumpAndSettle();

    expect(defaultCity, 'Ankara');
  });

  testWidgets('Removing the default city moves the default to the next city',
      (tester) async {
    await pumpSettings(tester);

    await tester.tap(find.byTooltip('Remove Istanbul'));
    await tester.pumpAndSettle();

    expect(find.text('Istanbul'), findsNothing);
    expect(defaultCity, savedCities.first);
  });

  testWidgets('Log out asks for confirmation first', (tester) async {
    await pumpSettings(tester);

    // The button is below the fold, so scroll until the list builds it.
    await tester.scrollUntilVisible(
      find.text('Log out'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();

    expect(find.text('Log out?'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Log out?'), findsNothing);
  });

  for (final size in const [Size(360, 640), Size(412, 915)]) {
    testWidgets('Settings has no overflow at ${size.width.toInt()}x${size.height.toInt()}',
        (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await pumpSettings(tester);

      expect(tester.takeException(), isNull);
    });
  }
}
