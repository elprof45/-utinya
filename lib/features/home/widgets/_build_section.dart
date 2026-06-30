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
  final VoidCallback? onViewAll;

  const BuildSection({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    this.showProgress = false,
    this.cardStyle = ContentCardStyle.portrait,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final bool isPortrait = cardStyle == ContentCardStyle.portrait;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.18),
                        AppColors.primary.withValues(alpha: 0.08),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.14),
                      width: 0.8,
                    ),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20.sp),
                ),
                SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.titleLarge.copyWith(
                                color: AppColors.textPrimaryDark,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark2.withValues(
                                alpha: 0.8,
                              ),
                              borderRadius: BorderRadius.circular(999.r),
                              border: Border.all(
                                color: AppColors.borderDark.withValues(
                                  alpha: 0.7,
                                ),
                                width: 0.7,
                              ),
                            ),
                            child: Text(
                              '${items.length}',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textTertiaryDark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (showProgress) ...[
                        SizedBox(height: 6.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: LinearProgressIndicator(
                            value: items.isEmpty ? 0 : (1 / items.length),
                            minHeight: 3.5.h,
                            backgroundColor: AppColors.borderDark.withValues(
                              alpha: 0.35,
                            ),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: AppSpacing.xs),
                TextButton(
                  onPressed: onViewAll,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    foregroundColor: AppColors.primary,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Voir tout',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 14.sp,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: isPortrait ? 250.h : 118.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, _) => SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final item = items[index];
                return isPortrait
                    ? _ContentCardPortrait(content: item)
                    : _ContentCardLandscape(content: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentCardPortrait extends StatelessWidget {
  final ContentModel content;

  const _ContentCardPortrait({required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.detail, arguments: content),
      child: SizedBox(
        width: 152.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: AppRadius.mdAll,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.14),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: AppRadius.mdAll,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SafeNetworkImage(
                        imageUrl: content.coverImage,
                        fit: BoxFit.cover,
                        placeholder: (_, _) =>
                            Container(color: AppColors.surfaceDark2),
                        errorWidget: (_, _, _) => Container(
                          color: AppColors.surfaceDark2,
                          child: const Icon(
                            Icons.broken_image_rounded,
                            color: Colors.white30,
                          ),
                        ),
                      ),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x10000000),
                              Color(0x2A000000),
                              Color(0xD0000000),
                            ],
                            stops: [0.0, 0.55, 1.0],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10.w,
                        right: 10.w,
                        top: 10.h,
                        child: Row(
                          children: [
                            _FloatingBadge(
                              label: content.typeLabel,
                              color: AppColors.primary,
                            ),
                            if (content.isTrending) ...[
                              SizedBox(width: 6.w),
                              const _FloatingBadge(
                                label: '🔥 Trend',
                                color: AppColors.accent,
                              ),
                            ],
                          ],
                        ),
                      ),
                      Positioned(
                        left: 10.w,
                        right: 10.w,
                        bottom: 10.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              content.title,
                              style: AppTypography.titleSmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                height: 1.15,
                                shadows: const [
                                  Shadow(
                                    blurRadius: 12,
                                    color: Colors.black54,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person_outline_rounded,
                                  size: 14,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Text(
                                    content.authorName,
                                    style: AppTypography.caption.copyWith(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            if (content.formattedDuration.isNotEmpty || content.isAudio)
              Row(
                children: [
                  if (content.formattedDuration.isNotEmpty) ...[
                    Icon(
                      Icons.schedule_rounded,
                      size: 11.sp,
                      color: AppColors.textTertiaryDark,
                    ),
                    SizedBox(width: 3.w),
                    Flexible(
                      child: Text(
                        content.formattedDuration,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textTertiaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  if (content.isAudio) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 7.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        'Audio',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ContentCardLandscape extends StatelessWidget {
  final ContentModel content;

  const _ContentCardLandscape({required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.detail, arguments: content),
      child: Container(
        width: 310.w,
        height: 110.h,
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: AppRadius.mdAll,
          border: Border.all(
            color: AppColors.borderDark.withValues(alpha: 0.8),
            width: 0.6,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: AppRadius.mdAll,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 98.w,
                    height: double.infinity,
                    child: SafeNetworkImage(
                      imageUrl: content.coverImage,
                      fit: BoxFit.cover,
                      placeholder: (_, _) =>
                          Container(color: AppColors.surfaceDark2),
                      errorWidget: (_, _, _) => Container(
                        color: AppColors.surfaceDark2,
                        child: const Icon(
                          Icons.broken_image_rounded,
                          color: Colors.white30,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 10.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            content.typeLabel.toUpperCase(),
                            style: AppTypography.overline.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            content.title,
                            style: AppTypography.titleSmall.copyWith(
                              color: AppColors.textPrimaryDark,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline_rounded,
                                size: 12,
                                color: AppColors.textTertiaryDark,
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Text(
                                  content.authorName,
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.textTertiaryDark,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          if (content.formattedDuration.isNotEmpty) ...[
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule_rounded,
                                  size: 11.sp,
                                  color: AppColors.textTertiaryDark,
                                ),
                                SizedBox(width: 3.w),
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
                    padding: EdgeInsets.only(right: 10.w),
                    child: Icon(
                      content.isAudio
                          ? Icons.play_circle_fill_rounded
                          : Icons.arrow_forward_ios_rounded,
                      color: AppColors.primary,
                      size: content.isAudio ? 34.sp : 14.sp,
                    ),
                  ),
                ],
              ),

              Positioned(
                top: 10.h,
                left: 10.w,
                child: _FloatingBadge(
                  label: content.isAudio ? 'Audio' : content.typeLabel,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _FloatingBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.14),
          width: 0.8,
        ),
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
