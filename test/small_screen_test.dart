import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:before_go/screens/login_screen.dart';
import 'package:before_go/screens/sign_up_screen.dart';
import 'package:before_go/screens/welcome_screen.dart';
import 'package:before_go/utils/app_theme.dart';

void main() {
  final screens = <String, Widget>{
    'Welcome': const WelcomeScreen(),
    'Login': const LoginScreen(),
    'Sign Up': const SignUpScreen(),
  };

  for (final size in const [Size(360, 640), Size(412, 915)]) {
    for (final entry in screens.entries) {
      testWidgets('${entry.key} has no overflow at ${size.width.toInt()}x${size.height.toInt()}',
          (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          MaterialApp(theme: AppTheme.light, home: entry.value),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      });
    }
  }
}
