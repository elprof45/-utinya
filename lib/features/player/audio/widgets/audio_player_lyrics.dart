// lib/features/player/audio/widgets/audio_player_lyrics.dart
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/features/player/audio/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AudioPlayerLyrics extends StatelessWidget {
  final AudioPlayerController controller;

  const AudioPlayerLyrics({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const sampleLyrics = [
      'Il y a très longtemps, bien avant que',
      "les hommes n'apprennent à forger le fer",
      'ou à tisser le coton, la nuit était',
      'absolument noire...',
      '',
      'Pas une étoile, pas une lune.',
      'Seul le soleil régnait, mais il se couchait',
      'tôt, laissant le monde dans une',
      'obscurité totale.',
    ];

    // ✅ CORRECTION 1 : Suppression de l'Obx global au sommet de la ListView
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xl,
      ),
      itemCount: sampleLyrics.length,
      itemBuilder: (_, index) {
        // ✅ CORRECTION 2 : On place l'Obx uniquement autour du composant de texte réactif
        return Obx(() {
          final isActive = index == controller.currentSyncIndex.value;

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: isActive
                  ? AppTypography.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    )
                  : AppTypography.bodyLarge.copyWith(
                      color: AppColors.textTertiaryDark,
                    ),
              child: Text(sampleLyrics[index], textAlign: TextAlign.center),
            ),
          );
        });
      },
    );
  }
}
