import 'package:flutter/material.dart';

import '../widgets/app_bottom_nav.dart';
import 'home_screen.dart';
import 'settings_screen.dart';
import 'statistics_screen.dart';

/// Holds the three tabs (Home, Statistics, Settings) and the bottom bar.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps each tab's state when switching tabs.
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          StatisticsScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
