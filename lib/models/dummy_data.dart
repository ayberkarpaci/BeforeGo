import 'package:flutter/material.dart';

import 'checklist.dart';
import 'checklist_item.dart';
import 'weather_info.dart';

// Placeholder data for Step 2. Firebase and the weather API replace it in Step 3.

const String dummyUserEmail = 'ayberk@sabanciuniv.edu';

/// Cities saved in Settings. Each checklist uses one of them.
final List<String> savedCities = ['Istanbul', 'Tekirdağ', 'Ankara'];

/// The city shown on Home and preselected for new checklists.
String defaultCity = 'Istanbul';

final List<Checklist> dummyChecklists = [
  Checklist(
    id: 'library',
    title: 'Library',
    city: 'Istanbul',
    coverImageUrl: 'https://picsum.photos/id/24/400/300',
    icon: Icons.local_library_outlined,
    sessionCount: 12,
    lastPacked: DateTime(2026, 11, 3),
    items: const [
      ChecklistItem(id: 'l1', name: 'Laptop charger', totalForgets: 3, recentForgets: 2),
      ChecklistItem(id: 'l2', name: 'Headphones', totalForgets: 2),
      ChecklistItem(id: 'l3', name: 'Laptop'),
      ChecklistItem(id: 'l4', name: 'Student ID'),
      ChecklistItem(id: 'l5', name: 'Water bottle'),
    ],
  ),
  Checklist(
    id: 'gym',
    title: 'Gym',
    city: 'Istanbul',
    coverImageUrl: 'https://picsum.photos/id/103/400/300',
    icon: Icons.fitness_center,
    sessionCount: 8,
    lastPacked: DateTime(2026, 11, 10),
    items: const [
      ChecklistItem(id: 'g1', name: 'Towel', totalForgets: 2, recentForgets: 1),
      ChecklistItem(id: 'g2', name: 'Water bottle', totalForgets: 1),
      ChecklistItem(id: 'g3', name: 'Gym shoes'),
      ChecklistItem(id: 'g4', name: 'Locker lock'),
      ChecklistItem(id: 'g5', name: 'Headphones'),
      ChecklistItem(id: 'g6', name: 'Protein bar'),
    ],
  ),
  Checklist(
    id: 'weekend-trip',
    title: 'Weekend Trip',
    city: 'Tekirdağ',
    coverImageUrl: 'https://picsum.photos/id/551/400/300',
    icon: Icons.card_travel,
    sessionCount: 3,
    lastPacked: DateTime(2026, 10, 24),
    items: const [
      ChecklistItem(id: 't1', name: 'Phone charger', totalForgets: 2, recentForgets: 2),
      ChecklistItem(id: 't2', name: 'Toothbrush', totalForgets: 1, recentForgets: 1),
      ChecklistItem(id: 't3', name: 'Jacket', totalForgets: 1),
      ChecklistItem(id: 't4', name: 'ID card'),
      ChecklistItem(id: 't5', name: 'Wallet'),
      ChecklistItem(id: 't6', name: 'Power bank'),
      ChecklistItem(id: 't7', name: 'Sunglasses'),
      ChecklistItem(id: 't8', name: 'Pyjamas'),
      ChecklistItem(id: 't9', name: 'Socks'),
      ChecklistItem(id: 't10', name: 'T-shirts'),
      ChecklistItem(id: 't11', name: 'Medicine'),
      ChecklistItem(id: 't12', name: 'Book'),
    ],
  ),
  Checklist(
    id: 'lab-day',
    title: 'Lab Day',
    city: 'Istanbul',
    coverImageUrl: 'https://picsum.photos/id/20/400/300',
    icon: Icons.science_outlined,
    sessionCount: 5,
    lastPacked: DateTime(2026, 11, 6),
    items: const [
      ChecklistItem(id: 'b1', name: 'Lab coat', totalForgets: 1),
      ChecklistItem(id: 'b2', name: 'Safety goggles'),
      ChecklistItem(id: 'b3', name: 'Lab notebook'),
      ChecklistItem(id: 'b4', name: 'Student ID'),
    ],
  ),
];

/// Today's forecast for each saved city.
const Map<String, WeatherInfo> dummyWeather = {
  'Istanbul': WeatherInfo(city: 'Istanbul', rainChance: 70, maxTemperature: 16, minTemperature: 9),
  'Tekirdağ': WeatherInfo(city: 'Tekirdağ', rainChance: 20, maxTemperature: 14, minTemperature: 4),
  'Ankara': WeatherInfo(city: 'Ankara', rainChance: 10, maxTemperature: 12, minTemperature: 2),
};

/// Number of forgotten items in each of the last six weeks (oldest first).
const List<int> dummyWeeklyForgets = [3, 4, 2, 3, 1, 1];
