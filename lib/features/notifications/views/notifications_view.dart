import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/data/models/category_model.dart';
import 'package:egliloo/features/notifications/controllers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsView extends GetView<NotificationController> {
  const NotificationsView({super.key});
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
          'Notifications',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.textPrimaryDark,
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          padding: EdgeInsets.all(AppSpacing.base),
          itemCount: controller.notifications.length,
          itemBuilder: (_, i) {
            final n = controller.notifications[i];
            return GestureDetector(
              onTap: () => controller.markAsRead(n.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: AppSpacing.sm),
                padding: EdgeInsets.all(AppSpacing.base),
                decoration: BoxDecoration(
                  color: n.isRead
                      ? AppColors.surfaceDark
                      : AppColors.primarySurface,
                  borderRadius: AppRadius.mdAll,
                  border: Border.all(
                    color: n.isRead
                        ? AppColors.borderDark
                        : AppColors.primary.withValues(alpha: 0.3),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark2,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          _icon(n.type),
                          style: TextStyle(fontSize: 20.sp),
                        ),
                      ),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            n.title,
                            style: AppTypography.titleSmall.copyWith(
                              color: AppColors.textPrimaryDark,
                            ),
                          ),
                          Text(
                            n.body,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondaryDark,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (!n.isRead)
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _icon(NotificationType t) {
    switch (t) {
      case NotificationType.proverb:
        return '☀️';
      case NotificationType.newContent:
        return '📚';
      case NotificationType.badge:
        return '🏅';
      case NotificationType.comment:
        return '💬';
      case NotificationType.like:
        return '❤️';
      case NotificationType.follow:
        return '👤';
      default:
        return '🔔';
    }
  }
}
