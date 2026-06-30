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

  Color _parseHexColor(String value) {
    var colorString = value.trim().toUpperCase();

    // Enlève les préfixes possibles
    colorString = colorString.replaceAll('#', '');
    colorString = colorString.replaceAll('0X', '');

    // Si on a seulement RRGGBB, on ajoute l'alpha FF
    if (colorString.length == 6) {
      colorString = 'FF$colorString';
    }

    // Sécurité de base
    if (colorString.length != 8) {
      return Colors.grey;
    }

    try {
      return Color(int.parse(colorString, radix: 16));
    } catch (_) {
      return Colors.grey;
    }
  }

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
              padding: EdgeInsets.all(AppSpacing.base),
              child: Text(
                'Explorer',
                style: AppTypography.headlineMedium.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
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
                        child: Text(
                          r,
                          style: AppTypography.labelSmall.copyWith(
                            color: sel
                                ? Colors.white
                                : AppColors.textSecondaryDark,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            SizedBox(height: AppSpacing.base),

            // Categories grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: Text(
                'Catégories',
                style: AppTypography.titleLarge.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Obx(() {
              final categories = controller.categories;
              return SizedBox(
                height: 110.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
                  itemCount: categories.length,
                  itemBuilder: (_, i) {
                    final cat = categories[i];
                    final catColor = _parseHexColor(cat.color);

                    return Container(
                      width: 90.w,
                      margin: EdgeInsets.only(right: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: catColor.withAlpha((0.15 * 255).round()),
                        borderRadius: AppRadius.mdAll,
                        border: Border.all(
                          color: catColor.withAlpha((0.3 * 255).round()),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(cat.icon, style: TextStyle(fontSize: 28.sp)),
                          SizedBox(height: 4.h),
                          Text(
                            cat.name,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondaryDark,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          Text(
                            '${cat.contentCount}',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textTertiaryDark,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),

            SizedBox(height: AppSpacing.base),

            // Content list
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
              child: Text(
                'Contenus',
                style: AppTypography.titleLarge.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ),
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
