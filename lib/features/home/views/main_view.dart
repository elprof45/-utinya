// lib/features/home/views/main_view.dart

import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/features/explore/views/explore_view.dart';
import 'package:egliloo/features/feed/views/feed_view.dart';
import 'package:egliloo/features/home/views/home_view.dart';
import 'package:egliloo/features/library/views/library_view.dart';
import 'package:egliloo/features/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    if (index == currentIndex.value) return;
    currentIndex.value = index;
  }

  final pages = const [
    HomeView(),
    ExploreView(),
    FeedView(),
    LibraryView(),
    ProfileView(),
  ];
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();

    return Obx(
      () => Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: controller.pages,
        ),
        bottomNavigationBar: _AfriBookBottomNav(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
        ),
      ),
    );
  }
}

class _AfriBookBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _AfriBookBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.surfaceDark.withValues(alpha: 0.96)
        : AppColors.surfaceLight.withValues(alpha: 0.96);

    final borderColor = isDark
        ? AppColors.dividerDark.withValues(alpha: 0.6)
        : AppColors.dividerLight.withValues(alpha: 0.8);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 12.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: borderColor, width: 0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                height: 70.h,
                child: Row(
                  children: [
                    _NavItem(
                      icon: Icons.home_rounded,
                      iconOutlined: Icons.home_outlined,
                      label: 'Accueil',
                      index: 0,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                    _NavItem(
                      icon: Icons.explore_rounded,
                      iconOutlined: Icons.explore_outlined,
                      label: 'Explorer',
                      index: 1,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                    _NavItem(
                      icon: Icons.auto_awesome_rounded,
                      iconOutlined: Icons.auto_awesome_outlined,
                      label: 'Pour vous',
                      index: 2,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                    _NavItem(
                      icon: Icons.library_books_rounded,
                      iconOutlined: Icons.library_books_outlined,
                      label: 'Bibliothèque',
                      index: 3,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                    _NavItem(
                      icon: Icons.person_rounded,
                      iconOutlined: Icons.person_outline_rounded,
                      label: 'Profil',
                      index: 4,
                      currentIndex: currentIndex,
                      onTap: onTap,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData iconOutlined;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.iconOutlined,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;

    final selectedColor = AppColors.primary;
    final unselectedColor = AppColors.textTertiaryDark;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashFactory: InkRipple.splashFactory,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 6.h),
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
            color: isSelected
                ? selectedColor.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeOutCubic,
            child: Column(
              key: ValueKey<bool>(isSelected),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? icon : iconOutlined,
                  color: isSelected ? selectedColor : unselectedColor,
                  size: 23.sp,
                ),
                if (isSelected) ...[
                  SizedBox(width: 6.w),
                  Text(
                    label,
                    style: AppTypography.labelMedium.copyWith(
                      color: selectedColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
