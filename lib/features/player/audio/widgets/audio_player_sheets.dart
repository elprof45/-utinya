import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/features/player/audio/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioPlayerSheets {
  static void showSpeedSheet(AudioPlayerController controller) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: AppRadius.topOnly,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vitesse de lecture',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.textPrimaryDark,
              ),
            ),
            SizedBox(height: AppSpacing.base),
            ...controller.speeds.map(
              (speed) => ListTile(
                title: Text(
                  '${speed}x',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                trailing: Obx(
                  () => controller.playbackSpeed.value == speed
                      ? const Icon(
                          Icons.check_rounded,
                          color: AppColors.primary,
                        )
                      : const SizedBox.shrink(),
                ),
                onTap: () {
                  controller.setSpeed(speed);
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showSleepSheet(AudioPlayerController controller) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: AppRadius.topOnly,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Minuteur de sommeil',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.textPrimaryDark,
              ),
            ),
            SizedBox(height: AppSpacing.base),
            ...controller.sleepOptions.map(
              (minutes) => ListTile(
                title: Text(
                  minutes == 0 ? 'Désactivé' : '$minutes minutes',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                trailing: Obx(
                  () => controller.sleepTimerMinutes.value == minutes
                      ? const Icon(
                          Icons.check_rounded,
                          color: AppColors.primary,
                        )
                      : const SizedBox.shrink(),
                ),
                onTap: () {
                  controller.setSleepTimer(minutes);
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showOptionsSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: AppRadius.topOnly,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _SheetOption(icon: Icons.download_outlined, label: 'Télécharger'),
            _SheetOption(icon: Icons.share_outlined, label: 'Partager'),
            _SheetOption(
              icon: Icons.playlist_add_rounded,
              label: 'Ajouter à une playlist',
            ),
            _SheetOption(icon: Icons.report_outlined, label: 'Signaler'),
          ],
        ),
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SheetOption({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondaryDark),
      title: Text(
        label,
        style: AppTypography.bodyLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
      ),
      onTap: Get.back,
    );
  }
}
