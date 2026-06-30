import 'dart:ui';

import 'package:egliloo/app/widgets/safe_cached_network_image.dart';
import 'package:egliloo/features/player/audio/controllers/audio_player_controller.dart';
import 'package:flutter/material.dart';

class AudioPlayerBackground extends StatelessWidget {
  final AudioPlayerController controller;

  const AudioPlayerBackground({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final cover = controller.content.value?.coverImage;

    if (cover == null || cover.isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.2,
            child: SafeNetworkImage(imageUrl: cover, fit: BoxFit.cover),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xBB0C0C0C), Color(0xFF0C0C0C)],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}
