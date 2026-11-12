import 'package:flutter/material.dart';

import '../models/checklist.dart';
import '../models/dummy_data.dart';
import '../routes.dart';
import '../widgets/placeholder_body.dart';

class ChecklistDetailScreen extends StatelessWidget {
  const ChecklistDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checklist =
        ModalRoute.of(context)?.settings.arguments as Checklist? ??
            dummyChecklists.first;

    return Scaffold(
      appBar: AppBar(title: Text(checklist.title)),
      body: PlaceholderBody(
        owner: 'Doğukan',
        links: [
          PlaceholderLink('Start packing', AppRoutes.packing, arguments: checklist),
          PlaceholderLink(
            'Forgot something last time?',
            AppRoutes.forgotReport,
            arguments: checklist,
          ),
          PlaceholderLink('Edit', AppRoutes.checklistForm, arguments: checklist),
        ],
      ),
    );
  }
}
