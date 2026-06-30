// lib/features/home/widgets/build_appbar.dart
import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: const BoxDecoration(
              gradient: AppColors.goldGradient,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'A',
                style: AppTypography.titleMedium.copyWith(color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'AfriBook',
            style: AppTypography.headlineSmall.copyWith(
              color: AppColors.textPrimaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search_rounded,
            color: AppColors.textPrimaryDark,
          ),
          onPressed: () => Get.toNamed(Routes.search),
        ),
        IconButton(
          icon: Stack(
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: AppColors.textPrimaryDark,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () => Get.toNamed(Routes.notifications),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }
}
