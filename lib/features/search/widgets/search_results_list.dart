import 'package:egliloo/app/widgets/safe_cached_network_image.dart';
import 'package:egliloo/features/search/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/data/models/content_model.dart';
import 'package:egliloo/app/routes/app_pages.dart';

class SearchResultsList extends GetView<AppSearchController> {
  const SearchResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: controller.results.length,
      itemBuilder: (_, index) {
        final item = controller.results[index];
        return SearchResultTile(content: item);
      },
    );
  }
}

class SearchEmptyState extends GetView<AppSearchController> {
  const SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🔍', style: TextStyle(fontSize: 48.sp)),
          SizedBox(height: AppSpacing.base),
          Text(
            'Aucun résultat pour\n"${controller.query.value}"',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textSecondaryDark,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Essayez un autre mot-clé',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiaryDark,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchResultTile extends StatelessWidget {
  final ContentModel content;

  const SearchResultTile({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.detail, arguments: content),
      child: Container(
        margin: EdgeInsets.only(bottom: AppSpacing.sm),
        padding: EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: AppColors.borderDark, width: 0.5),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: AppRadius.smAll,
              child: SafeNetworkImage(
                imageUrl: content.coverImage,
                width: 60.w,
                height: 70.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.typeLabel.toUpperCase(),
                    style: AppTypography.overline.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    content.title,
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.textPrimaryDark,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    content.authorName,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textTertiaryDark,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 12.sp,
                        color: AppColors.warning,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        content.rating.toStringAsFixed(1),
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textTertiaryDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: AppColors.textTertiaryDark,
            ),
          ],
        ),
      ),
    );
  }
}
