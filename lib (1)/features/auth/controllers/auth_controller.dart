import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isLoginMode = true.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool isLoading = false.obs;

  void toggleMode() => isLoginMode.value = !isLoginMode.value;
  void toggleObscure() => obscurePassword.value = !obscurePassword.value;

  void skipForNow() => Get.offAllNamed(Routes.main);

  Future<void> submit() async {
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'Missing information',
        'Please fill in both email and password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 900));
    isLoading.value = false;
    Get.snackbar(
      'Welcome to Afrolore',
      isLoginMode.value ? 'Logged in successfully.' : 'Account created successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.offAllNamed(Routes.main);
  }

  Future<void> socialLogin(String provider) async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 700));
    isLoading.value = false;
    Get.snackbar(
      'Welcome to Afrolore',
      'Signed in with $provider.',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.offAllNamed(Routes.main);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
