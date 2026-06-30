import 'dart:ui';

import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,

      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundDark.withValues(alpha: .88),
              border: Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: .05)),
              ),
            ),
          ),
        ),
      ),

      titleSpacing: 16.w,

      title: Row(
        children: [
          /// Logo
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              gradient: AppColors.goldGradient,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withValues(alpha: .25),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "A",
                style: AppTypography.titleLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "AfriBook",
                style: AppTypography.titleLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -.5,
                ),
              ),

              Text(
                "Connect • Learn • Grow",
                style: AppTypography.bodySmall.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),

      actions: [
        _ActionButton(
          icon: Icons.search_rounded,
          onTap: () => Get.toNamed(Routes.search),
        ),

        SizedBox(width: 10.w),

        Stack(
          children: [
            _ActionButton(
              icon: Icons.notifications_none_rounded,
              onTap: () => Get.toNamed(Routes.notifications),
            ),

            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.backgroundDark, width: 2),
                ),
              ),
            ),
          ],
        ),

        SizedBox(width: 16.w),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Ink(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .05),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: Colors.white.withValues(alpha: .08)),
          ),
          child: Icon(icon, color: Colors.white, size: 22.sp),
        ),
      ),
    );
  }
}
