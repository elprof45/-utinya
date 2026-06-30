// lib/core/theme/app_typography.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// AfriBook Typography System
/// Display: Playfair Display (serif, narratif, élégant)
/// Body: DM Sans (propre, lisible)
/// Mono: DM Mono (code, citations techniques)
abstract class AppTypography {
  // ─── DISPLAY ──────────────────────────────────────────────────────────────
  static TextStyle get displayLarge => GoogleFonts.playfairDisplay(
        fontSize: 57.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        height: 1.12,
      );

  static TextStyle get displayMedium => GoogleFonts.playfairDisplay(
        fontSize: 45.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.16,
      );

  static TextStyle get displaySmall => GoogleFonts.playfairDisplay(
        fontSize: 36.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.22,
      );

  // ─── HEADLINE ─────────────────────────────────────────────────────────────
  static TextStyle get headlineLarge => GoogleFonts.playfairDisplay(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        height: 1.25,
      );

  static TextStyle get headlineMedium => GoogleFonts.playfairDisplay(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.29,
      );

  static TextStyle get headlineSmall => GoogleFonts.playfairDisplay(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.33,
      );

  // ─── TITLE ────────────────────────────────────────────────────────────────
  static TextStyle get titleLarge => GoogleFonts.dmSans(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.27,
      );

  static TextStyle get titleMedium => GoogleFonts.dmSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
      );

  static TextStyle get titleSmall => GoogleFonts.dmSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
      );

  // ─── BODY ─────────────────────────────────────────────────────────────────
  static TextStyle get bodyLarge => GoogleFonts.dmSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.6,
      );

  static TextStyle get bodyMedium => GoogleFonts.dmSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.57,
      );

  static TextStyle get bodySmall => GoogleFonts.dmSans(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.67,
      );

  // ─── LABEL ────────────────────────────────────────────────────────────────
  static TextStyle get labelLarge => GoogleFonts.dmSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
      );

  static TextStyle get labelMedium => GoogleFonts.dmSans(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.33,
      );

  static TextStyle get labelSmall => GoogleFonts.dmSans(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
      );

  // ─── SPECIAL ──────────────────────────────────────────────────────────────
  static TextStyle get quote => GoogleFonts.playfairDisplay(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        height: 1.8,
        letterSpacing: 0.2,
      );

  static TextStyle get proverb => GoogleFonts.playfairDisplay(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        height: 1.6,
        letterSpacing: 0.3,
      );

  static TextStyle get caption => GoogleFonts.dmSans(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.5,
      );

  static TextStyle get overline => GoogleFonts.dmSans(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
        height: 1.6,
      );

  static TextStyle get mono => GoogleFonts.dmMono(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.6,
      );

  // ─── THEME DATA ───────────────────────────────────────────────────────────
  static TextTheme get darkTextTheme => TextTheme(
        displayLarge:
            displayLarge.copyWith(color: AppColors.textPrimaryDark),
        displayMedium:
            displayMedium.copyWith(color: AppColors.textPrimaryDark),
        displaySmall:
            displaySmall.copyWith(color: AppColors.textPrimaryDark),
        headlineLarge:
            headlineLarge.copyWith(color: AppColors.textPrimaryDark),
        headlineMedium:
            headlineMedium.copyWith(color: AppColors.textPrimaryDark),
        headlineSmall:
            headlineSmall.copyWith(color: AppColors.textPrimaryDark),
        titleLarge:
            titleLarge.copyWith(color: AppColors.textPrimaryDark),
        titleMedium:
            titleMedium.copyWith(color: AppColors.textSecondaryDark),
        titleSmall:
            titleSmall.copyWith(color: AppColors.textSecondaryDark),
        bodyLarge: bodyLarge.copyWith(color: AppColors.textPrimaryDark),
        bodyMedium:
            bodyMedium.copyWith(color: AppColors.textSecondaryDark),
        bodySmall:
            bodySmall.copyWith(color: AppColors.textTertiaryDark),
        labelLarge:
            labelLarge.copyWith(color: AppColors.textPrimaryDark),
        labelMedium:
            labelMedium.copyWith(color: AppColors.textSecondaryDark),
        labelSmall:
            labelSmall.copyWith(color: AppColors.textTertiaryDark),
      );

  static TextTheme get lightTextTheme => TextTheme(
        displayLarge:
            displayLarge.copyWith(color: AppColors.textPrimaryLight),
        displayMedium:
            displayMedium.copyWith(color: AppColors.textPrimaryLight),
        displaySmall:
            displaySmall.copyWith(color: AppColors.textPrimaryLight),
        headlineLarge:
            headlineLarge.copyWith(color: AppColors.textPrimaryLight),
        headlineMedium:
            headlineMedium.copyWith(color: AppColors.textPrimaryLight),
        headlineSmall:
            headlineSmall.copyWith(color: AppColors.textPrimaryLight),
        titleLarge:
            titleLarge.copyWith(color: AppColors.textPrimaryLight),
        titleMedium:
            titleMedium.copyWith(color: AppColors.textSecondaryLight),
        titleSmall:
            titleSmall.copyWith(color: AppColors.textSecondaryLight),
        bodyLarge:
            bodyLarge.copyWith(color: AppColors.textPrimaryLight),
        bodyMedium:
            bodyMedium.copyWith(color: AppColors.textSecondaryLight),
        bodySmall:
            bodySmall.copyWith(color: AppColors.textTertiaryLight),
        labelLarge:
            labelLarge.copyWith(color: AppColors.textPrimaryLight),
        labelMedium:
            labelMedium.copyWith(color: AppColors.textSecondaryLight),
        labelSmall:
            labelSmall.copyWith(color: AppColors.textTertiaryLight),
      );
}
