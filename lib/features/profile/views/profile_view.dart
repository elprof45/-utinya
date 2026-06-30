import 'package:egliloo/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.backgroundDark,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.textPrimaryDark,
                ),
                onPressed: () => Get.toNamed(Routes.settings),
              ),
              IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: AppColors.textPrimaryDark,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 90.w,
                    height: 90.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.goldGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'M',
                        style: AppTypography.headlineLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.base),
                  Text(
                    'Mamadou Diallo',
                    style: AppTypography.headlineSmall.copyWith(
                      color: AppColors.textPrimaryDark,
                    ),
                  ),
                  Text(
                    '@mamadou_lit',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textTertiaryDark,
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    '"L\'amour de la lecture est une passion qui grandit avec l\'âge."',
                    style: AppTypography.quote.copyWith(
                      color: AppColors.textSecondaryDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSpacing.xl),
                  // Stats row
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatBox(
                          label: 'Livres\nlus',
                          value: '${controller.booksRead.value}',
                        ),
                        _StatBox(
                          label: 'Abonnés',
                          value: '${controller.followersCount.value}',
                        ),
                        _StatBox(
                          label: 'Abonnements',
                          value: '${controller.followingCount.value}',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.xl),
                  // Level & XP
                  Obx(
                    () => Container(
                      padding: EdgeInsets.all(AppSpacing.base),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark,
                        borderRadius: AppRadius.mdAll,
                        border: Border.all(
                          color: AppColors.borderDark,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('⭐', style: TextStyle(fontSize: 20.sp)),
                              SizedBox(width: AppSpacing.xs),
                              Text(
                                'Niveau ${controller.level.value}',
                                style: AppTypography.titleMedium.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${controller.xp.value} / ${controller.level.value * 500} XP',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textTertiaryDark,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSpacing.sm),
                          ClipRRect(
                            borderRadius: AppRadius.fullAll,
                            child: LinearProgressIndicator(
                              value:
                                  (controller.xp.value /
                                          (controller.level.value * 500))
                                      .clamp(0.0, 1.0),
                              backgroundColor: AppColors.surfaceDark2,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                              minHeight: 8,
                            ),
                          ),
                          SizedBox(height: AppSpacing.sm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _MiniStat(
                                icon: '🔥',
                                value: '${controller.readingStreak.value}j',
                                label: 'Série',
                              ),
                              _MiniStat(
                                icon: '⏱️',
                                value:
                                    '${(controller.totalMinutes.value / 60).toStringAsFixed(0)}h',
                                label: 'Lecture',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.xl),
                  // Badges section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Badges',
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    height: 80.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: ['🏅', '📚', '🎯', '🌟', '🔥', '🎖️']
                          .map(
                            (e) => Container(
                              width: 64.w,
                              height: 64.w,
                              margin: EdgeInsets.only(right: AppSpacing.sm),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceDark,
                                borderRadius: AppRadius.mdAll,
                                border: Border.all(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  e,
                                  style: TextStyle(fontSize: 28.sp),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label, value;
  const _StatBox({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        value,
        style: AppTypography.headlineSmall.copyWith(
          color: AppColors.textPrimaryDark,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        label,
        style: AppTypography.caption.copyWith(
          color: AppColors.textTertiaryDark,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

class _MiniStat extends StatelessWidget {
  final String icon, value, label;
  const _MiniStat({
    required this.icon,
    required this.value,
    required this.label,
  });
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(icon, style: TextStyle(fontSize: 14.sp)),
      SizedBox(width: 4.w),
      Text(
        value,
        style: AppTypography.titleSmall.copyWith(
          color: AppColors.textPrimaryDark,
        ),
      ),
      SizedBox(width: 4.w),
      Text(
        label,
        style: AppTypography.caption.copyWith(
          color: AppColors.textTertiaryDark,
        ),
      ),
    ],
  );
}
