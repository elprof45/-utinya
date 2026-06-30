// lib/core/theme/app_colors.dart

import 'package:flutter/material.dart';

/// AfriBook Design System - Palette Africaine
/// Inspirée des terres, mineraux et paysages d'Afrique
abstract class AppColors {
  // ─── PRIMARY ──────────────────────────────────────────────────────────────
  // Or ancien / Bronze Ashanti
  static const Color primary = Color(0xFFD4943A);
  static const Color primaryLight = Color(0xFFEDB96A);
  static const Color primaryDark = Color(0xFF9E6B1F);
  static const Color primarySurface = Color(0xFF2D200A);

  // ─── SECONDARY ────────────────────────────────────────────────────────────
  // Vert forêt du Congo
  static const Color secondary = Color(0xFF2D6A4F);
  static const Color secondaryLight = Color(0xFF52B788);
  static const Color secondaryDark = Color(0xFF1B4332);
  static const Color secondarySurface = Color(0xFF0A1F15);

  // ─── ACCENT ───────────────────────────────────────────────────────────────
  // Terre rouge / Ocre
  static const Color accent = Color(0xFFC1440E);
  static const Color accentLight = Color(0xFFE07050);
  static const Color accentDark = Color(0xFF8B2E08);

  // ─── BACKGROUNDS ──────────────────────────────────────────────────────────
  // Noir profond - peau de nuit africaine
  static const Color backgroundDark = Color(0xFF0C0C0C);
  static const Color backgroundDark2 = Color(0xFF141414);
  static const Color backgroundLight = Color(0xFFF5EFE6);
  static const Color backgroundLight2 = Color(0xFFFAF7F2);

  // ─── SURFACE ──────────────────────────────────────────────────────────────
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color surfaceDark2 = Color(0xFF242424);
  static const Color surfaceDark3 = Color(0xFF2E2E2E);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceLight2 = Color(0xFFF0EBE3);

  // ─── TEXT ─────────────────────────────────────────────────────────────────
  static const Color textPrimaryDark = Color(0xFFF5EFE6);
  static const Color textSecondaryDark = Color(0xFFB8A99A);
  static const Color textTertiaryDark = Color(0xFF7A6C60);
  static const Color textPrimaryLight = Color(0xFF1A1008);
  static const Color textSecondaryLight = Color(0xFF5C4A38);
  static const Color textTertiaryLight = Color(0xFF8C7A68);

  // ─── SEMANTIC ─────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF40916C);
  static const Color successSurface = Color(0xFF0D2B1E);
  static const Color warning = Color(0xFFE9C46A);
  static const Color warningSurface = Color(0xFF2D2410);
  static const Color error = Color(0xFFE63946);
  static const Color errorSurface = Color(0xFF2D0A0C);
  static const Color info = Color(0xFF4895EF);
  static const Color infoSurface = Color(0xFF0A1A2D);

  // ─── SPECIAL ──────────────────────────────────────────────────────────────
  // Or pour badges et éléments premium
  static const Color gold = Color(0xFFFFD700);
  static const Color goldDark = Color(0xFFB8860B);
  static const Color silver = Color(0xFFC0C0C0);
  static const Color bronze = Color(0xFFCD7F32);

  // Dégradés thématiques
  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF8B2E08), Color(0xFFD4943A), Color(0xFFE9C46A)],
  );

  static const LinearGradient forestGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1B4332), Color(0xFF2D6A4F), Color(0xFF52B788)],
  );

  static const LinearGradient nightGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0C0C0C), Color(0xFF1A1008)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF9E6B1F), Color(0xFFD4943A), Color(0xFFEDB96A)],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xCC0C0C0C)],
  );

  // ─── DIVIDERS & BORDERS ───────────────────────────────────────────────────
  static const Color dividerDark = Color(0xFF2A2A2A);
  static const Color dividerLight = Color(0xFFE0D5C8);
  static const Color borderDark = Color(0xFF333333);
  static const Color borderLight = Color(0xFFD0C4B4);

  // ─── OVERLAYS ─────────────────────────────────────────────────────────────
  static const Color overlayDark = Color(0xBB000000);
  static const Color overlayMedium = Color(0x88000000);
  static const Color overlayLight = Color(0x44000000);

  // ─── PLAYER ───────────────────────────────────────────────────────────────
  static const Color waveformActive = primary;
  static const Color waveformInactive = Color(0xFF3A3A3A);
  static const Color playerBackground = Color(0xFF0F0A04);
}
