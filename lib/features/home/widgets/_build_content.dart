import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/features/home/widgets/_build_appbar.dart';
import 'package:egliloo/features/home/widgets/_build_category_chips.dart';
import 'package:egliloo/features/home/widgets/_build_featured_carousel.dart';
import 'package:egliloo/features/home/widgets/_build_popular_authors.dart';
import 'package:egliloo/features/home/widgets/_build_proverb_banner.dart';
import 'package:egliloo/features/home/widgets/_build_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:egliloo/features/home/controllers/home_controller.dart';

class BuildContent extends StatelessWidget {
  const BuildContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupération globale instantanée de votre contrôleur de page
    final controller = Get.find<HomeController>();

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surfaceDark,
      onRefresh: controller.refresh,
      child: CustomScrollView(
        slivers: [
          BuildAppBar(),

          // Utilisez des Slivers individuels plutôt qu'une grosse colonne unique
          SliverToBoxAdapter(child: BuildProverbBanner()),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl)),

          SliverToBoxAdapter(child: BuildFeaturedCarousel()),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),

          if (controller.continueReading.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: BuildSection(
                title: 'Continuer la lecture',
                icon: Icons.bookmark_rounded,
                items: controller.continueReading,
                showProgress: true,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
          ],

          SliverToBoxAdapter(
            child: BuildSection(
              title: 'Tendances',
              icon: Icons.trending_up_rounded,
              items: controller.trendingContent,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),

          SliverToBoxAdapter(child: BuildCategoryChips()),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),

          SliverToBoxAdapter(
            child: BuildSection(
              title: 'Livres Audio',
              icon: Icons.headphones_rounded,
              items: controller.audioBooks,
              cardStyle: ContentCardStyle.landscape,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),

          SliverToBoxAdapter(child: BuildPopularAuthors()),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),

          SliverToBoxAdapter(
            child: BuildSection(
              title: 'Contes & Légendes',
              icon: Icons.auto_stories_rounded,
              items: controller.tales,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),

          SliverToBoxAdapter(
            child: BuildSection(
              title: 'Podcasts',
              icon: Icons.mic_rounded,
              items: controller.podcasts,
              cardStyle: ContentCardStyle.landscape,
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: 100.h),
          ), // Espace mini-lecteur
        ],
      ),
    );
  }
}
