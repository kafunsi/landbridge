import 'package:flutter/material.dart';

/// Central palette for the entire application.
/// STRICT RULE: Only two brand colours are permitted:
///   - Deep Royal Blue #2457C5
///   - Emerald Teal   #12B8A6
/// All other colours are neutrals (white, black, greys).
class AppColors {
  AppColors._();

  // ===== Brand colours =====
  static const Color royalBlue = Color(0xFF2457C5);
  static const Color emeraldTeal = Color(0xFF12B8A6);

  // Slight shades derived ONLY from the two brand colours.
  static const Color royalBlueDark = Color(0xFF1B3F94);
  static const Color royalBlueLight = Color(0xFF5A80DA);

  static const Color emeraldTealDark = Color(0xFF0C897B);
  static const Color emeraldTealLight = Color(0xFF5CD3C6);

  // ===== Neutrals =====
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color grey50 = Color(0xFFF7F8FA);
  static const Color grey100 = Color(0xFFEDEFF3);
  static const Color grey200 = Color(0xFFD9DDE3);
  static const Color grey300 = Color(0xFFB9C0C9);
  static const Color grey400 = Color(0xFF8E97A3);
  static const Color grey500 = Color(0xFF5F6875);
  static const Color grey700 = Color(0xFF3A4049);
  static const Color grey900 = Color(0xFF1A1D22);

  // ===== Light theme =====
  static const Color lightBackground = Color(0xFFF7F8FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF1A1D22);
  static const Color lightBorder = Color(0xFFD9DDE3);

  // ===== Dark theme =====
  static const Color darkBackground = Color(0xFF0F1318);
  static const Color darkSurface = Color(0xFF1A1F26);
  static const Color darkOnSurface = Color(0xFFF2F4F7);
  static const Color darkBorder = Color(0xFF2C333D);

  // Semantic helpers
  static const Color success = emeraldTeal;
  static const Color error = Color(0xFFB00020); // system-standard error red
}