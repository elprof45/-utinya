// lib/features/home/widgets/build_section.dart
import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/app/widgets/safe_cached_network_image.dart';
import 'package:egliloo/data/models/content_model.dart';
import 'package:egliloo/features/home/widgets/_build_featured_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<ContentModel> items;
  final bool showProgress;
  final ContentCardStyle cardStyle;

  const BuildSection({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    this.showProgress = false,
    this.cardStyle = ContentCardStyle.portrait,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20.sp),
              SizedBox(width: AppSpacing.xs),
              Text(
                title,
                style: AppTypography.titleLarge.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Voir tout',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        SizedBox(
          // CORRECTION : Augmentation de 200.h à 235.h pour laisser la place aux textes
          height: cardStyle == ContentCardStyle.portrait ? 235.h : 110.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: AppSpacing.sm),
                child: cardStyle == ContentCardStyle.portrait
                    ? _ContentCardPortrait(content: items[index])
                    : _ContentCardLandscape(content: items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── CONTENT CARD PORTRAIT ───────────────────────────────────────────────────
class _ContentCardPortrait extends StatelessWidget {
  final ContentModel content;

  const _ContentCardPortrait({required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.detail, arguments: content),
      child: SizedBox(
        width: 130.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CORRECTION : Emballage de l'image pour occuper l'espace proportionnellement
            SizedBox(
              height: 150.h,
              width: 130.w,
              child: ClipRRect(
                borderRadius: AppRadius.mdAll,
                child: SafeNetworkImage(
                  imageUrl: content.coverImage,
                  fit: BoxFit.cover,
                  placeholder: (_, _) =>
                      Container(color: AppColors.surfaceDark2),
                  errorWidget: (_, _, _) => Container(
                    color: AppColors.surfaceDark2,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.white30,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.xs),
            // CORRECTION : Flexible empêche la colonne de crasher si le texte déborde légèrement
            Flexible(
              child: Text(
                content.title,
                style: AppTypography.titleSmall.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              content.authorName,
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiaryDark,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── CONTENT CARD LANDSCAPE ──────────────────────────────────────────────────
class _ContentCardLandscape extends StatelessWidget {
  final ContentModel content;

  const _ContentCardLandscape({required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.detail, arguments: content),
      child: Container(
        width: 280.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: AppColors.borderDark, width: 0.5),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppRadius.md),
                bottomLeft: Radius.circular(AppRadius.md),
              ),
              child: SafeNetworkImage(
                imageUrl: content.coverImage,
                width: 80.w,
                height: 90.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSpacing.sm,
                  horizontal: AppSpacing.xs,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      content.typeLabel.toUpperCase(),
                      style: AppTypography.overline.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Flexible(
                      child: Text(
                        content.title,
                        style: AppTypography.titleSmall.copyWith(
                          color: AppColors.textPrimaryDark,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      content.authorName,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiaryDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (content.formattedDuration.isNotEmpty) ...[
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            size: 10.sp,
                            color: AppColors.textTertiaryDark,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            content.formattedDuration,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textTertiaryDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: AppSpacing.sm),
              child: Icon(
                content.isAudio
                    ? Icons.play_circle_filled_rounded
                    : Icons.arrow_forward_ios_rounded,
                color: AppColors.primary,
                size: content.isAudio ? 32.sp : 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
