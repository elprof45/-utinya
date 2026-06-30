// lib/features/onboarding/views/language_selection_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/data/datasources/local/mock_data.dart';

class LanguageSelectionView extends StatefulWidget {
  const LanguageSelectionView({super.key});

  @override
  State<LanguageSelectionView> createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends State<LanguageSelectionView> {
  String selected = 'fr';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.xl),
              Text('🌍', style: TextStyle(fontSize: 40.sp)),
              SizedBox(height: AppSpacing.base),
              Text(
                'Choisissez votre langue',
                style: AppTypography.headlineMedium.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Vous pourrez en ajouter d\'autres plus tard dans les paramètres.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
              SizedBox(height: AppSpacing.xxl),
              Expanded(
                child: ListView.builder(
                  itemCount: MockData.languages.length,
                  itemBuilder: (_, i) {
                    final lang = MockData.languages[i];
                    final isSelected = selected == lang['code'];
                    return GestureDetector(
                      onTap: () => setState(() => selected = lang['code']!),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.only(bottom: AppSpacing.sm),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.base,
                          vertical: AppSpacing.md,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primarySurface
                              : AppColors.surfaceDark,
                          borderRadius: AppRadius.mdAll,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.borderDark,
                            width: isSelected ? 1.5 : 0.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              lang['flag']!,
                              style: TextStyle(fontSize: 24.sp),
                            ),
                            SizedBox(width: AppSpacing.base),
                            Expanded(
                              child: Text(
                                lang['name']!,
                                style: AppTypography.titleMedium.copyWith(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textPrimaryDark,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primary,
                                size: 22.sp,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSpacing.base),
              ElevatedButton(
                onPressed: () => Get.offNamed(Routes.interestSelection),
                child: const Text('Continuer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
