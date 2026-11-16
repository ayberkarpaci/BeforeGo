import 'package:flutter/material.dart';

import '../models/checklist_item.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';

class ItemTile extends StatelessWidget {
  final ChecklistItem item;
  final bool showScore;
  final bool? checked;
  final ValueChanged<bool?>? onChanged;

  const ItemTile({
    super.key,
    required this.item,
    this.showScore = true,
    this.checked,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: item.isOftenForgotten ? AppColors.warning : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          if (checked != null) Checkbox(value: checked, onChanged: onChanged),
          Expanded(
            child: Text(item.name, style: AppTextStyles.body),
          ),
          if (item.isOftenForgotten) _badge(),
          if (showScore) ...[
            const SizedBox(width: AppSpacing.sm),
            Text('score ${item.score}', style: AppTextStyles.caption),
          ],
        ],
      ),
    );
  }

  Widget _badge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        'Often forgotten',
        style: AppTextStyles.caption.copyWith(
          color: AppColors.warning,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
