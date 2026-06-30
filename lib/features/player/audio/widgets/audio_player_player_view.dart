import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/app/widgets/safe_cached_network_image.dart';
import 'package:egliloo/features/player/audio/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'audio_player_controls.dart';
import 'audio_player_progress.dart';

class AudioPlayerPlayerView extends StatelessWidget {
  final AudioPlayerController controller;
  final VoidCallback onShowSpeedSheet;
  final VoidCallback onShowSleepSheet;
  final VoidCallback onShowLyrics;

  const AudioPlayerPlayerView({
    super.key,
    required this.controller,
    required this.onShowSpeedSheet,
    required this.onShowSleepSheet,
    required this.onShowLyrics,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppSpacing.xl),
            _buildCoverArt(),
            SizedBox(height: AppSpacing.xxl),
            _buildTitleSection(),
            SizedBox(height: AppSpacing.xl),
            AudioPlayerProgress(controller: controller),
            SizedBox(height: AppSpacing.xl),
            AudioPlayerControls(
              controller: controller,
              onShowSpeedSheet: onShowSpeedSheet,
              onShowSleepSheet: onShowSleepSheet,
              onShowLyrics: onShowLyrics,
            ),
            SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverArt() {
    return Container(
      constraints: BoxConstraints(maxWidth: 260.w, maxHeight: 260.w),
      decoration: BoxDecoration(
        borderRadius: AppRadius.lgAll,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: AppRadius.lgAll,
        child: Hero(
          tag: 'cover_${controller.content.value?.id}',
          child: SafeNetworkImage(
            imageUrl: controller.content.value?.coverImage ?? '',
            fit: BoxFit.cover,
            width: 260.w,
            height: 260.w,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          controller.content.value?.title ?? '',
          style: AppTypography.headlineSmall.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          controller.content.value?.authorName ?? '',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textTertiaryDark,
          ),
        ),
      ],
    );
  }
}
