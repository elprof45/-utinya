import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(
    brightness: Brightness.light,
    scaffoldBg: AppColors.ivory,
    surface: AppColors.ivory,
    cardBg: Colors.white,
    textColor: AppColors.textOnLight,
    mutedColor: AppColors.mutedOnLight,
    chipBg: AppColors.sand,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    scaffoldBg: AppColors.espresso,
    surface: AppColors.espressoLight,
    cardBg: AppColors.espressoLight,
    textColor: AppColors.textOnDark,
    mutedColor: AppColors.mutedOnDark,
    chipBg: AppColors.espressoLight,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color scaffoldBg,
    required Color surface,
    required Color cardBg,
    required Color textColor,
    required Color mutedColor,
    required Color chipBg,
  }) {
    final base = ThemeData(brightness: brightness, useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: scaffoldBg,
      primaryColor: AppColors.ochre,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.ochre,
        brightness: brightness,
        primary: AppColors.ochre,
        secondary: AppColors.terracotta,
        tertiary: AppColors.emerald,
        surface: surface,
      ),
      cardColor: cardBg,
      dividerColor: AppColors.ochre.withValues(alpha: 0.18),
      splashColor: AppColors.ochre.withValues(alpha: 0.15),
      highlightColor: AppColors.ochre.withValues(alpha: 0.08),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBg,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: textColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
        headlineMedium: TextStyle(
          color: textColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(color: textColor, fontSize: 15, height: 1.5),
        bodyMedium: TextStyle(color: mutedColor, fontSize: 14, height: 1.45),
        bodySmall: TextStyle(color: mutedColor, fontSize: 12),
        labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: chipBg,
        selectedColor: AppColors.ochre,
        labelStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.ochre.withValues(alpha: 0.35)),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: scaffoldBg,
        selectedItemColor: AppColors.terracotta,
        unselectedItemColor: mutedColor,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        elevation: 12,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.terracotta,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          elevation: 0,
        ),
      ),
      iconTheme: IconThemeData(color: textColor),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.terracotta,
        inactiveTrackColor: AppColors.terracotta.withValues(alpha: 0.2),
        thumbColor: AppColors.ochre,
        overlayColor: AppColors.ochre.withValues(alpha: 0.2),
        trackHeight: 3,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.ochre
              : mutedColor,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.terracotta.withValues(alpha: 0.5)
              : chipBg,
        ),
      ),
    );
  }
}
