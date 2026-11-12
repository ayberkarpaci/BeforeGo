/// Today's forecast for one city.
class WeatherInfo {
  final String city;

  /// Chance of rain in percent (0-100).
  final int rainChance;
  final double maxTemperature;
  final double minTemperature;

  const WeatherInfo({
    required this.city,
    required this.rainChance,
    required this.maxTemperature,
    required this.minTemperature,
  });

  /// Extra items suggested by the three fixed weather rules.
  List<String> get suggestedItems => [
        if (rainChance >= 50) 'Umbrella',
        if (maxTemperature >= 28) 'Water bottle',
        if (minTemperature <= 5) 'Gloves and scarf',
      ];
}
