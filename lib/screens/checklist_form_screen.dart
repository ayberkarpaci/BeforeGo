import 'package:flutter/material.dart';

import '../models/checklist.dart';
import '../models/dummy_data.dart';
import '../routes.dart';
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
  final _itemController = TextEditingController();
  final List<String> _items = [];
  bool _showItemsError = false;
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
      for (final item in _checklist!.items) {
        _items.add(item.name);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _itemController.dispose();
    super.dispose();
  }

  void _addItem() {
    final name = _itemController.text.trim();
    if (name.isEmpty) return;

    setState(() {
      _items.add(name);
      _itemController.clear();
      _showItemsError = false;
    });
  }

  void _save() {
    final formOk = _formKey.currentState!.validate();
    setState(() => _showItemsError = _items.isEmpty);
    if (!formOk || _items.isEmpty) return;

    final name = _nameController.text.trim();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Checklist saved'),
        content: Text('"$name" was added with ${_items.length} items.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              dialogContext,
              AppRoutes.home,
              (route) => false,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
            const Text('ITEMS', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: 'Add item',
                    controller: _itemController,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                IconButton.filled(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                  tooltip: 'Add item',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (var i = 0; i < _items.length; i++)
                  Chip(
                    label: Text(_items[i]),
                    onDeleted: () => setState(() => _items.removeAt(i)),
                  ),
              ],
            ),
            if (_showItemsError)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(
                  'Add at least one item',
                  style: AppTextStyles.caption.copyWith(color: AppColors.error),
                ),
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
