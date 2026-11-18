import 'package:flutter/material.dart';

import '../models/checklist.dart';
import '../models/dummy_data.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';
import '../widgets/app_text_field.dart';
import '../widgets/city_dropdown.dart';
import '../widgets/primary_button.dart';

class ChecklistFormScreen extends StatefulWidget {
  const ChecklistFormScreen({super.key});

  @override
  State<ChecklistFormScreen> createState() => _ChecklistFormScreenState();
}

class _ChecklistFormScreenState extends State<ChecklistFormScreen> {
  static const List<IconData> _icons = [
    Icons.local_library_outlined,
    Icons.fitness_center,
    Icons.card_travel,
    Icons.science_outlined,
    Icons.work_outline,
  ];

  IconData _icon = Icons.local_library_outlined;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Checklist? _checklist;
  String _city = defaultCity;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    _loaded = true;

    _checklist = ModalRoute.of(context)?.settings.arguments as Checklist?;
    if (_checklist != null) {
      _nameController.text = _checklist!.title;
      _city = _checklist!.city;
      _icon = _checklist!.icon;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_checklist == null ? 'New Checklist' : 'Edit Checklist'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: AppSpacing.page,
          children: [
            AppTextField(
              label: 'Checklist name',
              controller: _nameController,
              validator: FieldValidators.required('Please enter a name'),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: AppSpacing.md),
            CityDropdown(
              value: _city,
              onChanged: (city) => setState(() => _city = city),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text('ICON', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final icon in _icons) _iconButton(icon),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(label: 'Save', onPressed: _save),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    final selected = icon == _icon;

    return InkWell(
      onTap: () => setState(() => _icon = icon),
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryLight : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Icon(
          icon,
          color: selected ? AppColors.primary : AppColors.textMuted,
        ),
      ),
    );
  }
}
