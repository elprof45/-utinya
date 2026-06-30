// lib/features/auth/controllers/auth_controller.dart

import 'package:egliloo/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  void togglePasswordVisibility() => obscurePassword.toggle();

  Future<void> loginWithEmail() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez remplir tous les champs',
        backgroundColor: const Color(0xFF2D0A0C),
        colorText: Colors.white,
      );
      return;
    }
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    _saveAndNavigate('user_demo_001');
    isLoading.value = false;
  }

  Future<void> loginWithGoogle() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    _saveAndNavigate('user_google_001');
    isLoading.value = false;
  }

  Future<void> loginWithPhone() async {
    if (phoneController.text.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer votre numéro',
        backgroundColor: const Color(0xFF2D0A0C),
        colorText: Colors.white,
      );
      return;
    }
    Get.toNamed(Routes.otp, arguments: phoneController.text);
  }

  Future<void> verifyOtp() async {
    if (otpController.text.length < 6) return;
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    _saveAndNavigate('user_phone_001');
    isLoading.value = false;
  }

  Future<void> register() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    _saveAndNavigate('user_new_001');
    isLoading.value = false;
  }

  void continueWithoutAccount() {
    _saveAndNavigate(null);
  }

  void _saveAndNavigate(String? userId) {
    if (userId != null) {
      _storage.write('userId', userId);
    }
    Get.offAllNamed(Routes.main);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
