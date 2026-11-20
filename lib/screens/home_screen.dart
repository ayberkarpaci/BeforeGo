import 'package:flutter/material.dart';

import '../models/checklist.dart';
import '../models/dummy_data.dart';
import '../routes.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';
import '../widgets/checklist_card.dart';
import '../widgets/weather_banner.dart';

/// First tab: the user's checklists as cards.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Checklist> _checklists = List.of(dummyChecklists);

  void _openChecklist(Checklist checklist) {
    Navigator.pushNamed(
      context,
      AppRoutes.checklistDetail,
      arguments: checklist,
    );
  }

  void _removeChecklist(int index) {
    final removed = _checklists[index];
    setState(() => _checklists.removeAt(index));

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('“${removed.title}” removed'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => setState(() => _checklists.insert(index, removed)),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final weather = dummyWeather[defaultCity];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Checklists'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        // Extra bottom space so the last card is not hidden by the button.
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.xl * 3,
        ),
        children: [
          // Today's tip for the default city chosen in Settings.
          if (weather != null) ...[
            WeatherBanner(weather: weather),
            const SizedBox(height: AppSpacing.md),
          ],
          if (_checklists.isEmpty)
            const _EmptyState()
          else
            for (var index = 0; index < _checklists.length; index++)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ChecklistCard(
                  checklist: _checklists[index],
                  onTap: () => _openChecklist(_checklists[index]),
                  onRemove: () => _removeChecklist(index),
                ),
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.checklistForm),
        tooltip: 'New checklist',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Column(
        children: [
          Icon(Icons.checklist, size: 56, color: AppColors.textMuted),
          SizedBox(height: AppSpacing.sm),
          Text('No checklists yet', style: AppTextStyles.heading),
          SizedBox(height: AppSpacing.xs),
          Text(
            'Tap + to create your first checklist.',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
