import 'package:flutter/material.dart';

import 'checklist_item.dart';

/// A preparation checklist for one situation, e.g. "Library" or "Gym".
class Checklist {
  final String id;
  final String title;

  /// The city used for this checklist's weather tip.
  final String city;
  final String coverImageUrl;
  final IconData icon;
  final List<ChecklistItem> items;
  final int sessionCount;
  final DateTime? lastPacked;

  const Checklist({
    required this.id,
    required this.title,
    required this.city,
    required this.coverImageUrl,
    required this.icon,
    required this.items,
    this.sessionCount = 0,
    this.lastPacked,
  });

  /// Items with the highest score first.
  List<ChecklistItem> get sortedItems =>
      [...items]..sort((a, b) => b.score.compareTo(a.score));

  int get oftenForgottenCount =>
      items.where((item) => item.isOftenForgotten).length;
}
