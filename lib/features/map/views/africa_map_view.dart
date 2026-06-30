import 'package:egliloo/features/map/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class AfricaMapView extends GetView<MapController> {
  const AfricaMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimaryDark,
          ),
          onPressed: Get.back,
        ),
        title: Text(
          'Carte de l\'Afrique',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.textPrimaryDark,
          ),
        ),
      ),
      body: Column(
        children: [
          // Map placeholder
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(AppSpacing.base),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: AppRadius.lgAll,
                border: Border.all(color: AppColors.borderDark),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🌍', style: TextStyle(fontSize: 80.sp)),
                        SizedBox(height: AppSpacing.base),
                        Text(
                          'Carte Interactive',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.textPrimaryDark,
                          ),
                        ),
                        Text(
                          'Intégrez flutter_map + OpenStreetMap',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textTertiaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Country list
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
                  child: Text(
                    'Pays',
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.base,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.countries.length,
                      itemBuilder: (_, i) {
                        final country = controller.countries[i];
                        return GestureDetector(
                          onTap: () => controller.selectCountry(country),
                          child: Obx(() {
                            final sel =
                                controller.selectedCountry.value?['code'] ==
                                country['code'];
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 100.w,
                              margin: EdgeInsets.only(right: AppSpacing.sm),
                              padding: EdgeInsets.all(AppSpacing.sm),
                              decoration: BoxDecoration(
                                color: sel
                                    ? AppColors.primarySurface
                                    : AppColors.surfaceDark,
                                borderRadius: AppRadius.mdAll,
                                border: Border.all(
                                  color: sel
                                      ? AppColors.primary
                                      : AppColors.borderDark,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    country['name'],
                                    style: AppTypography.titleSmall.copyWith(
                                      color: sel
                                          ? AppColors.primary
                                          : AppColors.textPrimaryDark,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${country['contentCount']} contenus',
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.textTertiaryDark,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
