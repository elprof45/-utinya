// lib/features/onboarding/views/onboarding_view.dart

import 'package:egliloo/features/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<OnboardingController>()) {
      Get.lazyPut<OnboardingController>(() => OnboardingController());
    }

    return Scaffold(
      body: Stack(
        children: [
          // PageView
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.pages.length,
            itemBuilder: (_, i) =>
                _OnboardingPageWidget(page: controller.pages[i]),
          ),
          // Skip button
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.base),
                child: TextButton(
                  onPressed: controller.skipOnboarding,
                  child: Text(
                    'Passer',
                    style: AppTypography.labelMedium.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl,
                  vertical: AppSpacing.xxl,
                ),
                child: Column(
                  children: [
                    // Dots
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.pages.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: controller.currentPage.value == i
                                ? 24.w
                                : 6.w,
                            height: 6.w,
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            decoration: BoxDecoration(
                              color: controller.currentPage.value == i
                                  ? AppColors.primary
                                  : Colors.white30,
                              borderRadius: AppRadius.fullAll,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.xl),
                    // Next / Start button
                    Obx(
                      () => ElevatedButton(
                        onPressed: controller.nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: Size(double.infinity, 52.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadius.baseAll,
                          ),
                        ),
                        child: Text(
                          controller.currentPage.value ==
                                  controller.pages.length - 1
                              ? 'Commencer'
                              : 'Suivant',
                          style: AppTypography.labelLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
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

class _OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;

  const _OnboardingPageWidget({required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [page.bgColor, const Color(0xFF0C0C0C)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Emoji in glowing circle
          Container(
            width: 140.w,
            height: 140.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: page.accentColor.withValues(alpha: 0.12),
              border: Border.all(
                color: page.accentColor.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: page.accentColor.withValues(alpha: 0.2),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Text(page.emoji, style: TextStyle(fontSize: 64.sp)),
            ),
          ),
          SizedBox(height: 48.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              children: [
                Text(
                  page.title,
                  style: AppTypography.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  page.subtitle,
                  style: AppTypography.bodyLarge.copyWith(
                    color: Colors.white60,
                    height: 1.7,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
