import 'package:flutter/material.dart';

import '../routes.dart';
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
      // IndexedStack keeps each tab's state when switching tabs. The tabs are
      // not const so they rebuild on every switch, e.g. Home shows the new
      // default city right after it is changed in Settings.
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          StatisticsScreen(),
          SettingsScreen(),
        ],
      ),
      // Kept here rather than in HomeScreen: SnackBars are shown in this outer
      // Scaffold, and only its own button slides up out of their way.
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.checklistForm),
              tooltip: 'New checklist',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
