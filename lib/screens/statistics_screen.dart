import 'package:flutter/material.dart';

import '../widgets/placeholder_body.dart';

/// Second tab of [MainShell].
class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        automaticallyImplyLeading: false,
      ),
      body: const PlaceholderBody(owner: 'Yusuf'),
    );
  }
}
