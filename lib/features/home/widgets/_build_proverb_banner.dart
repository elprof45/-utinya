// ─── PROVERB BANNER ──────────────────────────────────────────────────────
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/features/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class BuildProverbBanner extends StatelessWidget {
  const BuildProverbBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupération automatique du contrôleur injecté par GetX
    final controller = Get.find<HomeController>();

    return Obx(() {
      final proverb = controller.todayProverb;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: AppSpacing.base),
        padding: EdgeInsets.all(AppSpacing.base),
        decoration: BoxDecoration(
          gradient: AppColors.goldGradient,
          borderRadius: AppRadius.baseAll,
        ),
        child: Row(
          children: [
            Text('☀️', style: TextStyle(fontSize: 28.sp)),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Proverbe du jour',
                    style: AppTypography.labelSmall.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    proverb['text'] ?? '',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (proverb['origin'] != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      '— ${proverb['origin']}',
                      style: AppTypography.caption.copyWith(
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
