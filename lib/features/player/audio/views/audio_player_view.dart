// lib/features/player/audio/views/audio_player_view.dart

import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/features/player/audio/controllers/audio_player_controller.dart';
import 'package:egliloo/features/player/audio/widgets/audio_player_background.dart';
import 'package:egliloo/features/player/audio/widgets/audio_player_lyrics.dart';
import 'package:egliloo/features/player/audio/widgets/audio_player_player_view.dart';
import 'package:egliloo/features/player/audio/widgets/audio_player_sheets.dart';
import 'package:egliloo/features/player/audio/widgets/audio_player_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioPlayerView extends StatefulWidget {
  const AudioPlayerView({super.key});

  @override
  State<AudioPlayerView> createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  late final AudioPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AudioPlayerController());
  }

  @override
  void dispose() {
    Get.delete<AudioPlayerController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.playerBackground,
      body: Stack(
        children: [
          AudioPlayerBackground(controller: controller),
          SafeArea(
            child: Column(
              children: [
                AudioPlayerTopBar(
                  controller: controller,
                  onMorePressed: AudioPlayerSheets.showOptionsSheet,
                ),
                Expanded(
                  // ✅ CORRECTION : Obx doit uniquement écouter la condition du changement de vue
                  child: Obx(() {
                    final displayLyrics = controller.showLyrics.value;

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      child: displayLyrics
                          ? AudioPlayerLyrics(
                              key: const ValueKey('lyrics'),
                              controller: controller,
                            )
                          : AudioPlayerPlayerView(
                              key: const ValueKey('player'),
                              controller: controller,
                              onShowSpeedSheet: () =>
                                  AudioPlayerSheets.showSpeedSheet(controller),
                              onShowSleepSheet: () =>
                                  AudioPlayerSheets.showSleepSheet(controller),
                              onShowLyrics: controller.toggleLyrics,
                            ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
