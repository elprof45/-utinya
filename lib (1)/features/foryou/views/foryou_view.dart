import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/models/content_model.dart';
import '../../../../lib/app/theme/theme/app_colors.dart';
import '../controllers/foryou_controller.dart';

class ForYouView extends GetView<ForYouController> {
  const ForYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('For You'),
        actions: [
          IconButton(
            onPressed: controller.refresh,
            icon: const Icon(Icons.refresh_rounded),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Obx(() {
        final items = controller.recommendations;
        if (items.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.ochre),
          );
        }
        final left = <ContentModel>[];
        final right = <ContentModel>[];
        for (int i = 0; i < items.length; i++) {
          (i % 2 == 0 ? left : right).add(items[i]);
        }
        return RefreshIndicator(
          color: AppColors.terracotta,
          onRefresh: controller.refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(children: _column(left, startOffset: 0)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(children: _column(right, startOffset: 1)),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _column(List<ContentModel> items, {required int startOffset}) {
    const heights = [150.0, 190.0, 170.0];
    return List.generate(items.length, (i) {
      final height = heights[(i + startOffset) % heights.length];
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _ForYouTile(content: items[i], coverHeight: height),
      );
    });
  }
}

class _ForYouTile extends StatelessWidget {
  final ContentModel content;
  final double coverHeight;

  const _ForYouTile({required this.content, required this.coverHeight});

  @override
  Widget build(BuildContext context) {
    final fy = Get.find<ForYouController>();
    final gradient = AppColors.gradientFor(content.coverIndex);
    return GestureDetector(
      onTap: () => fy.openDetail(content),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.espresso.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: coverHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      content.typeIcon,
                      color: Colors.white.withValues(alpha: 0.85),
                      size: 34,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => fy.toggleBookmark(content),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.32),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        content.isBookmarked
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 13.5),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => fy.toggleLike(content),
                        child: Icon(
                          content.isLiked
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 15,
                          color: content.isLiked
                              ? AppColors.terracotta
                              : Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${content.likes}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.mode_comment_outlined,
                        size: 14,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${content.commentsCount}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
