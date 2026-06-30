// lib/features/player/audio/controllers/audio_player_controller.dart

import 'package:egliloo/data/models/content_model.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerController extends GetxController {
  final _player = AudioPlayer();
  final content = Rxn<ContentModel>();
  final isPlaying = false.obs;
  final isLoading = true.obs;
  final position = Duration.zero.obs;
  final duration = Duration.zero.obs;
  final playbackSpeed = 1.0.obs;
  final sleepTimerMinutes = 0.obs;
  final currentSyncIndex = (-1).obs;
  final showLyrics = false.obs;

  final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
  final sleepOptions = [0, 5, 10, 15, 30, 60];

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is ContentModel) {
      content.value = arg;
      _initPlayer();
    }
    _player.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      isLoading.value =
          state.processingState == ProcessingState.loading ||
          state.processingState == ProcessingState.buffering;
    });
    _player.positionStream.listen((p) => position.value = p);
    _player.durationStream.listen((d) {
      if (d != null) duration.value = d;
    });
  }

  Future<void> _initPlayer() async {
    isLoading.value = true;
    try {
      final url = content.value?.audioUrl;
      if (url != null) {
        await _player.setUrl(url);
      }
    } catch (_) {}
    isLoading.value = false;
  }

  void togglePlay() {
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  void seek(Duration pos) => _player.seek(pos);

  void skipForward() =>
      _player.seek(Duration(seconds: position.value.inSeconds + 30));

  void skipBackward() => _player.seek(
    Duration(seconds: (position.value.inSeconds - 15).clamp(0, 999999)),
  );

  void setSpeed(double speed) {
    playbackSpeed.value = speed;
    _player.setSpeed(speed);
  }

  void setSleepTimer(int minutes) {
    sleepTimerMinutes.value = minutes;
    if (minutes > 0) {
      Future.delayed(Duration(minutes: minutes), () {
        if (!isClosed) _player.pause();
      });
    }
  }

  void toggleLyrics() => showLyrics.toggle();

  double get progress {
    if (duration.value.inMilliseconds == 0) return 0;
    return position.value.inMilliseconds / duration.value.inMilliseconds;
  }

  String formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }
}
