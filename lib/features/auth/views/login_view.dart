// lib/features/auth/views/login_view.dart

import 'package:egliloo/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimaryDark,
          ),
          onPressed: Get.back,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.xl),
            Text(
              'Connexion',
              style: AppTypography.headlineLarge.copyWith(
                color: AppColors.textPrimaryDark,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              'Bon retour parmi nous 👋',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondaryDark,
              ),
            ),
            SizedBox(height: AppSpacing.xxl),
            // Email field
            TextField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textPrimaryDark,
              ),
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.textTertiaryDark,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.base),
            // Password field
            Obx(
              () => TextField(
                controller: controller.passwordController,
                obscureText: controller.obscurePassword.value,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    color: AppColors.textTertiaryDark,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.obscurePassword.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textTertiaryDark,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Mot de passe oublié ?',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.xl),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.loginWithEmail,
                child: controller.isLoading.value
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Se connecter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
