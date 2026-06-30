// lib/core/theme/app_theme.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'app_typography.dart';

// ─── SPACING ────────────────────────────────────────────────────────────────
abstract class AppSpacing {
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 12.w;
  static double get base => 16.w;
  static double get lg => 20.w;
  static double get xl => 24.w;
  static double get xxl => 32.w;
  static double get xxxl => 40.w;
  static double get huge => 48.w;
  static double get massive => 64.w;

  static EdgeInsets get screenPadding => EdgeInsets.symmetric(horizontal: base);
  static EdgeInsets get cardPadding => EdgeInsets.all(base);
  static EdgeInsets get sectionPadding =>
      EdgeInsets.symmetric(vertical: xl, horizontal: base);
}

// ─── RADIUS ─────────────────────────────────────────────────────────────────
abstract class AppRadius {
  static double get xs => 4.r;
  static double get sm => 8.r;
  static double get md => 12.r;
  static double get base => 16.r;
  static double get lg => 20.r;
  static double get xl => 24.r;
  static double get xxl => 32.r;
  static double get full => 999.r;

  static BorderRadius get xsAll => BorderRadius.circular(xs);
  static BorderRadius get smAll => BorderRadius.circular(sm);
  static BorderRadius get mdAll => BorderRadius.circular(md);
  static BorderRadius get baseAll => BorderRadius.circular(base);
  static BorderRadius get lgAll => BorderRadius.circular(lg);
  static BorderRadius get xlAll => BorderRadius.circular(xl);
  static BorderRadius get xxlAll => BorderRadius.circular(xxl);
  static BorderRadius get fullAll => BorderRadius.circular(full);

  static BorderRadius get topOnly => BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );
}

// ─── ELEVATION / SHADOWS ────────────────────────────────────────────────────
abstract class AppElevation {
  static List<BoxShadow> get sm => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.15),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get md => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get lg => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.25),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get xl => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      blurRadius: 40,
      offset: const Offset(0, 12),
    ),
  ];

  static List<BoxShadow> get gold => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.3),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get glow => [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.4),
      blurRadius: 30,
      spreadRadius: 5,
    ),
  ];
}

// ─── ANIMATION DURATIONS ────────────────────────────────────────────────────
abstract class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration verySlow = Duration(milliseconds: 600);
  static const Duration page = Duration(milliseconds: 350);
}

// ─── MAIN THEME ─────────────────────────────────────────────────────────────
abstract class AppTheme {
  static ThemeData get dark => _buildTheme(isDark: true);
  static ThemeData get light => _buildTheme(isDark: false);

  static ThemeData _buildTheme({required bool isDark}) {
    final colors = isDark ? _darkColorScheme : _lightColorScheme;
    final textTheme = isDark
        ? AppTypography.darkTextTheme
        : AppTypography.lightTextTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: colors,
      textTheme: textTheme,
      scaffoldBackgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: isDark
            ? AppTypography.titleLarge.copyWith(
                color: AppColors.textPrimaryDark,
              )
            : AppTypography.titleLarge.copyWith(
                color: AppColors.textPrimaryLight,
              ),
        iconTheme: IconThemeData(
          color: isDark
              ? AppColors.textPrimaryDark
              : AppColors.textPrimaryLight,
        ),
      ),
      // Bottom Nav
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark
            ? AppColors.surfaceDark
            : AppColors.surfaceLight,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: isDark
            ? AppColors.textTertiaryDark
            : AppColors.textTertiaryLight,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.labelSmall,
      ),
      // Cards
      cardTheme: CardThemeData(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.baseAll),
        margin: EdgeInsets.zero,
      ),
      // Divider
      dividerTheme: DividerThemeData(
        color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
        thickness: 1,
        space: 1,
      ),
      // Icon
      iconTheme: IconThemeData(
        color: isDark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
        size: 24,
      ),
      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.surfaceDark2 : AppColors.surfaceLight2,
        border: OutlineInputBorder(
          borderRadius: AppRadius.baseAll,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.baseAll,
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.baseAll,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: isDark
              ? AppColors.textTertiaryDark
              : AppColors.textTertiaryLight,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.md,
        ),
      ),
      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.baseAll),
          textStyle: AppTypography.labelLarge,
          minimumSize: Size(double.infinity, 52.h),
        ),
      ),
      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.baseAll),
          textStyle: AppTypography.labelLarge,
          minimumSize: Size(double.infinity, 52.h),
        ),
      ),
      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.labelLarge,
        ),
      ),
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: isDark
            ? AppColors.surfaceDark2
            : AppColors.surfaceLight2,
        selectedColor: AppColors.primarySurface,
        labelStyle: AppTypography.labelSmall.copyWith(
          color: isDark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.fullAll),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),
      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: isDark
            ? AppColors.surfaceDark3
            : AppColors.surfaceLight2,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withValues(alpha: 0.1),
        trackHeight: 3,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
      ),
      // Page Transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static ColorScheme get _darkColorScheme => const ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primarySurface,
    onPrimaryContainer: AppColors.primaryLight,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    secondaryContainer: AppColors.secondarySurface,
    onSecondaryContainer: AppColors.secondaryLight,
    tertiary: AppColors.accent,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    surfaceContainerHighest: AppColors.surfaceDark2,
    onSurfaceVariant: AppColors.textSecondaryDark,
    error: AppColors.error,
    onError: Colors.white,
    outline: AppColors.borderDark,
    outlineVariant: AppColors.dividerDark,
    shadow: Colors.black,
  );

  static ColorScheme get _lightColorScheme => const ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFFFF3E0),
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFE8F5E9),
    onSecondaryContainer: AppColors.secondaryDark,
    tertiary: AppColors.accent,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    surfaceContainerHighest: AppColors.surfaceLight2,
    onSurfaceVariant: AppColors.textSecondaryLight,
    error: AppColors.error,
    onError: Colors.white,
    outline: AppColors.borderLight,
    outlineVariant: AppColors.dividerLight,
  );
}
