// lib/features/detail/views/detail_view.dart

import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/app/widgets/safe_cached_network_image.dart';
import 'package:egliloo/data/models/category_model.dart';
import 'package:egliloo/data/models/content_model.dart';
import 'package:egliloo/features/detail/controllers/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final content = controller.content.value;
      if (content == null) {
        return const Scaffold(
          backgroundColor: AppColors.backgroundDark,
          body: Center(child: CircularProgressIndicator()),
        );
      }
      return Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: CustomScrollView(
          slivers: [
            _buildHeroAppBar(content),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContentHeader(content),
                  _buildActionBar(),
                  _buildTabBar(),
                  _buildTabContent(content),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomCTA(content),
      );
    });
  }

  // ─── HERO APPBAR ─────────────────────────────────────────────────────────
  SliverAppBar _buildHeroAppBar(ContentModel content) {
    return SliverAppBar(
      expandedHeight: 320.h,
      pinned: true,
      backgroundColor: AppColors.backgroundDark,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
        onPressed: Get.back,
      ),
      actions: [
        Obx(
          () => IconButton(
            icon: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: Icon(
                controller.isBookmarked.value
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                color: controller.isBookmarked.value
                    ? AppColors.primary
                    : Colors.white,
                size: 18,
              ),
            ),
            onPressed: controller.toggleBookmark,
          ),
        ),
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.share_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),
          onPressed: () {},
        ),
        SizedBox(width: 4.w),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            SafeNetworkImage(imageUrl: content.coverImage, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xFF0C0C0C)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── CONTENT HEADER ──────────────────────────────────────────────────────
  Widget _buildContentHeader(ContentModel content) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tags row
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              _Tag(label: content.typeLabel, color: AppColors.primary),
              if (content.country != null)
                _Tag(label: '🌍 ${content.country!}'),
              _Tag(label: content.language.toUpperCase()),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          // Title
          Text(
            content.title,
            style: AppTypography.headlineMedium.copyWith(
              color: AppColors.textPrimaryDark,
            ),
          ),
          if (content.subtitle != null) ...[
            SizedBox(height: 4.h),
            Text(
              content.subtitle!,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondaryDark,
              ),
            ),
          ],
          SizedBox(height: AppSpacing.base),
          // Author row
          Row(
            children: [
              ClipOval(
                child: SafeNetworkImage(
                  imageUrl: content.authorAvatar ?? 'https://i.pravatar.cc/150',
                  width: 36.w,
                  height: 36.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.authorName,
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    Text(
                      'Auteur',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiaryDark,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => OutlinedButton(
                  onPressed: controller.toggleFollowAuthor,
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(80.w, 32.h),
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                    side: BorderSide(
                      color: controller.isFollowingAuthor.value
                          ? AppColors.primary
                          : AppColors.borderDark,
                    ),
                    foregroundColor: controller.isFollowingAuthor.value
                        ? AppColors.primary
                        : AppColors.textSecondaryDark,
                  ),
                  child: Text(
                    controller.isFollowingAuthor.value ? 'Suivi ✓' : 'Suivre',
                    style: AppTypography.labelSmall,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.base),
          // Stats row
          Row(
            children: [
              _Stat(
                icon: Icons.visibility_outlined,
                value: _formatNumber(content.viewsCount),
              ),
              SizedBox(width: AppSpacing.base),
              _Stat(
                icon: Icons.favorite_outline_rounded,
                value: _formatNumber(content.likesCount),
              ),
              SizedBox(width: AppSpacing.base),
              _Stat(
                icon: Icons.star_rounded,
                value: content.rating.toStringAsFixed(1),
                color: AppColors.warning,
              ),
              SizedBox(width: AppSpacing.base),
              if (content.readingTimeMinutes != null)
                _Stat(
                  icon: Icons.schedule_rounded,
                  value: '${content.readingTimeMinutes}min',
                ),
              if (content.formattedDuration.isNotEmpty)
                _Stat(
                  icon: Icons.schedule_rounded,
                  value: content.formattedDuration,
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── ACTION BAR ──────────────────────────────────────────────────────────
  Widget _buildActionBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: Row(
        children: [
          Obx(
            () => _ActionBtn(
              icon: controller.isLiked.value
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              label: 'J\'aime',
              color: controller.isLiked.value
                  ? AppColors.error
                  : AppColors.textTertiaryDark,
              onTap: controller.toggleLike,
            ),
          ),
          SizedBox(width: AppSpacing.base),
          _ActionBtn(
            icon: Icons.chat_bubble_outline_rounded,
            label: 'Commenter',
            onTap: () => controller.selectTab(2),
          ),
          SizedBox(width: AppSpacing.base),
          _ActionBtn(
            icon: Icons.download_outlined,
            label: 'Télécharger',
            onTap: () {},
          ),
          SizedBox(width: AppSpacing.base),
          _ActionBtn(
            icon: Icons.share_outlined,
            label: 'Partager',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ─── TAB BAR ─────────────────────────────────────────────────────────────
  Widget _buildTabBar() {
    final tabs = ['À propos', 'Contenu', 'Commentaires'];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.base,
      ),
      child: Obx(
        () => Row(
          children: tabs.asMap().entries.map((e) {
            final isSelected = controller.selectedTab.value == e.key;
            return GestureDetector(
              onTap: () => controller.selectTab(e.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(right: AppSpacing.sm),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primarySurface
                      : Colors.transparent,
                  borderRadius: AppRadius.fullAll,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.borderDark,
                  ),
                ),
                child: Text(
                  e.value,
                  style: AppTypography.labelSmall.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textTertiaryDark,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ─── TAB CONTENT ─────────────────────────────────────────────────────────
  Widget _buildTabContent(ContentModel content) {
    return Obx(() {
      switch (controller.selectedTab.value) {
        case 0:
          return _buildAboutTab(content);
        case 1:
          return _buildContentTab(content);
        case 2:
          return _buildCommentsTab();
        default:
          return const SizedBox();
      }
    });
  }

  Widget _buildAboutTab(ContentModel content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textPrimaryDark,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            content.description,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondaryDark,
              height: 1.7,
            ),
          ),
          SizedBox(height: AppSpacing.xl),
          // Tags
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: content.tags
                .map(
                  (t) => Chip(
                    label: Text(
                      t,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                    backgroundColor: AppColors.surfaceDark2,
                  ),
                )
                .toList(),
          ),
          // Quiz CTA
          if (content.quizIds != null && content.quizIds!.isNotEmpty) ...[
            SizedBox(height: AppSpacing.xl),
            Container(
              padding: EdgeInsets.all(AppSpacing.base),
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: AppRadius.mdAll,
                border: Border.all(color: AppColors.primary, width: 0.5),
              ),
              child: Row(
                children: [
                  Text('🧠', style: TextStyle(fontSize: 28.sp)),
                  SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quiz disponible',
                          style: AppTypography.titleSmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          'Testez votre compréhension et gagnez des XP',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.toNamed(
                      Routes.quiz,
                      arguments: content.quizIds!.first,
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(60.w, 32.h),
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                    ),
                    child: Text(
                      'Jouer',
                      style: AppTypography.labelSmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContentTab(ContentModel content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (content.isReadable && content.content != null)
            GestureDetector(
              onTap: () => Get.toNamed(Routes.reader, arguments: content),
              child: Container(
                padding: EdgeInsets.all(AppSpacing.base),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: AppRadius.mdAll,
                  border: Border.all(color: AppColors.borderDark),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      color: AppColors.primary,
                      size: 28.sp,
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lire le texte',
                            style: AppTypography.titleSmall.copyWith(
                              color: AppColors.textPrimaryDark,
                            ),
                          ),
                          Text(
                            '${content.readingTimeMinutes ?? "?"} min de lecture',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textTertiaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.textTertiaryDark,
                      size: 14.sp,
                    ),
                  ],
                ),
              ),
            ),
          if (content.isAudio) ...[
            SizedBox(height: AppSpacing.sm),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.audioPlayer, arguments: content),
              child: Container(
                padding: EdgeInsets.all(AppSpacing.base),
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: AppRadius.mdAll,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.headphones_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Écouter l\'audio',
                            style: AppTypography.titleSmall.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            content.formattedDuration,
                            style: AppTypography.caption.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.play_circle_filled_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ],
                ),
              ),
            ),
          ],
          if (content.isVideo) ...[
            SizedBox(height: AppSpacing.sm),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.videoPlayer, arguments: content),
              child: Container(
                padding: EdgeInsets.all(AppSpacing.base),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: AppRadius.mdAll,
                  border: Border.all(color: AppColors.borderDark),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.play_circle_outline_rounded,
                      color: AppColors.secondary,
                      size: 28.sp,
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Regarder la vidéo',
                        style: AppTypography.titleSmall.copyWith(
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.textTertiaryDark,
                      size: 14.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCommentsTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: Obx(() {
        if (controller.isLoadingComments.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Comment input
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: AppRadius.fullAll,
                border: Border.all(color: AppColors.borderDark),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Ajouter un commentaire...',
                        border: InputBorder.none,
                        hintStyle: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiaryDark,
                        ),
                        contentPadding: EdgeInsets.zero,
                        filled: false,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.send_rounded,
                    color: AppColors.primary,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.base),
            ...controller.comments.map((c) => _CommentCard(comment: c)),
          ],
        );
      }),
    );
  }

  // ─── BOTTOM CTA ──────────────────────────────────────────────────────────
  Widget _buildBottomCTA(ContentModel content) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.base,
        AppSpacing.sm,
        AppSpacing.base,
        AppSpacing.xxl,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: const Border(
          top: BorderSide(color: AppColors.dividerDark, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          if (content.isAudio || content.isVideo) ...[
            Expanded(
              child: ElevatedButton.icon(
                icon: Icon(
                  content.isAudio
                      ? Icons.play_arrow_rounded
                      : Icons.play_circle_rounded,
                  color: Colors.white,
                ),
                label: Text(content.isAudio ? 'Écouter' : 'Regarder'),
                onPressed: () => content.isAudio
                    ? Get.toNamed(Routes.audioPlayer, arguments: content)
                    : Get.toNamed(Routes.videoPlayer, arguments: content),
              ),
            ),
          ] else ...[
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.menu_book_rounded, color: Colors.white),
                label: const Text('Lire maintenant'),
                onPressed: () => Get.toNamed(Routes.reader, arguments: content),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }
}

// ─── HELPERS ─────────────────────────────────────────────────────────────────
class _Tag extends StatelessWidget {
  final String label;
  final Color color;

  const _Tag({required this.label, this.color = AppColors.surfaceDark2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: AppRadius.fullAll,
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _Stat({
    required this.icon,
    required this.value,
    this.color = AppColors.textTertiaryDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: color),
        SizedBox(width: 3.w),
        Text(value, style: AppTypography.caption.copyWith(color: color)),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = AppColors.textTertiaryDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 22.sp),
          SizedBox(height: 2.h),
          Text(label, style: AppTypography.caption.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _CommentCard extends StatelessWidget {
  final CommentModel comment;

  const _CommentCard({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.base),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: SafeNetworkImage(
              imageUrl: comment.userAvatar ?? 'https://i.pravatar.cc/150',
              width: 36.w,
              height: 36.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.userName,
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      _timeAgo(comment.createdAt),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiaryDark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  comment.text,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondaryDark,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 14.sp,
                      color: AppColors.textTertiaryDark,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      '${comment.likesCount}',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiaryDark,
                      ),
                    ),
                    SizedBox(width: AppSpacing.base),
                    Text(
                      'Répondre',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textTertiaryDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return 'il y a ${diff.inDays}j';
    if (diff.inHours > 0) return 'il y a ${diff.inHours}h';
    return 'il y a ${diff.inMinutes}min';
  }
}
