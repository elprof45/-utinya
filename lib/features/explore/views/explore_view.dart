import 'package:egliloo/app/widgets/safe_cached_network_image.dart';
import 'package:egliloo/features/explore/controllers/explore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({super.key});
  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ExploreController>()) {
      Get.lazyPut<ExploreController>(() => ExploreController(), fenix: true);
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                // mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    'Explorer',
                    style: AppTypography.headlineMedium.copyWith(
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.tune_rounded,
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                ],
              ),
            ),
            // Region filter
            Obx(() {
              final selectedRegion = controller.selectedRegion.value;
              final regions = controller.regions;
              return SizedBox(
                height: 36.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
                  itemCount: regions.length,
                  itemBuilder: (_, i) {
                    final r = regions[i];
                    final sel = selectedRegion == r;
                    return GestureDetector(
                      onTap: () => controller.setRegion(r),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.only(right: AppSpacing.sm),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.base,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: sel
                              ? AppColors.primary
                              : AppColors.surfaceDark,
                          borderRadius: AppRadius.fullAll,
                          border: Border.all(
                            color: sel
                                ? AppColors.primary
                                : AppColors.borderDark,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            r,
                            style: AppTypography.labelSmall.copyWith(
                              color: sel
                                  ? Colors.white
                                  : AppColors.textSecondaryDark,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            // Content list
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
            //   child: Text(
            //     'Contenus',
            //     style: AppTypography.titleLarge.copyWith(
            //       color: AppColors.textPrimaryDark,
            //     ),
            //   ),
            // ),
            SizedBox(height: AppSpacing.sm),
            Expanded(
              child: Obx(() {
                final contents = controller.filteredContent;
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
                  itemCount: contents.length,
                  itemBuilder: (_, i) {
                    final c = contents[i];
                    return GestureDetector(
                      onTap: () => Get.toNamed(Routes.detail, arguments: c),
                      child: Container(
                        margin: EdgeInsets.only(bottom: AppSpacing.sm),
                        padding: EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceDark,
                          borderRadius: AppRadius.mdAll,
                          border: Border.all(
                            color: AppColors.borderDark,
                            width: 0.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: AppRadius.smAll,
                              child: SafeNetworkImage(
                                imageUrl: c.coverImage,
                                width: 56.w,
                                height: 64.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    c.typeLabel.toUpperCase(),
                                    style: AppTypography.overline.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    c.title,
                                    style: AppTypography.titleSmall.copyWith(
                                      color: AppColors.textPrimaryDark,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    c.authorName,
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.textTertiaryDark,
                                    ),
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
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
