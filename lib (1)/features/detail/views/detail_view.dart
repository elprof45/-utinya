import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:get/get.dart';
import '../../../../lib/app/theme/theme/app_colors.dart';
import '../../../app/widgets/audio_player_widget.dart';
import '../../../app/widgets/avatar_placeholder.dart';
import '../../../app/widgets/comment_sheet.dart';
import '../../../app/widgets/tribal_divider.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _MediaCarousel(controller: controller)),
          SliverToBoxAdapter(child: AudioPlayerWidget(controller: controller)),
          SliverToBoxAdapter(child: _AuthorBanner(controller: controller)),
          SliverToBoxAdapter(child: _QuickActions(controller: controller)),
          SliverToBoxAdapter(
            child: TribalDivider(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
              child: Obx(
                () => MarkdownBody(
                  data: controller.content.value.body,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet(
                    h2: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.copyWith(fontSize: 20),
                    p: Theme.of(context).textTheme.bodyLarge,
                    strong: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.terracotta,
                    ),
                    em: const TextStyle(fontStyle: FontStyle.italic),
                    listBullet: Theme.of(context).textTheme.bodyLarge,
                    blockquoteDecoration: BoxDecoration(
                      color: AppColors.ochre.withValues(alpha: 0.1),
                      border: const Border(
                        left: BorderSide(color: AppColors.terracotta, width: 3),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    blockquotePadding: const EdgeInsets.all(14),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TribalDivider(
              color: AppColors.emerald,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            ),
          ),
          SliverToBoxAdapter(child: _CommentsPreview(controller: controller)),
          const SliverToBoxAdapter(child: SizedBox(height: 28)),
        ],
      ),
    );
  }
}

class _MediaCarousel extends StatelessWidget {
  final DetailController controller;
  const _MediaCarousel({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final frames = controller.mediaFrames;
      final gradient = AppColors.gradientFor(
        controller.content.value.coverIndex,
      );
      return SizedBox(
        height: 300,
        child: Stack(
          children: [
            PageView.builder(
              controller: controller.mediaController,
              onPageChanged: controller.onMediaPageChanged,
              itemCount: frames.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        controller.content.value.typeIcon,
                        size: 86,
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                      Positioned(
                        bottom: 26,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.32),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            frames[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _circleIconButton(
                      Icons.arrow_back_rounded,
                      () => Get.back(),
                    ),
                    _circleIconButton(
                      controller.isBookmarked.value
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      controller.toggleBookmark,
                      color: controller.isBookmarked.value
                          ? AppColors.ochre
                          : Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  frames.length,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: controller.currentMediaIndex.value == i ? 16 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: controller.currentMediaIndex.value == i
                            ? 0.95
                            : 0.45,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _circleIconButton(
    IconData icon,
    VoidCallback onTap, {
    Color color = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.32),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 19),
      ),
    );
  }
}

class _AuthorBanner extends StatelessWidget {
  final DetailController controller;
  const _AuthorBanner({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final author = controller.content.value.author;
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.content.value.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              '${controller.content.value.category} · ${controller.content.value.region} · ${controller.content.value.dateAdded}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                AvatarPlaceholder(
                  colorIndex: author.avatarColorIndex,
                  size: 46,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${author.role} · ${author.followers} followers',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                _SubscribeButton(controller: controller),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class _SubscribeButton extends StatelessWidget {
  final DetailController controller;
  const _SubscribeButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final subscribed = controller.isSubscribed.value;
      return GestureDetector(
        onTap: controller.toggleSubscribe,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: subscribed
                ? null
                : const LinearGradient(
                    colors: [AppColors.terracotta, AppColors.ochre],
                  ),
            color: subscribed ? AppColors.sand : null,
            border: subscribed
                ? Border.all(color: AppColors.ochre.withValues(alpha: 0.4))
                : null,
          ),
          child: Text(
            subscribed ? 'Abonné(e)' : "S'abonner",
            style: TextStyle(
              color: subscribed ? AppColors.textOnLight : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      );
    });
  }
}

class _QuickActions extends StatelessWidget {
  final DetailController controller;
  const _QuickActions({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
      child: Obx(
        () => Row(
          children: [
            _actionChip(
              context,
              icon: controller.isLiked.value
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              label: '${controller.content.value.likes}',
              color: controller.isLiked.value ? AppColors.terracotta : null,
              onTap: controller.toggleLike,
            ),
            const SizedBox(width: 10),
            _actionChip(
              context,
              icon: Icons.mode_comment_outlined,
              label: '${controller.content.value.commentsCount}',
              onTap: () => Get.bottomSheet(
                CommentSheetContent(
                  contentId: controller.content.value.id,
                  onCountChanged: controller.refreshCommentCount,
                ),
                isScrollControlled: true,
              ),
            ),
            const SizedBox(width: 10),
            _actionChip(
              context,
              icon: Icons.ios_share_rounded,
              label: 'Share',
              onTap: () => Get.snackbar(
                'Shared',
                '"${controller.content.value.title}" link copied to clipboard.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    Color? color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.ochre.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: color ?? Theme.of(context).iconTheme.color,
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentsPreview extends StatelessWidget {
  final DetailController controller;
  const _CommentsPreview({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Comments',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton(
                onPressed: () => Get.bottomSheet(
                  CommentSheetContent(
                    contentId: controller.content.value.id,
                    onCountChanged: controller.refreshCommentCount,
                  ),
                  isScrollControlled: true,
                ),
                child: const Text(
                  'View all',
                  style: TextStyle(
                    color: AppColors.terracotta,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Obx(() {
            final preview = controller.comments.take(2).toList();
            if (preview.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Be the first to comment.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }
            return Column(
              children: preview
                  .map(
                    (c) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AvatarPlaceholder(
                            colorIndex: c.avatarColorIndex,
                            size: 34,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      c.authorName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      c.timeAgo,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  c.text,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(fontSize: 13.5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            );
          }),
        ],
      ),
    );
  }
}
