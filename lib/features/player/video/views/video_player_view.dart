// lib/features/player/video/views/video_player_view.dart

import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/data/models/content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({super.key});

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  ContentModel? content;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    content = Get.arguments as ContentModel?;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
    _initVideo();
  }

  Future<void> _initVideo() async {
    final url =
        content?.videoUrl ??
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
    _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
    await _videoController!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.primary,
        handleColor: AppColors.primary,
        backgroundColor: AppColors.waveformInactive,
        bufferedColor: AppColors.primaryLight,
      ),
    );
    if (mounted) setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: Get.back,
        ),
        title: Text(
          content?.title ?? 'Vidéo',
          style: AppTypography.titleMedium.copyWith(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        children: [
          // Video player
          AspectRatio(
            aspectRatio: 16 / 9,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : Chewie(controller: _chewieController!),
          ),
          // Content info
          Expanded(
            child: Container(
              color: AppColors.backgroundDark,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSpacing.base),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content?.title ?? '',
                      style: AppTypography.headlineSmall.copyWith(
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      content?.authorName ?? '',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                    SizedBox(height: AppSpacing.base),
                    Text(
                      content?.description ?? '',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondaryDark,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
