import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/models/user_model.dart';
import '../../../app/data/providers/mock_data_provider.dart';
import '../../../app/routes/app_routes.dart';

class ProfileController extends GetxController {
  final Rx<UserModel> user = UserModel(
    name: 'Amara Diallo',
    email: 'amara.diallo@example.com',
    avatarColorIndex: 1,
    interests: const ['West African Tales', 'Sahel History', 'Griot Songs & Poetry'],
    language: 'English',
    hoursListened: 18.5,
    storiesRead: 32,
    proverbsSaved: 47,
    videosWatched: 12,
    joinDate: 'March 2026',
    isAuthenticated: true,
  ).obs;

  final RxBool offlineDownloads = false.obs;
  final RxBool notificationsEnabled = true.obs;
  final RxBool isDarkMode = false.obs;
  final List<String> languages = MockDataProvider.languages;

  void toggleOffline(bool value) => offlineDownloads.value = value;
  void toggleNotifications(bool value) => notificationsEnabled.value = value;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void changeLanguage(String lang) {
    user.update((u) => u?.language = lang);
  }

  void logout() {
    Get.defaultDialog(
      title: 'Log out',
      middleText: 'Are you sure you want to log out of Afrolore?',
      textConfirm: 'Log out',
      textCancel: 'Cancel',
      onConfirm: () {
        Get.back();
        Get.offAllNamed(Routes.auth);
      },
    );
  }
}
