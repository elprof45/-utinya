// ─── POPULAR AUTHORS ─────────────────────────────────────────────────────
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/app/widgets/safe_cached_network_image.dart';
import 'package:egliloo/data/models/author_model.dart';
import 'package:egliloo/features/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildPopularAuthors extends StatelessWidget {
  const BuildPopularAuthors({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupération globale instantanée de votre contrôleur de page
    final controller = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
          child: Row(
            children: [
              Icon(Icons.people_rounded, color: AppColors.primary, size: 20.sp),
              SizedBox(width: AppSpacing.xs),
              Text(
                'Auteurs populaires',
                style: AppTypography.titleLarge.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        // FIX: increased from 110.h -> 132.h. The previous height was too
        // tight for avatar (64.h) + spacing + 2 lines of text once real
        // font metrics/line-height were applied, causing a RenderFlex
        // overflow in _AuthorChip. See _AuthorChip below for the matching
        // defensive fix (Flexible + FittedBox) that prevents this from
        // ever happening again, even with larger system text scaling.
        SizedBox(
          height: 132.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
            itemCount: controller.popularAuthors.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(right: AppSpacing.base),
              child: _AuthorChip(author: controller.popularAuthors[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class _AuthorChip extends StatelessWidget {
  final AuthorModel author;

  const _AuthorChip({required this.author});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 72.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipOval(
                  child: SafeNetworkImage(
                    imageUrl:
                        author.avatar ??
                        'https://ui-avatars.com/api/?name=${author.name}',
                    width: 64.w,
                    height: 64.w,
                    fit: BoxFit.cover,
                  ),
                ),
                if (author.isVerified)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.verified_rounded,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: AppSpacing.xs),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  author.name.split(' ')[0],
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondaryDark,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${author.contentCount} œuvres',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiaryDark,
                    fontSize: 9.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
