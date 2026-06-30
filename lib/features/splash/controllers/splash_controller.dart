// lib/features/splash/controllers/splash_controller.dart

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:egliloo/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(milliseconds: 2500));

    final hasSeenOnboarding = _storage.read<bool>('hasSeenOnboarding') ?? false;
    final isLoggedIn = _storage.read<String?>('userId') != null;

    if (!hasSeenOnboarding) {
      Get.offAllNamed(Routes.onboarding);
    } else if (!isLoggedIn) {
      Get.offAllNamed(Routes.auth);
    } else {
      Get.offAllNamed(Routes.main);
    }
  }
}
