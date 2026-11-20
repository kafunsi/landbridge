import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppTheme {
  AppTheme._();

  static TextTheme _textTheme(Color onSurface) {
    final base = GoogleFonts.interTextTheme();
    return base
        .apply(bodyColor: onSurface, displayColor: onSurface)
        .copyWith(
          headlineLarge: base.headlineLarge?.copyWith(
              fontWeight: FontWeight.w700, color: onSurface),
          headlineMedium: base.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700, color: onSurface),
          titleLarge: base.titleLarge?.copyWith(
              fontWeight: FontWeight.w700, color: onSurface),
          titleMedium: base.titleMedium?.copyWith(
              fontWeight: FontWeight.w600, color: onSurface),
          bodyLarge: base.bodyLarge?.copyWith(color: onSurface),
          bodyMedium: base.bodyMedium?.copyWith(color: onSurface),
          labelLarge: base.labelLarge?.copyWith(
              fontWeight: FontWeight.w600, color: onSurface),
        );
  }

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.royalBlue,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.royalBlue,
      onPrimary: AppColors.white,
      secondary: AppColors.emeraldTeal,
      onSecondary: AppColors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: _textTheme(AppColors.lightOnSurface),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.lightOnSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: AppColors.lightOnSurface,
        ),
      ),
      inputDecorationTheme: _inputTheme(
        fill: AppColors.grey50,
        border: AppColors.lightBorder,
        onSurface: AppColors.lightOnSurface,
      ),
      elevatedButtonTheme: _elevatedButtonTheme(AppColors.royalBlue),
      outlinedButtonTheme: _outlinedButtonTheme(AppColors.royalBlue),
      textButtonTheme: _textButtonTheme(AppColors.royalBlue),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          side: const BorderSide(color: AppColors.lightBorder),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.grey900,
        contentTextStyle: GoogleFonts.inter(color: AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.royalBlue,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.royalBlueLight,
      onPrimary: AppColors.white,
      secondary: AppColors.emeraldTealLight,
      onSecondary: AppColors.black,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      error: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: _textTheme(AppColors.darkOnSurface),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkOnSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: AppColors.darkOnSurface,
        ),
      ),
      inputDecorationTheme: _inputTheme(
        fill: AppColors.darkSurface,
        border: AppColors.darkBorder,
        onSurface: AppColors.darkOnSurface,
      ),
      elevatedButtonTheme: _elevatedButtonTheme(AppColors.royalBlueLight,
          foreground: AppColors.black),
      outlinedButtonTheme: _outlinedButtonTheme(AppColors.royalBlueLight),
      textButtonTheme: _textButtonTheme(AppColors.royalBlueLight),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.grey200,
        contentTextStyle: GoogleFonts.inter(color: AppColors.grey900),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
      ),
    );
  }

  // ---- helper builders ----

  static InputDecorationTheme _inputTheme({
    required Color fill,
    required Color border,
    required Color onSurface,
  }) {
    final radius = BorderRadius.circular(AppSizes.radiusMd);
    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.md,
      ),
      hintStyle: GoogleFonts.inter(
        color: onSurface.withValues(alpha: 0.5),
        fontSize: 14,
      ),
      labelStyle: GoogleFonts.inter(
        color: onSurface.withValues(alpha: 0.7),
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: AppColors.royalBlue, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: AppColors.error, width: 1.6),
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(
    Color bg, {
    Color foreground = AppColors.white,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: foreground,
        minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(Color fg) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: fg,
        minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
        side: BorderSide(color: fg, width: 1.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(Color fg) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: fg,
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}