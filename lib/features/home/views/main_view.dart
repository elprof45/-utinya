// lib/features/home/views/main_view.dart

import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/features/explore/views/explore_view.dart';
import 'package:egliloo/features/feed/views/feed_view.dart';
import 'package:egliloo/features/home/views/home_view.dart';
import 'package:egliloo/features/library/views/library_view.dart';
import 'package:egliloo/features/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) => currentIndex.value = index;

  final pages = [
    const HomeView(),
    const ExploreView(),
    const FeedView(),
    const LibraryView(),
    const ProfileView(),
  ];
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();

    return Obx(
      () => Scaffold(
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
  final Function(int) onTap;

  const _AfriBookBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
            width: 0.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60.h,
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
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData iconOutlined;
  final String label;
  final int index;
  final int currentIndex;
  final Function(int) onTap;

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

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  isSelected ? icon : iconOutlined,
                  key: ValueKey(isSelected),
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textTertiaryDark,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textTertiaryDark,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
