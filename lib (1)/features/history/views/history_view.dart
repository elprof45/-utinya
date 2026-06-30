import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/models/content_model.dart';
import '../../../app/data/models/history_entry_model.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/widgets/tribal_divider.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History & Saved'),
        actions: [
          TextButton(
            onPressed: controller.clearAll,
            child: const Text(
              'Clear All',
              style: TextStyle(color: AppColors.terracotta),
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            _Section(
              title: 'Recently Played Audio',
              icon: Icons.headphones_rounded,
              entries: controller.recentlyPlayed,
              controller: controller,
              emptyLabel: 'Nothing played yet — explore Audio Tales on Home.',
            ),
            TribalDivider(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            ),
            _Section(
              title: 'Read Stories',
              icon: Icons.menu_book_rounded,
              entries: controller.readStories,
              controller: controller,
              emptyLabel: 'You haven\'t finished a story yet.',
            ),
            TribalDivider(
              color: AppColors.emerald,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            ),
            _Section(
              title: 'Bookmarked Proverbs',
              icon: Icons.bookmark_rounded,
              entries: controller.bookmarked,
              controller: controller,
              emptyLabel: 'Save proverbs you love to find them here.',
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<MapEntry<HistoryEntryModel, ContentModel>> entries;
  final HistoryController controller;
  final String emptyLabel;

  const _Section({
    required this.title,
    required this.icon,
    required this.entries,
    required this.controller,
    required this.emptyLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
          child: Row(
            children: [
              Icon(icon, size: 18, color: AppColors.terracotta),
              const SizedBox(width: 8),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
        if (entries.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Text(
              emptyLabel,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        else
          ...entries.map(
            (pair) => _HistoryTile(
              entry: pair.key,
              content: pair.value,
              controller: controller,
            ),
          ),
      ],
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final HistoryEntryModel entry;
  final ContentModel content;
  final HistoryController controller;

  const _HistoryTile({
    required this.entry,
    required this.content,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = AppColors.gradientFor(content.coverIndex);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => controller.openDetail(content),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(content.typeIcon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${content.category} · ${entry.timestamp}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (entry.progress > 0 && entry.progress < 1) ...[
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: entry.progress,
                        minHeight: 4,
                        backgroundColor: AppColors.ochre.withValues(
                          alpha: 0.15,
                        ),
                        color: AppColors.terracotta,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              onPressed: () => controller.removeEntry(entry),
              icon: const Icon(Icons.close_rounded, size: 18),
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ],
        ),
      ),
    );
  }
}
