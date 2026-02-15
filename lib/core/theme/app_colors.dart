import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary - Hot Wheels red
  static const Color primary = Color(0xFFCC0000);
  static const Color primaryLight = Color(0xFFFF3333);
  static const Color primaryDark = Color(0xFF990000);

  // Secondary - flame orange
  static const Color secondary = Color(0xFFFF6600);
  static const Color secondaryLight = Color(0xFFFF9933);
  static const Color secondaryDark = Color(0xFFCC5200);

  // Neutrals
  static const Color surface = Color(0xFFFAFAFA);
  static const Color background = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color onSurfaceVariant = Color(0xFF49454F);

  // Semantic
  static const Color error = Color(0xFFBA1A1A);
  static const Color success = Color(0xFF2E7D32);
}
