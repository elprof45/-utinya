import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/widgets/comment_sheet.dart';
import '../controllers/feed_controller.dart';

class FeedView extends GetView<FeedController> {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.espresso,
      body: Obx(() {
        if (controller.items.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.ochre),
          );
        }
        return PageView.builder(
          scrollDirection: Axis.vertical,
          onPageChanged: controller.onPageChanged,
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            final item = controller.items[index];
            final gradient = AppColors.gradientFor(item.coverIndex);
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      item.typeIcon,
                      size: 110,
                      color: Colors.white.withValues(alpha: 0.18),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.5, 1],
                    ),
                  ),
                ),
                Positioned(
                  top: 56,
                  left: 20,
                  right: 90,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.public_rounded,
                          color: Colors.white,
                          size: 13,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 90,
                  bottom: 36,
                  child: GestureDetector(
                    onTap: () => controller.openDetail(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 13.5,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.touch_app_rounded,
                              size: 14,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Tap to open full story',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 14,
                  bottom: 50,
                  child: Column(
                    children: [
                      _SideAction(
                        icon: item.isLiked
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: item.isLiked
                            ? AppColors.terracotta
                            : Colors.white,
                        label: '${item.likes}',
                        onTap: () => controller.toggleLike(index),
                      ),
                      const SizedBox(height: 22),
                      _SideAction(
                        icon: Icons.mode_comment_outlined,
                        color: Colors.white,
                        label: '${item.commentsCount}',
                        onTap: () => Get.bottomSheet(
                          CommentSheetContent(
                            contentId: item.id,
                            onCountChanged: (count) {
                              item.commentsCount = count;
                              controller.items.refresh();
                            },
                          ),
                          isScrollControlled: true,
                        ),
                      ),
                      const SizedBox(height: 22),
                      _SideAction(
                        icon: Icons.reply_rounded,
                        color: Colors.white,
                        label: '${item.shares}',
                        onTap: () => controller.share(index),
                      ),
                      const SizedBox(height: 22),
                      _SideAction(
                        icon: item.isBookmarked
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        color: item.isBookmarked
                            ? AppColors.ochre
                            : Colors.white,
                        label: 'Save',
                        onTap: () => controller.toggleBookmark(index),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}

class _SideAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _SideAction({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.28),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
