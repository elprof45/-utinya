import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/detail/controllers/detail_controller.dart';
import '../theme/app_colors.dart';

class AudioPlayerWidget extends StatelessWidget {
  final DetailController controller;
  const AudioPlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Theme.of(context).cardColor,
        border: Border.all(color: AppColors.ochre.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: AppColors.espresso.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.terracotta, AppColors.ochre],
                  ),
                ),
                child: const Icon(
                  Icons.graphic_eq_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(
                  () => Text(
                    controller.isPlaying.value
                        ? 'Now narrating…'
                        : 'Tap play to listen',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: controller.cycleSpeed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.ochre.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${controller.speed.value}x',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.terracotta,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Obx(
            () => SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 3,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
              ),
              child: Slider(
                value: controller.progress.value.clamp(0.0, 1.0),
                onChanged: controller.seekTo,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.formatTime(controller.elapsedSeconds.value),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    controller.formatTime(controller.totalSeconds),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => controller.skip(-15),
                icon: const Icon(Icons.replay_rounded, size: 26),
                color: AppColors.terracotta,
              ),
              const SizedBox(width: 8),
              Obx(
                () => Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.terracotta, AppColors.ochre],
                    ),
                  ),
                  child: IconButton(
                    onPressed: controller.togglePlay,
                    icon: Icon(
                      controller.isPlaying.value
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => controller.skip(15),
                icon: const Icon(Icons.forward_rounded, size: 26),
                color: AppColors.terracotta,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
