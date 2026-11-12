import 'package:flutter/material.dart';

import 'screens/checklist_detail_screen.dart';
import 'screens/checklist_form_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/forgot_report_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_shell.dart';
import 'screens/packing_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/welcome_screen.dart';

/// Route names for every screen. Statistics and Settings are tabs inside
/// [MainShell], so they do not have their own route.
///
/// Screens that show one checklist (detail, form, packing, forgot report)
/// receive the [Checklist] as the route argument:
/// `Navigator.pushNamed(context, AppRoutes.checklistDetail, arguments: checklist)`
class AppRoutes {
  AppRoutes._();

  static const String welcome = '/';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String checklistDetail = '/checklist';
  static const String checklistForm = '/checklist-form';
  static const String packing = '/packing';
  static const String forgotReport = '/forgot-report';

  static Map<String, WidgetBuilder> get routes => {
        welcome: (_) => const WelcomeScreen(),
        login: (_) => const LoginScreen(),
        signUp: (_) => const SignUpScreen(),
        forgotPassword: (_) => const ForgotPasswordScreen(),
        home: (_) => const MainShell(),
        checklistDetail: (_) => const ChecklistDetailScreen(),
        checklistForm: (_) => const ChecklistFormScreen(),
        packing: (_) => const PackingScreen(),
        forgotReport: (_) => const ForgotReportScreen(),
      };
}
