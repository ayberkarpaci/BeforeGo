import 'package:flutter/material.dart';

import '../models/checklist.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';

/// One checklist on the Home screen: cover image, title, city and item count,
/// plus a button that removes the checklist.
class ChecklistCard extends StatelessWidget {
  final Checklist checklist;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const ChecklistCard({
    super.key,
    required this.checklist,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final oftenForgotten = checklist.oftenForgottenCount;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              _CoverImage(url: checklist.coverImageUrl, icon: checklist.icon),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      checklist.title,
                      style: AppTextStyles.bodyBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${checklist.city} · ${checklist.items.length} items',
                      style: AppTextStyles.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (oftenForgotten > 0) ...[
                      const SizedBox(height: AppSpacing.xs),
                      _OftenForgottenBadge(count: oftenForgotten),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.close),
                color: AppColors.textMuted,
                tooltip: 'Remove checklist',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoverImage extends StatelessWidget {
  final String url;
  final IconData icon;

  const _CoverImage({required this.url, required this.icon});

  static const double _size = 64;

  @override
  Widget build(BuildContext context) {
    // Shown while the image loads and when there is no internet.
    final fallback = Container(
      color: AppColors.primaryLight,
      alignment: Alignment.center,
      child: Icon(icon, color: AppColors.primary),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: SizedBox(
        width: _size,
        height: _size,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) =>
              progress == null ? child : fallback,
          errorBuilder: (context, error, stackTrace) => fallback,
        ),
      ),
    );
  }
}

class _OftenForgottenBadge extends StatelessWidget {
  final int count;

  const _OftenForgottenBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        '$count often forgotten',
        style: AppTextStyles.caption.copyWith(
          color: AppColors.warning,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
