import 'package:flutter/material.dart';

import '../models/dummy_data.dart';

class CityDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const CityDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: const InputDecoration(labelText: 'Weather city'),
      items: [
        for (final city in savedCities)
          DropdownMenuItem(value: city, child: Text(city)),
      ],
      onChanged: (city) {
        if (city != null) onChanged(city);
      },
    );
  }
}
