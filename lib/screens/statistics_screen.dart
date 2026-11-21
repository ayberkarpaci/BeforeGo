import 'package:flutter/material.dart';
import '../models/checklist.dart';
import '../models/checklist_item.dart';
import '../models/dummy_data.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';
import '../widgets/stat_tile.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  double getBarHeight(int count, int maxCount, double maxHeight) {
    final double height = (count / maxCount) * maxHeight;
    if (height < AppSpacing.xs) {
      return AppSpacing.xs;
    }
    return height;
  }

  @override
  Widget build(BuildContext context) {
    int totalSessions = 0;
    int totalForgets = 0;
    for (final Checklist checklist in dummyChecklists) {
      totalSessions += checklist.sessionCount;
      for (final ChecklistItem item in checklist.items) {
        totalForgets += item.totalForgets;
      }
    }

    int maxWeeklyForgets = 0;
    for (final int count in dummyWeeklyForgets) {
      if (count > maxWeeklyForgets) {
        maxWeeklyForgets = count;
      }
    }

    final List<String> itemNames = <String>[];
    final List<int> itemCounts = <int>[];
    for (final Checklist checklist in dummyChecklists) {
      for (final ChecklistItem item in checklist.items) {
        if (item.totalForgets > 0) {
          int foundIndex = -1;
          for (int i = 0; i < itemNames.length; i++) {
            if (itemNames[i] == item.name) {
              foundIndex = i;
              break;
            }
          }
          if (foundIndex != -1) {
            itemCounts[foundIndex] += item.totalForgets;
          } else {
            itemNames.add(item.name);
            itemCounts.add(item.totalForgets);
          }
        }
      }
    }

    for (int i = 0; i < itemCounts.length; i++) {
      for (int j = i + 1; j < itemCounts.length; j++) {
        if (itemCounts[j] > itemCounts[i]) {
          final int tempCount = itemCounts[i];
          itemCounts[i] = itemCounts[j];
          itemCounts[j] = tempCount;

          final String tempName = itemNames[i];
          itemNames[i] = itemNames[j];
          itemNames[j] = tempName;
        }
      }
    }

    final int maxItemForgets = itemCounts.isEmpty ? 0 : itemCounts[0];
    final double maxBarHeight = AppSpacing.xl * 3;
    final double chartAreaHeight = AppSpacing.xl * 4.5;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: AppTextStyles.heading,
        ),
        // A tab of the home shell, so it never shows a back arrow.
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: AppSpacing.page,
        children: [
          Row(
            children: [
              Expanded(
                child: StatTile(
                  value: '$totalSessions',
                  label: 'total sessions',
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: StatTile(
                  value: '$totalForgets',
                  label: 'total forgets',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MOST FORGOTTEN',
                    style: AppTextStyles.label,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (itemNames.isEmpty)
                    Text(
                      'No forgotten items recorded yet.',
                      style: AppTextStyles.body,
                    )
                  else
                    for (int i = 0; i < itemNames.length && i < 3; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    itemNames[i],
                                    style: AppTextStyles.bodyBold,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Text(
                                  '${itemCounts[i]}',
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Container(
                              height: AppSpacing.sm,
                              color: AppColors.primaryLight,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: itemCounts[i],
                                    child: Container(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  if (maxItemForgets - itemCounts[i] > 0)
                                    Expanded(
                                      flex: maxItemForgets - itemCounts[i],
                                      child: const SizedBox(),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FORGETS PER WEEK',
                    style: AppTextStyles.label,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: chartAreaHeight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (int i = 0; i < dummyWeeklyForgets.length; i++)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.xs,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${dummyWeeklyForgets[i]}',
                                    style: AppTextStyles.caption,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Container(
                                    height: getBarHeight(
                                      dummyWeeklyForgets[i],
                                      maxWeeklyForgets,
                                      maxBarHeight,
                                    ),
                                    color: i == dummyWeeklyForgets.length - 1
                                        ? AppColors.primary
                                        : AppColors.primaryLight,
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    'W${i + 1}',
                                    style: AppTextStyles.caption,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}