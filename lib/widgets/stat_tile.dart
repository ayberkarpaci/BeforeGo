import 'package:flutter/material.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';

class StatTile extends StatelessWidget {
  final String value;
  final String label;

  const StatTile({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: AppTextStyles.title,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(label),
          ],
        ),
      ),
    );
  }
}