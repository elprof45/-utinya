// lib/features/home/widgets/build_featured_carousel.dart
import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/app/widgets/safe_cached_network_image.dart';
import 'package:egliloo/data/models/content_model.dart';
import 'package:egliloo/features/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildFeaturedCarousel extends StatelessWidget {
  const BuildFeaturedCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(
      () => FlutterCarousel(
        options: FlutterCarouselOptions(
          height: 375.h,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          aspectRatio: 16 / 9,
          enableInfiniteScroll: true,
          floatingIndicator: true,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          showIndicator: false,
        ),
        items: controller.featuredContent
            .map((content) => _FeaturedCard(content: content))
            .toList(),
      ),
    );
  }
}

// ─── FEATURED CARD ───────────────────────────────────────────────────────────
class _FeaturedCard extends StatelessWidget {
  final ContentModel content;

  const _FeaturedCard({required this.content});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.detail, arguments: content),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: AppRadius.smAll,
          boxShadow: AppElevation.glow,
        ),
        child: ClipRRect(
          // borderRadius: AppRadius.lgAll,
          child: Stack(
            fit: StackFit.expand,
            children: [
              SafeNetworkImage(
                imageUrl: content.coverImage,
                fit: BoxFit.cover,
                cacheSize: 400, // Sécurise la RAM à hauteur du Carrousel
              ),
              // Gradient overlay
              DecoratedBox(
                decoration: BoxDecoration(gradient: AppColors.heroGradient1),
              ),
              // Content info
              Positioned(
                left: AppSpacing.base,
                right: AppSpacing.base,
                bottom: AppSpacing.base,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        _TypeBadge(label: content.typeLabel),
                        if (content.isTrending) ...[
                          SizedBox(width: AppSpacing.xs),
                          const _TypeBadge(
                            label: '🔥 Tendance',
                            color: AppColors.accent,
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      content.title,
                      style: AppTypography.headlineSmall.copyWith(
                        color: Colors.white,
                        shadows: [
                          const Shadow(blurRadius: 8, color: Colors.black54),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      content.authorName,
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── CONTENT CARD ENUMS ──────────────────────────────────────────────────────
enum ContentCardStyle { portrait, landscape }

class _TypeBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _TypeBadge({required this.label, this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.85),
        borderRadius: AppRadius.fullAll,
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
