// ─── CATEGORY CHIPS ──────────────────────────────────────────────────────
import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildCategoryChips extends StatelessWidget {
  const BuildCategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    // Liste statique des genres littéraires et culturels
    const cats = [
      '🌙 Contes',
      '📜 Histoire',
      '⚡ Mythes',
      '💬 Proverbes',
      '🎙️ Podcasts',
      '📖 Livres',
      '🥁 Musique',
      '✍️ Poésie',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
          child: Text(
            'Explorer par genre',
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.textPrimaryDark,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 40.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
            itemCount: cats.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(right: AppSpacing.sm),
              child: ActionChip(
                label: Text(
                  cats[index],
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                ),
                backgroundColor: AppColors.surfaceDark2,
                side: const BorderSide(color: AppColors.borderDark),
                onPressed: () => Get.toNamed(Routes.explore),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
