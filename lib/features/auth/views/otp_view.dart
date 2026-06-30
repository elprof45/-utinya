// lib/features/auth/views/otp_view.dart

import 'dart:async';
import 'package:egliloo/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class OtpView extends GetView<AuthController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final phone = Get.arguments as String? ?? '';
    final controllers = List.generate(6, (_) => TextEditingController());
    final focusNodes = List.generate(6, (_) => FocusNode());
    final countdown = 30.obs;

    void startTimer() {
      Timer.periodic(const Duration(seconds: 1), (t) {
        if (countdown.value > 0) {
          countdown.value--;
        } else {
          t.cancel();
        }
      });
    }

    startTimer();

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.xl),
            Text(
              'Vérification',
              style: AppTypography.headlineLarge.copyWith(
                color: AppColors.textPrimaryDark,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              'Entrez le code à 6 chiffres envoyé au\n$phone',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondaryDark,
              ),
            ),
            SizedBox(height: AppSpacing.xxl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (i) => SizedBox(
                  width: 44.w,
                  height: 56.h,
                  child: TextField(
                    controller: controllers[i],
                    focusNode: focusNodes[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: AppTypography.headlineSmall.copyWith(
                      color: AppColors.textPrimaryDark,
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: AppRadius.mdAll,
                        borderSide: const BorderSide(
                          color: AppColors.borderDark,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppRadius.mdAll,
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                    onChanged: (v) {
                      if (v.isNotEmpty && i < 5) {
                        focusNodes[i + 1].requestFocus();
                      }
                      if (i == 5 && v.isNotEmpty) {
                        controller.otpController.text = controllers
                            .map((c) => c.text)
                            .join();
                        controller.verifyOtp();
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.xl),
            Center(
              child: Obx(
                () => countdown.value > 0
                    ? Text(
                        'Renvoyer dans ${countdown.value}s',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textTertiaryDark,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          countdown.value = 30;
                          startTimer();
                        },
                        child: Text(
                          'Renvoyer le code',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
              ),
            ),
            const Spacer(),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.verifyOtp,
                child: controller.isLoading.value
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Vérifier'),
              ),
            ),
            SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}
