import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/features/player/audio/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioPlayerTopBar extends StatelessWidget {
  final AudioPlayerController controller;
  final VoidCallback onMorePressed;

  const AudioPlayerTopBar({
    super.key,
    required this.controller,
    required this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
              size: 28,
            ),
            onPressed: Get.back,
          ),
          const Spacer(),
          Obx(
            () => Text(
              controller.content.value?.typeLabel.toUpperCase() ?? '',
              style: AppTypography.overline.copyWith(
                color: AppColors.textSecondaryDark,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.more_horiz_rounded, color: Colors.white),
            onPressed: onMorePressed,
          ),
        ],
      ),
    );
  }
}
