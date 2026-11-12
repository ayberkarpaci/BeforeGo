import 'package:flutter/material.dart';

/// Spacing and corner radius values. Use these instead of plain numbers.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double radiusSm = 8;
  static const double radiusMd = 12;

  /// Default padding around the content of a screen.
  static const EdgeInsets page = EdgeInsets.all(md);
}
