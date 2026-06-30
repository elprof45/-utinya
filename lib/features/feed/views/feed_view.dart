import 'package:egliloo/app/widgets/safe_cached_network_image.dart';
import 'package:egliloo/features/feed/controllers/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/data/models/content_model.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Text(
                    'Pour vous',
                    style: AppTypography.headlineMedium.copyWith(
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.tune_rounded, color: AppColors.textSecondaryDark),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.feedItems.length,
                        itemBuilder: (_, i) => _FeedCard(
                          content: controller.feedItems[i],
                          controller: controller,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedCard extends StatelessWidget {
  final ContentModel content;
  final FeedController controller;
  const _FeedCard({required this.content, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.detail, arguments: content),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: AppRadius.lgAll,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              child: Row(
                children: [
                  ClipOval(
                    child: SafeNetworkImage(
                      imageUrl:
                          content.authorAvatar ?? 'https://i.pravatar.cc/150',
                      width: 36.w,
                      height: 36.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          content.authorName,
                          style: AppTypography.titleSmall.copyWith(
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                        Text(
                          content.country ?? content.typeLabel,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textTertiaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.more_horiz_rounded,
                    color: AppColors.textTertiaryDark,
                  ),
                ],
              ),
            ),
            // Cover
            ClipRRect(
              borderRadius: BorderRadius.zero,
              child: SafeNetworkImage(
                imageUrl: content.coverImage,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          borderRadius: AppRadius.fullAll,
                        ),
                        child: Text(
                          content.typeLabel,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    content.title,
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textPrimaryDark,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    content.description,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondaryDark,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  // Actions
                  Row(
                    children: [
                      Obx(
                        () => GestureDetector(
                          onTap: () => controller.toggleLike(content.id),
                          child: Row(
                            children: [
                              Icon(
                                controller.isLiked(content.id)
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: controller.isLiked(content.id)
                                    ? AppColors.error
                                    : AppColors.textTertiaryDark,
                                size: 20.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '${content.likesCount}',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textTertiaryDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: AppSpacing.base),
                      Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: AppColors.textTertiaryDark,
                        size: 20.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${content.commentsCount}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textTertiaryDark,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.bookmark_border_rounded,
                        color: AppColors.textTertiaryDark,
                        size: 20.sp,
                      ),
                      SizedBox(width: AppSpacing.base),
                      Icon(
                        Icons.share_outlined,
                        color: AppColors.textTertiaryDark,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
