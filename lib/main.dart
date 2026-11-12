import 'package:flutter/material.dart';

import 'routes.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const BeforeGoApp());
}

class BeforeGoApp extends StatelessWidget {
  const BeforeGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeforeGo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.welcome,
      routes: AppRoutes.routes,
    );
  }
}
