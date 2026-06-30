import 'package:egliloo/app/widgets/safe_cached_network_image.dart';
import 'package:egliloo/features/library/controllers/library_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class LibraryView extends GetView<LibraryController> {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ['Favoris', 'Téléchargés', 'Historique'];
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(AppSpacing.base),
              child: Text(
                'Bibliothèque',
                style: AppTypography.headlineMedium.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ),
            // Tabs
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
                child: Row(
                  children: tabs.asMap().entries.map((e) {
                    final sel = controller.selectedTab.value == e.key;
                    return GestureDetector(
                      onTap: () => controller.selectTab(e.key),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.only(right: AppSpacing.sm),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.base,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: sel ? AppColors.primary : Colors.transparent,
                          borderRadius: AppRadius.fullAll,
                          border: Border.all(
                            color: sel
                                ? AppColors.primary
                                : AppColors.borderDark,
                          ),
                        ),
                        child: Text(
                          e.value,
                          style: AppTypography.labelSmall.copyWith(
                            color: sel
                                ? Colors.white
                                : AppColors.textSecondaryDark,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.base),
            Expanded(
              child: Obx(() {
                final items = [
                  controller.bookmarks,
                  controller.downloads,
                  controller.history,
                ][controller.selectedTab.value];
                if (items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('📚', style: TextStyle(fontSize: 48.sp)),
                        SizedBox(height: AppSpacing.base),
                        Text(
                          'Aucun contenu ici',
                          style: AppTypography.titleMedium.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final c = items[i];
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
                                  SizedBox(height: 4.h),
                                  if (c.isAudio || c.readingTimeMinutes != null)
                                    Text(
                                      c.isAudio
                                          ? c.formattedDuration
                                          : '${c.readingTimeMinutes}min de lecture',
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.textTertiaryDark,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Icon(
                              controller.selectedTab.value == 1
                                  ? Icons.download_done_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              color: controller.selectedTab.value == 1
                                  ? AppColors.success
                                  : AppColors.textTertiaryDark,
                              size: 16.sp,
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
