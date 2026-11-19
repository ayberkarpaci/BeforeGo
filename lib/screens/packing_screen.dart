import 'package:flutter/material.dart';
import '../models/checklist.dart';
import '../models/checklist_item.dart';
import '../models/dummy_data.dart';
import '../models/weather_info.dart';
import '../routes.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';
import '../widgets/weather_banner.dart';

class PackingScreen extends StatefulWidget {
  const PackingScreen({super.key});

  @override
  State<PackingScreen> createState() => _PackingScreenState();
}

class _PackingScreenState extends State<PackingScreen> {
  Checklist checklist = dummyChecklists[0];
  List<ChecklistItem> items = List<ChecklistItem>.from(dummyChecklists[0].sortedItems,);
  final Set<String> checkedIds = <String>{};
  bool isReady = false;

  void updateItem(String itemId) {
    setState(() {
      if (checkedIds.contains(itemId)) {
        checkedIds.remove(itemId);
      } 
      else {
        checkedIds.add(itemId);
      }
    });
  }

  void addSuggestedItem(String itemName) {
    for (final ChecklistItem item in items) {
      if (item.name == itemName) {
        return;
      }
    }

    setState(() {
      items.add(
        ChecklistItem(
          id: 'weather_$itemName',
          name: itemName,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalCount = items.length;
    int readyCount = 0;
    for (final ChecklistItem item in items) {
      if (checkedIds.contains(item.id)) {
        readyCount++;
      }
    }
    final double progress = totalCount == 0 ? 0.0 : readyCount / totalCount;

    final WeatherInfo weather = dummyWeather[checklist.city] ?? WeatherInfo(city: checklist.city,rainChance: 0,maxTemperature: 20,minTemperature: 10,);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Packing · ${checklist.title}',
          style: AppTextStyles.heading,
        ),
      ),
      body: ListView(
        padding: AppSpacing.page,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '$readyCount of $totalCount ready',
                  style: AppTextStyles.bodyBold,
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: AppTextStyles.caption,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            height: AppSpacing.sm,
            color: AppColors.primaryLight,
            child: Row(
              children: [
                if (readyCount > 0)
                  Expanded(
                    flex: readyCount,
                    child: Container(color: AppColors.primary),
                  ),
                if (totalCount - readyCount > 0)
                  Expanded(
                    flex: totalCount - readyCount,
                    child: const SizedBox(),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          WeatherBanner(
            weather: weather,
            onAddItem: addSuggestedItem,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'ITEMS TO PACK',
            style: AppTextStyles.label,
          ),
          const SizedBox(height: AppSpacing.sm),
          if (items.isEmpty)
            Text(
              'No items in this checklist.',
              style: AppTextStyles.body,
            )
          else
            for (final ChecklistItem item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    child: Row(
                      children: [
                        Checkbox(
                          value: checkedIds.contains(item.id),
                          activeColor: AppColors.primary,
                          onChanged: (bool? value) => updateItem(item.id),
                        ),
                        Expanded(
                          child: Text(
                            item.name,
                            style: AppTextStyles.bodyBold,
                          ),
                        ),
                          if (item.isOftenForgotten)
                          Padding(
                            padding: const EdgeInsets.only(left: AppSpacing.sm),
                            child: Container(
                              padding: const EdgeInsets.all(AppSpacing.xs),
                              color: AppColors.warningLight,
                              child: Text(
                                'Often forgotten',
                                style: AppTextStyles.caption,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Checkbox(
                value: isReady,
                activeColor: AppColors.primary,
                onChanged: (bool? value) {
                  setState(() {
                    isReady = value ?? false;
                  });
                  if (isReady) {
                    Navigator.pushNamed(context, AppRoutes.home);
                  }
                },
              ),
              Text(
                "I'm ready",
                style: AppTextStyles.bodyBold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}