import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/features/player/audio/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AudioPlayerControls extends StatelessWidget {
  final AudioPlayerController controller;
  final VoidCallback onShowSpeedSheet;
  final VoidCallback onShowSleepSheet;
  final VoidCallback onShowLyrics;

  const AudioPlayerControls({
    super.key,
    required this.controller,
    required this.onShowSpeedSheet,
    required this.onShowSleepSheet,
    required this.onShowLyrics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ControlBtn(
              icon: Icons.replay_30_rounded,
              size: 32.sp,
              onTap: controller.skipBackward,
            ),
            Obx(
              () => GestureDetector(
                onTap: controller.togglePlay,
                child: Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.goldGradient,
                  ),
                  child: Center(
                    child: controller.isLoading.value
                        ? SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            controller.isPlaying.value
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 38.sp,
                          ),
                  ),
                ),
              ),
            ),
            _ControlBtn(
              icon: Icons.forward_30_rounded,
              size: 32.sp,
              onTap: controller.skipForward,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(
              () => GestureDetector(
                onTap: onShowSpeedSheet,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark2,
                    borderRadius: AppRadius.fullAll,
                  ),
                  child: Text(
                    '${controller.playbackSpeed.value}x',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => _ControlBtn(
                icon: Icons.lyrics_outlined,
                color: controller.showLyrics.value
                    ? AppColors.primary
                    : AppColors.textTertiaryDark,
                onTap: onShowLyrics,
              ),
            ),
            _ControlBtn(icon: Icons.bedtime_outlined, onTap: onShowSleepSheet),
            _ControlBtn(icon: Icons.playlist_add_rounded, onTap: () {}),
          ],
        ),
      ],
    );
  }
}

class _ControlBtn extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;
  final Color color;

  const _ControlBtn({
    required this.icon,
    this.size = 26,
    required this.onTap,
    this.color = AppColors.textSecondaryDark,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color, size: size),
      onPressed: onTap,
    );
  }
}
