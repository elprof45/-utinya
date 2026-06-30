import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final _box = GetStorage();
  final isDarkMode = true.obs;
  final selectedLanguage = 'fr'.obs;
  final notificationsEnabled = true.obs;
  final dailyProverbEnabled = true.obs;
  final downloadWifiOnly = true.obs;
  final audioQuality = 'Haute'.obs;
  final videoQuality = '720p'.obs;
  final playbackSpeed = 1.0.obs;
  final fontSize = 16.0.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _box.read('isDark') ?? true;
    selectedLanguage.value = _box.read('lang') ?? 'fr';
  }

  void toggleDarkMode() {
    isDarkMode.toggle();
    _box.write('isDark', isDarkMode.value);
  }

  void toggleNotifications() => notificationsEnabled.toggle();
  void toggleDailyProverb() => dailyProverbEnabled.toggle();
  void toggleWifi() => downloadWifiOnly.toggle();
  void setAudioQuality(String q) => audioQuality.value = q;
  void setVideoQuality(String q) => videoQuality.value = q;
}
