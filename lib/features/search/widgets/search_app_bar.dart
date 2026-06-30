import 'package:egliloo/features/search/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class SearchAppBar extends GetView<AppSearchController> {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.base),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.textPrimaryDark,
            ),
            onPressed: Get.back,
          ),
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: AppRadius.baseAll,
                border: Border.all(color: AppColors.borderDark, width: 0.5),
              ),
              child: TextField(
                controller: controller.searchController,
                autofocus: true,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
                  border: InputBorder.none,
                  filled: false,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.textTertiaryDark,
                  ),
                  suffixIcon: Obx(
                    () => controller.query.value.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.close_rounded,
                              color: AppColors.textTertiaryDark,
                            ),
                            onPressed: controller.clearSearch,
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
