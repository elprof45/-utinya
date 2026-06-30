import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/models/content_model.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/widgets/avatar_placeholder.dart';
import '../../../app/widgets/content_card.dart';
import '../../../app/widgets/featured_card.dart';
import '../../../app/widgets/section_header.dart';
import '../../../app/widgets/tribal_divider.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            expandedHeight: 180,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => Text(
                                '${controller.greeting}, ${controller.user.value.name.split(' ').first} 👋',
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.goToTab(4),
                            child: Obx(
                              () => AvatarPlaceholder(
                                colorIndex:
                                    controller.user.value.avatarColorIndex,
                                size: 38,
                                initials: _initials(controller.user.value.name),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tales, history & proverbs of Africa',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => _openSearchSheet(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: AppColors.ochre.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                size: 20,
                                color: AppColors.terracotta,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Search tales, history, proverbs…',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: SectionHeader(title: 'Daily Proverb & Chronicles'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Obx(
                () => PageView.builder(
                  controller: controller.bannerController,
                  onPageChanged: controller.onBannerScroll,
                  itemCount: controller.featured.length,
                  itemBuilder: (context, index) {
                    final item = controller.featured[index];
                    return FeaturedCard(
                      content: item,
                      onTap: () => controller.openDetail(item),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.featured.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 10,
                    ),
                    width: controller.currentBanner.value == i ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: controller.currentBanner.value == i
                          ? AppColors.terracotta
                          : AppColors.terracotta.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TribalDivider(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            ),
          ),
          _horizontalSection(
            context,
            'Audio Tales',
            controller.audioTales,
            () => controller.goToTab(1),
          ),
          SliverToBoxAdapter(
            child: TribalDivider(
              color: AppColors.emerald,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            ),
          ),
          _horizontalSection(
            context,
            'Rich History',
            controller.richHistory,
            () => controller.goToTab(2),
          ),
          SliverToBoxAdapter(
            child: TribalDivider(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            ),
          ),
          _horizontalSection(
            context,
            'Videos & Documentaries',
            controller.videos,
            () => controller.goToTab(1),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _horizontalSection(
    BuildContext context,
    String title,
    List<ContentModel> items,
    VoidCallback onSeeAll,
  ) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: title,
            actionLabel: 'See all',
            onAction: onSeeAll,
          ),
          SizedBox(
            height: 188,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final item = items[index];
                return ContentCard(
                  content: item,
                  onTap: () => controller.openDetail(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  void _openSearchSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.78,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          children: [
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.ochre.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.searchController,
              autofocus: true,
              onChanged: controller.search,
              decoration: InputDecoration(
                hintText: 'Search tales, history, proverbs…',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: controller.clearSearch,
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.searchResults.isEmpty) {
                  return Center(
                    child: Text(
                      controller.searchController.text.isEmpty
                          ? 'Start typing to discover tales, proverbs and history.'
                          : 'No results found.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: controller.searchResults.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final item = controller.searchResults[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: AppColors.gradientFor(item.coverIndex),
                          ),
                        ),
                        child: Icon(
                          item.typeIcon,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(item.category),
                      onTap: () {
                        Get.back();
                        controller.openDetail(item);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
