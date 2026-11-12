import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:before_go/screens/login_screen.dart';
import 'package:before_go/screens/sign_up_screen.dart';
import 'package:before_go/utils/app_theme.dart';

Widget _wrap(Widget screen) {
  return MaterialApp(theme: AppTheme.light, home: screen);
}

void main() {
  group('LoginScreen', () {
    testWidgets('shows errors under empty fields', (tester) async {
      await tester.pumpWidget(_wrap(const LoginScreen()));

      await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
      await tester.pump();

      expect(find.text('Enter a valid email address'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('rejects an email without a domain', (tester) async {
      await tester.pumpWidget(_wrap(const LoginScreen()));

      await tester.enterText(find.byType(TextFormField).at(0), 'ayse@');
      await tester.enterText(find.byType(TextFormField).at(1), 'secret1');
      await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
      await tester.pump();

      expect(find.text('Enter a valid email address'), findsOneWidget);
      expect(find.text('Please enter your password'), findsNothing);
    });
  });

  group('SignUpScreen', () {
    testWidgets('shows errors under empty fields', (tester) async {
      await tester.pumpWidget(_wrap(const SignUpScreen()));

      await tester.ensureVisible(find.widgetWithText(FilledButton, 'Create account'));
      await tester.tap(find.widgetWithText(FilledButton, 'Create account'));
      await tester.pump();

      expect(find.text('Please enter your name'), findsOneWidget);
      expect(find.text('Enter a valid email address'), findsOneWidget);
      expect(find.text('Use at least 6 characters'), findsOneWidget);
    });

    testWidgets('requires both passwords to match', (tester) async {
      await tester.pumpWidget(_wrap(const SignUpScreen()));

      await tester.enterText(find.byType(TextFormField).at(0), 'Ayse Kaya');
      await tester.enterText(find.byType(TextFormField).at(1), 'ayse@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'secret1');
      await tester.enterText(find.byType(TextFormField).at(3), 'secret2');
      await tester.ensureVisible(find.widgetWithText(FilledButton, 'Create account'));
      await tester.tap(find.widgetWithText(FilledButton, 'Create account'));
      await tester.pump();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });
  });
}
