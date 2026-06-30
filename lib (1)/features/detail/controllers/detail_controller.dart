import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/models/comment_model.dart';
import '../../../app/data/models/content_model.dart';
import '../../../app/data/providers/mock_data_provider.dart';

class DetailController extends GetxController {
  late final Rx<ContentModel> content;

  final PageController mediaController = PageController();
  final RxInt currentMediaIndex = 0.obs;

  final RxBool isPlaying = false.obs;
  final RxDouble progress = 0.0.obs; // 0..1
  final RxInt elapsedSeconds = 0.obs;
  final RxDouble speed = 1.0.obs;
  final List<double> speedSteps = const [0.75, 1.0, 1.25, 1.5, 2.0];
  Timer? _ticker;

  final RxBool isLiked = false.obs;
  final RxBool isBookmarked = false.obs;
  final RxBool isSubscribed = false.obs;

  final RxList<CommentModel> comments = <CommentModel>[].obs;
  final TextEditingController commentInput = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    final ContentModel initial = arg is ContentModel ? arg : MockDataProvider.allContent.first;
    content = initial.obs;
    isLiked.value = initial.isLiked;
    isBookmarked.value = initial.isBookmarked;
    isSubscribed.value = initial.author.isSubscribed;
    comments.value = MockDataProvider.commentsFor(initial.id);
  }

  int get totalSeconds => content.value.durationSeconds == 0 ? 240 : content.value.durationSeconds;

  List<String> get mediaFrames =>
      content.value.mediaLabels.isEmpty ? [content.value.title] : content.value.mediaLabels;

  void onMediaPageChanged(int i) => currentMediaIndex.value = i;

  void togglePlay() {
    isPlaying.value = !isPlaying.value;
    if (isPlaying.value) {
      _startTicker();
    } else {
      _ticker?.cancel();
    }
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (elapsedSeconds.value >= totalSeconds) {
        isPlaying.value = false;
        _ticker?.cancel();
        return;
      }
      final step = speed.value.round().clamp(1, 4);
      elapsedSeconds.value = (elapsedSeconds.value + step).clamp(0, totalSeconds);
      progress.value = (elapsedSeconds.value / totalSeconds).clamp(0.0, 1.0);
    });
  }

  void seekTo(double value) {
    progress.value = value;
    elapsedSeconds.value = (value * totalSeconds).round();
  }

  void skip(int seconds) {
    elapsedSeconds.value = (elapsedSeconds.value + seconds).clamp(0, totalSeconds);
    progress.value = totalSeconds == 0 ? 0 : elapsedSeconds.value / totalSeconds;
  }

  void cycleSpeed() {
    final idx = speedSteps.indexOf(speed.value);
    speed.value = speedSteps[(idx + 1) % speedSteps.length];
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
    content.update((c) {
      if (c != null) {
        c.likes += isLiked.value ? 1 : -1;
      }
    });
  }

  void toggleBookmark() => isBookmarked.value = !isBookmarked.value;

  void toggleSubscribe() {
    isSubscribed.value = !isSubscribed.value;
    content.update((c) {
      c?.author.isSubscribed = isSubscribed.value;
    });
  }

  void addComment() {
    final text = commentInput.text.trim();
    if (text.isEmpty) return;
    final newComment = MockDataProvider.addComment(content.value.id, text);
    comments.insert(0, newComment);
    content.update((c) => c?.commentsCount += 1);
    commentInput.clear();
  }

  void refreshCommentCount(int count) {
    content.update((c) => c?.commentsCount = count);
    comments.value = MockDataProvider.commentsFor(content.value.id);
  }

  String formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _ticker?.cancel();
    mediaController.dispose();
    commentInput.dispose();
    super.onClose();
  }
}
