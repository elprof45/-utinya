import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/features/player/audio/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AudioPlayerProgress extends StatelessWidget {
  final AudioPlayerController controller;

  const AudioPlayerProgress({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            final box = context.findRenderObject() as RenderBox?;
            if (box == null) return;

            final x = (details.localPosition.dx / box.size.width).clamp(
              0.0,
              1.0,
            );
            final newPosition = Duration(
              milliseconds: (x * controller.duration.value.inMilliseconds)
                  .toInt(),
            );
            controller.seek(newPosition);
          },
          child: Obx(
            () => Column(
              children: [
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppColors.primary,
                    inactiveTrackColor: AppColors.waveformInactive,
                    thumbColor: AppColors.primary,
                    overlayColor: AppColors.primary.withValues(alpha: 0.1),
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                  ),
                  child: Slider(
                    value: controller.progress.clamp(0.0, 1.0),
                    onChanged: (value) => controller.seek(
                      Duration(
                        milliseconds:
                            (value * controller.duration.value.inMilliseconds)
                                .toInt(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(50, (index) {
                      final isActive = index / 50 <= controller.progress;
                      final height =
                          (5 +
                                  (index % 7 == 0
                                      ? 28
                                      : index % 5 == 0
                                      ? 20
                                      : index % 3 == 0
                                      ? 14
                                      : 8))
                              .toDouble();
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          width: 3.w,
                          height: height.h,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.primary
                                : AppColors.waveformInactive,
                            borderRadius: AppRadius.fullAll,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.formatDuration(controller.position.value),
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiaryDark,
                ),
              ),
              Text(
                controller.formatDuration(controller.duration.value),
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiaryDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
