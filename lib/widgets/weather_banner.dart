import 'package:flutter/material.dart';
import '../models/weather_info.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';

class WeatherBanner extends StatelessWidget {
  final WeatherInfo weather;
  final ValueChanged<String>? onAddItem;

  const WeatherBanner({
    super.key,
    required this.weather,
    this.onAddItem,
  });

  Icon buildWeatherIcon(List<String> suggestions) {
    if (suggestions.isEmpty) {
      return Icon(Icons.cloud_outlined, color: AppColors.primary);
    }
    else if (suggestions[0] == 'Umbrella') {
      return Icon(Icons.umbrella_outlined, color: AppColors.primary);
    }
    else if (suggestions[0] == 'Water bottle') {
      return Icon(Icons.wb_sunny_outlined, color: AppColors.primary);
    }
    else if (suggestions[0] == 'Gloves and scarf') {
      return Icon(Icons.ac_unit, color: AppColors.primary);
    }
    return Icon(Icons.cloud_outlined, color: AppColors.primary);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> suggestions = weather.suggestedItems;
    final bool hasSuggestions = suggestions.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildWeatherIcon(suggestions),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${weather.city} today: rain ${weather.rainChance}%',
                  style: AppTextStyles.bodyBold,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  hasSuggestions ? 'Take: ${suggestions.join(', ')}' : 'No extra items needed today.',
                  style: AppTextStyles.caption
                  ),
                
              ],
            ),
          ),
          if (onAddItem != null && hasSuggestions)
            Padding(
              padding: const EdgeInsets.only(left: AppSpacing.xs),
              child: TextButton(
                onPressed: () => onAddItem!(suggestions[0]),
                child: const Text('+ Add'),
              ),
            ),
        ],
      ),
    );
  }
}