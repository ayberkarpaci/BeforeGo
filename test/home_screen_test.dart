import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:before_go/models/dummy_data.dart';
import 'package:before_go/screens/home_screen.dart';
import 'package:before_go/screens/main_shell.dart';
import 'package:before_go/utils/app_theme.dart';
import 'package:before_go/widgets/checklist_card.dart';
import 'package:before_go/widgets/weather_banner.dart';

Future<void> pumpHome(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Home shows every checklist as a card', (tester) async {
    await pumpHome(tester);

    expect(find.byType(ChecklistCard), findsNWidgets(dummyChecklists.length));
    expect(find.text('Library'), findsOneWidget);
    expect(find.text('Istanbul · 5 items'), findsOneWidget);
    expect(find.text('2 often forgotten'), findsOneWidget);
  });

  testWidgets('Home shows the weather tip for the default city', (tester) async {
    await pumpHome(tester);

    expect(find.byType(WeatherBanner), findsOneWidget);
    expect(find.text('Istanbul today: rain 70%'), findsOneWidget);
    expect(find.text('Take: Umbrella'), findsOneWidget);
  });

  testWidgets('Choosing a new default city in Settings updates the Home tip',
      (tester) async {
    final originalDefault = defaultCity;
    addTearDown(() => defaultCity = originalDefault);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light, home: const MainShell()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ankara'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Checklists'));
    await tester.pumpAndSettle();

    expect(find.text('Ankara today: rain 10%'), findsOneWidget);
    expect(find.text('Take: Gloves and scarf'), findsOneWidget);
  });

  testWidgets('Removing a checklist can be undone', (tester) async {
    await pumpHome(tester);

    await tester.tap(find.byTooltip('Remove checklist').first);
    await tester.pumpAndSettle();

    expect(find.text('Library'), findsNothing);
    expect(find.text('“Library” removed'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();

    expect(find.text('Library'), findsOneWidget);
    expect(find.byType(ChecklistCard), findsNWidgets(dummyChecklists.length));
  });

  testWidgets('Home shows a message when every checklist is removed', (tester) async {
    await pumpHome(tester);

    for (var i = 0; i < dummyChecklists.length; i++) {
      await tester.tap(find.byTooltip('Remove checklist').first);
      await tester.pumpAndSettle();
    }

    expect(find.byType(ChecklistCard), findsNothing);
    expect(find.text('No checklists yet'), findsOneWidget);
  });

  for (final size in const [Size(360, 640), Size(412, 915)]) {
    testWidgets('Home has no overflow at ${size.width.toInt()}x${size.height.toInt()}',
        (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await pumpHome(tester);

      expect(tester.takeException(), isNull);
    });
  }
}
