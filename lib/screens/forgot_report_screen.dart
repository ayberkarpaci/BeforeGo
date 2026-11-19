import 'package:flutter/material.dart';
import '../models/checklist.dart';
import '../models/checklist_item.dart';
import '../models/dummy_data.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';

class ForgotReportScreen extends StatefulWidget {
  const ForgotReportScreen({super.key});

  @override
  State<ForgotReportScreen> createState() => _ForgotReportScreenState();
}

class _ForgotReportScreenState extends State<ForgotReportScreen> {
  Checklist checklist = dummyChecklists[0];
  final Set<String> forgottenIds = <String>{};
  String extraText = '';
  String? errorText;
  bool isSaved = false;

  void updateItem(String itemId) {
    setState(() {
      if (forgottenIds.contains(itemId)) {
        forgottenIds.remove(itemId);
      } else {
        forgottenIds.add(itemId);
      }
      if (errorText != null) {
        errorText = null;
      }
    });
  }

  void onSave() {
    if (forgottenIds.isEmpty && extraText.isEmpty) {
      setState(() {
        isSaved = false;
        errorText = 'Select an item or type one';
      });
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<ChecklistItem> items = checklist.sortedItems;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'What did you forget?',
          style: AppTextStyles.heading,
        ),
      ),
      body: ListView(
        padding: AppSpacing.page,
        children: [
          Text(
            '${checklist.title} · last session',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: AppSpacing.md),
          for (final ChecklistItem item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Row(
                    children: [
                      Checkbox(
                        value: forgottenIds.contains(item.id),
                        activeColor: AppColors.primary,
                        onChanged: (bool? value) => updateItem(item.id),
                      ),
                      Expanded(
                        child: Text(
                          item.name,
                          style: AppTextStyles.bodyBold,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Score ${item.score}',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Something not on the list?',
            style: AppTextStyles.bodyBold,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            onChanged: (String value) {
              extraText = value;
              if (errorText != null) {
                setState(() {
                  errorText = null;
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'e.g. Umbrella',
              errorText: errorText,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            "Each forget raises the item's score for the next session.",
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Checkbox(
                value: isSaved,
                activeColor: AppColors.primary,
                onChanged: (bool? value) {
                  setState(() {
                    isSaved = value ?? false;
                  });
                  if (isSaved) {
                    onSave();
                  }
                },
              ),
              Text(
                'Save',
                style: AppTextStyles.bodyBold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}