// ─── PROVERB BANNER (PRO VERSION) ────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/features/home/controllers/home_controller.dart';

class BuildProverbBanner extends StatelessWidget {
  const BuildProverbBanner({super.key});
  // Méthode propre pour gérer le partage natif du proverbe
  void _shareProverb(Map<String, String?> proverb) {
    final text = proverb['text'];
    final origin = proverb['origin'];
    if (text == null || text.isEmpty) return;
    HapticFeedback.mediumImpact(); // Retour haptique premium au clic
    final String shareMessage = origin != null && origin.isNotEmpty
        ? '« $text »\n—$origin\n\nDécouvrez plus sur AfriBook.'
        : '« $text »\n\nDécouvrez plus sur AfriBook.';
    SharePlus.instance.share(
      ShareParams(text: "📖 Proverbe du jour\n\n$shareMessage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final proverb = controller.todayProverb;

      final text = proverb['text'] ?? '';
      final origin = proverb['origin'];

      return Container(
        margin: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          gradient: AppColors.goldGradient,
          borderRadius: AppRadius.baseAll,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.base),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ICON
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Text('☀️', style: TextStyle(fontSize: 22.sp)),
              ),

              SizedBox(width: AppSpacing.sm),

              // CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Proverbe du jour',
                      style: AppTypography.labelSmall.copyWith(
                        color: Colors.white70,
                        letterSpacing: 0.5,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      text,
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (origin != null && origin.toString().isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      Text(
                        '— $origin',
                        style: AppTypography.caption.copyWith(
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // ACTIONS
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _shareProverb(proverb),
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
