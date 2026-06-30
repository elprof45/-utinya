// lib/features/search/widgets/search_filters.dart
import 'package:egliloo/features/search/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class SearchFilters extends GetView<AppSearchController> {
  const SearchFilters({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ CORRECTION 1 : On retire Obx du sommet car controller.filters n'est pas observable
    return SizedBox(
      height: 36.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
        itemCount: controller.filters.length,
        itemBuilder: (_, index) {
          final filter = controller.filters[index];

          // ✅ CORRECTION 2 : On place Obx au plus près de la variable réactive .value
          return Obx(() {
            final isSelected = controller.selectedFilter.value == filter;

            return GestureDetector(
              onTap: () => controller.setFilter(filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(right: AppSpacing.sm),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.surfaceDark,
                  borderRadius: AppRadius.fullAll,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.borderDark,
                  ),
                ),
                child: Text(
                  filter,
                  style: AppTypography.labelSmall.copyWith(
                    color: isSelected
                        ? Colors.white
                        : AppColors.textSecondaryDark,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
