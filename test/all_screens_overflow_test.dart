import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:before_go/screens/checklist_detail_screen.dart';
import 'package:before_go/screens/checklist_form_screen.dart';
import 'package:before_go/screens/forgot_password_screen.dart';
import 'package:before_go/screens/forgot_report_screen.dart';
import 'package:before_go/screens/login_screen.dart';
import 'package:before_go/screens/main_shell.dart';
import 'package:before_go/screens/packing_screen.dart';
import 'package:before_go/screens/settings_screen.dart';
import 'package:before_go/screens/sign_up_screen.dart';
import 'package:before_go/screens/statistics_screen.dart';
import 'package:before_go/screens/welcome_screen.dart';
import 'package:before_go/utils/app_theme.dart';

/// Step 2.2 requires that no screen overflows on small or large phones in
/// portrait mode, so every screen of the app is checked here at both sizes.
void main() {
  final screens = <String, Widget Function()>{
    'Welcome': () => const WelcomeScreen(),
    'Login': () => const LoginScreen(),
    'Sign Up': () => const SignUpScreen(),
    'Forgot Password': () => const ForgotPasswordScreen(),
    'Home': () => const MainShell(),
    'Checklist Detail': () => const ChecklistDetailScreen(),
    'New Checklist': () => const ChecklistFormScreen(),
    'Packing Mode': () => const PackingScreen(),
    'Forgot Report': () => const ForgotReportScreen(),
    'Statistics': () => const StatisticsScreen(),
    'Settings': () => const SettingsScreen(),
  };

  for (final size in const [Size(360, 640), Size(412, 915)]) {
    for (final entry in screens.entries) {
      testWidgets(
          '${entry.key} has no overflow at ${size.width.toInt()}x${size.height.toInt()}',
          (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          MaterialApp(theme: AppTheme.light, home: entry.value()),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      });
    }
  }
}
