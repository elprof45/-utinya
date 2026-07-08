import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/widgets/widgets/card_hero.dart';
import 'package:egliloo/features/home/widgets/_build_appbar.dart';
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

    final List<HeroCardData> heroCards = const [
      HeroCardData(
        chip: 'CHRONIQUE',
        title: 'Mali : qui se cache derrière l...',
        description:
            'Ils attaquent en même temps dans toutes les régions, avec des armes sophistiquées. Pourtant, silence de la communauté dite internationale. Préfère-t-on les terroristes aux autorités militaires ? Indifférence ou complicité ? Que penser de la lutte contre le terrorisme ?',
        buttonText: 'Partager',
        buttonWidthFactor: 1,
        buttonIcon: Icons.share,
        buttonHeight: 35,
        backgroundImage:
            'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=1200&q=80',
        backgroundTint: Color(0xFF6B2DFF),
        chipColor: Color(0xFFB85CF6),
        overlayOpacity: 0.62,
      ),
    ];

    return RefreshIndicator(
      color: AppColors.primary,
      backgroundColor: AppColors.surfaceDark,
      onRefresh: controller.refresh,
      child: CustomScrollView(
        slivers: [
          BuildAppBar(),
          SliverToBoxAdapter(child: BuildFeaturedCarousel()),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
          SliverToBoxAdapter(child: BuildProverbBanner()),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

          if (controller.continueReading.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: BuildSection(
                title: 'Continuer la lecture',
                icon: Icons.bookmark_rounded,
                items: controller.continueReading,
                showProgress: true,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
          ],

          SliverToBoxAdapter(
            child: BuildSection(
              title: 'Tendances',
              icon: Icons.trending_up_rounded,
              items: controller.trendingContent,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

          SliverToBoxAdapter(
            child: BuildSection(
              title: 'Livres Audio',
              icon: Icons.headphones_rounded,
              items: controller.audioBooks,
              cardStyle: ContentCardStyle.landscape,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
          SliverToBoxAdapter(child: BuildPopularAuthors()),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
          SliverToBoxAdapter(
            child: BuildSection(
              title: 'Contes & Légendes',
              icon: Icons.auto_stories_rounded,
              items: controller.tales,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
          SliverToBoxAdapter(
            child: BuildSection(
              title: 'Podcasts',
              icon: Icons.mic_rounded,
              items: controller.podcasts,
              cardStyle: ContentCardStyle.landscape,
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
          SliverToBoxAdapter(
            child: HeroCard(card: heroCards[0], isActive: true),
          ),

          SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),
          SliverToBoxAdapter(
            child: BuildSection(
              title: 'Videos & Documentaries',
              icon: Icons.video_camera_back,
              items: controller.podcasts,
              cardStyle: ContentCardStyle.landscape,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 150.h),
          ), // Espace mini-lecteur
        ],
      ),
    );
  }
}
