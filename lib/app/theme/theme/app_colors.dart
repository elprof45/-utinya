import 'package:flutter/material.dart';

/// Warm African Tones — the Afrolore palette.
class AppColors {
  AppColors._();

  static const Color ochre = Color(0xFFD4AF37); // Primary
  static const Color terracotta = Color(0xFFC05A3E); // Secondary
  static const Color emerald = Color(0xFF0A5C36); // Accent
  static const Color espresso = Color(0xFF1E1611); // Dark background
  static const Color ivory = Color(0xFFFDFBF7); // Light background

  static const Color ochreLight = Color(0xFFE6C766);
  static const Color terracottaLight = Color(0xFFDD8467);
  static const Color emeraldLight = Color(0xFF1F7A4D);
  static const Color espressoLight = Color(0xFF2C2118);
  static const Color sand = Color(0xFFF3E9D8);
  static const Color clay = Color(0xFF8A3A23);

  static const Color textOnLight = Color(0xFF2C2118);
  static const Color textOnDark = Color(0xFFFDFBF7);
  static const Color mutedOnLight = Color(0xFF7A6C5D);
  static const Color mutedOnDark = Color(0xFFC9BBA8);

  /// Two-tone gradients used as illustrative cover placeholders.
  static const List<List<Color>> coverGradients = [
    [Color(0xFFD4AF37), Color(0xFFC05A3E)],
    [Color(0xFF0A5C36), Color(0xFF1E1611)],
    [Color(0xFFC05A3E), Color(0xFF6E1F12)],
    [Color(0xFFB8860B), Color(0xFF3E2C13)],
    [Color(0xFF1F7A4D), Color(0xFF0A5C36)],
    [Color(0xFFDD8467), Color(0xFF8A3A23)],
    [Color(0xFF6E4B2A), Color(0xFF1E1611)],
    [Color(0xFFE6C766), Color(0xFF9C6B1F)],
  ];

  static const List<Color> avatarColors = [
    Color(0xFFD4AF37),
    Color(0xFFC05A3E),
    Color(0xFF0A5C36),
    Color(0xFF8A3A23),
    Color(0xFF1F7A4D),
    Color(0xFFB8860B),
  ];

  static List<Color> gradientFor(int index) =>
      coverGradients[index % coverGradients.length];

  static Color avatarFor(int index) =>
      avatarColors[index % avatarColors.length];
}
