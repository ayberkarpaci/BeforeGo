import 'package:flutter/material.dart';

import '../widgets/placeholder_body.dart';

class ForgotReportScreen extends StatelessWidget {
  const ForgotReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('What did you forget?')),
      body: const PlaceholderBody(owner: 'Yusuf'),
    );
  }
}
