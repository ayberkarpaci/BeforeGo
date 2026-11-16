import 'package:flutter/material.dart';

import '../models/checklist.dart';
import '../models/dummy_data.dart';
import '../routes.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';
import '../widgets/item_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';

class ChecklistDetailScreen extends StatelessWidget {
  const ChecklistDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checklist =
        ModalRoute.of(context)?.settings.arguments as Checklist? ??
            dummyChecklists.first;

    return Scaffold(
      appBar: AppBar(
        title: Text(checklist.title),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.checklistForm,
              arguments: checklist,
            ),
            child: const Text('Edit'),
          ),
        ],
      ),
      body: ListView(
        padding: AppSpacing.page,
        children: [
          const Text('ITEMS, SORTED BY SCORE', style: AppTextStyles.label),
          const SizedBox(height: AppSpacing.sm),
          for (final item in checklist.sortedItems) ItemTile(item: item),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(
            label: 'Start packing',
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.packing,
              arguments: checklist,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SecondaryButton(
            label: 'Forgot something last time?',
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.forgotReport,
              arguments: checklist,
            ),
          ),
        ],
      ),
    );
  }
}
