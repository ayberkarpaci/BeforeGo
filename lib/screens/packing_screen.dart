import 'package:flutter/material.dart';

import '../models/checklist.dart';
import '../models/dummy_data.dart';
import '../routes.dart';
import '../widgets/placeholder_body.dart';

class PackingScreen extends StatelessWidget {
  const PackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checklist =
        ModalRoute.of(context)?.settings.arguments as Checklist? ??
            dummyChecklists.first;

    return Scaffold(
      appBar: AppBar(title: Text('Packing · ${checklist.title}')),
      body: const PlaceholderBody(
        owner: 'Yusuf',
        links: [
          PlaceholderLink('I’m ready', AppRoutes.home, clearStack: true),
        ],
      ),
    );
  }
}
