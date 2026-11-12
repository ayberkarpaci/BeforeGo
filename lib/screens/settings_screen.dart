import 'package:flutter/material.dart';

import '../models/dummy_data.dart';
import '../routes.dart';
import '../utils/app_colors.dart';
import '../utils/app_spacing.dart';
import '../utils/app_text_styles.dart';

/// Third tab: saved weather cities, preferences and log out.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _remindersOn = false;
  bool _darkModeOn = false;

  Future<void> _addCity() async {
    final city = await showDialog<String>(
      context: context,
      builder: (context) => const _AddCityDialog(),
    );
    if (city == null || !mounted) return;
    setState(() => savedCities.add(city));
  }

  void _removeCity(String city) {
    setState(() {
      savedCities.remove(city);
      if (defaultCity == city) defaultCity = savedCities.first;
    });
  }

  Future<void> _confirmLogOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text(
          'You will need to log in again to see your checklists.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: AppSpacing.page,
        children: [
          const Text('Signed in as $dummyUserEmail', style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.lg),
          const _SectionLabel('Weather cities'),
          const Text(
            'Each checklist uses one of these cities for its weather tip. '
            'Tap a city to make it the default.',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: AppSpacing.sm),
          Card(
            child: Column(
              children: [
                for (final city in savedCities) ...[
                  _CityTile(
                    city: city,
                    isDefault: city == defaultCity,
                    canRemove: savedCities.length > 1,
                    onSelect: () => setState(() => defaultCity = city),
                    onRemove: () => _removeCity(city),
                  ),
                  if (city != savedCities.last) const Divider(),
                ],
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _addCity,
              icon: const Icon(Icons.add),
              label: const Text('Add city'),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const _SectionLabel('Preferences'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Reminder notifications', style: AppTextStyles.body),
                  subtitle: const Text('Coming in a later step', style: AppTextStyles.caption),
                  value: _remindersOn,
                  onChanged: (value) => setState(() => _remindersOn = value),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Dark mode', style: AppTextStyles.body),
                  subtitle: const Text('Coming in a later step', style: AppTextStyles.caption),
                  value: _darkModeOn,
                  onChanged: (value) => setState(() => _darkModeOn = value),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          OutlinedButton.icon(
            onPressed: _confirmLogOut,
            icon: const Icon(Icons.logout),
            label: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(text.toUpperCase(), style: AppTextStyles.label),
    );
  }
}

class _CityTile extends StatelessWidget {
  final String city;
  final bool isDefault;
  final bool canRemove;
  final VoidCallback onSelect;
  final VoidCallback onRemove;

  const _CityTile({
    required this.city,
    required this.isDefault,
    required this.canRemove,
    required this.onSelect,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onSelect,
      leading: Icon(
        isDefault ? Icons.star : Icons.location_on_outlined,
        color: isDefault ? AppColors.primary : AppColors.textMuted,
      ),
      title: Text(city, style: AppTextStyles.body),
      subtitle: isDefault ? const Text('Default', style: AppTextStyles.caption) : null,
      trailing: IconButton(
        onPressed: canRemove ? onRemove : null,
        icon: const Icon(Icons.close),
        tooltip: 'Remove $city',
      ),
    );
  }
}

/// Asks for a city name and returns it, or null when cancelled.
class _AddCityDialog extends StatefulWidget {
  const _AddCityDialog();

  @override
  State<_AddCityDialog> createState() => _AddCityDialogState();
}

class _AddCityDialogState extends State<_AddCityDialog> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Please enter a city name';
    final alreadySaved =
        savedCities.any((city) => city.toLowerCase() == name.toLowerCase());
    if (alreadySaved) return 'This city is already saved';
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add city'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            labelText: 'City name',
            hintText: 'e.g. Izmir',
          ),
          validator: _validate,
          onFieldSubmitted: (_) => _submit(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: _submit, child: const Text('Add')),
      ],
    );
  }
}
