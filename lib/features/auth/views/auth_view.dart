// lib/features/auth/views/auth_view.dart

import 'package:egliloo/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1A0F04), Color(0xFF0C0C0C)],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60.h),
                  // Logo
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.goldGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'A',
                        style: AppTypography.headlineLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.xl),
                  Text(
                    'Bienvenue sur AfriBook',
                    style: AppTypography.headlineMedium.copyWith(
                      color: AppColors.textPrimaryDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    'Le patrimoine culturel africain à portée de main.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondaryDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48.h),
                  // Social buttons
                  _SocialButton(
                    icon: Icons.g_mobiledata_rounded,
                    label: 'Continuer avec Google',
                    onTap: controller.loginWithGoogle,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  _SocialButton(
                    icon: Icons.phone_rounded,
                    label: 'Continuer avec le téléphone',
                    onTap: () => Get.toNamed(Routes.login, arguments: 'phone'),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  _SocialButton(
                    icon: Icons.email_outlined,
                    label: 'Continuer avec l\'email',
                    onTap: () => Get.toNamed(Routes.login),
                  ),
                  SizedBox(height: AppSpacing.xl),
                  // Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.dividerDark)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                        ),
                        child: Text(
                          'ou',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textTertiaryDark,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: AppColors.dividerDark)),
                    ],
                  ),
                  SizedBox(height: AppSpacing.xl),
                  // Continue without account
                  OutlinedButton(
                    onPressed: controller.continueWithoutAccount,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.borderDark),
                      foregroundColor: AppColors.textSecondaryDark,
                    ),
                    child: Text(
                      'Continuer sans compte',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.xl),
                  // Register link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pas encore de compte ? ',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiaryDark,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.register),
                        child: Text(
                          'S\'inscrire',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  // Terms
                  Text(
                    'En continuant, vous acceptez nos Conditions d\'utilisation et notre Politique de confidentialité.',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiaryDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: AppRadius.baseAll,
          border: Border.all(color: AppColors.borderDark, width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textPrimaryDark, size: 20.sp),
            SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.textPrimaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
