import 'package:flutter/material.dart';

import '../models/checklist.dart';
import '../widgets/placeholder_body.dart';

/// Creates a new checklist, or edits the one passed as the route argument.
class ChecklistFormScreen extends StatelessWidget {
  const ChecklistFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checklist = ModalRoute.of(context)?.settings.arguments as Checklist?;

    return Scaffold(
      appBar: AppBar(
        title: Text(checklist == null ? 'New Checklist' : 'Edit Checklist'),
      ),
      body: const PlaceholderBody(owner: 'Doğukan'),
    );
  }
}
