import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:open_filex/open_filex.dart';

/// pubspec.yaml dependencies:
///
/// dependencies:
///   flutter:
///     sdk: flutter
///   dio: ^5.7.0
///   provider: ^6.1.2
///   path_provider: ^2.1.4
///   path: ^1.9.0
///   share_plus: ^10.0.2
///   open_filex: ^4.5.0
///   permission_handler: ^11.3.1
///
/// Android: add permissions in AndroidManifest.xml if you download outside app dir.
/// Recommended storage: app documents directory to avoid extra permissions.

// void main() {
//   runApp(const AfoMediaApp());
// }

class AfoMediaAppN2 extends StatelessWidget {
  const AfoMediaAppN2({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DownloadManager()..seedFakeItems(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AFO Média',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0B0D10),
          useMaterial3: true,
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2F97F0),
            brightness: Brightness.dark,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _currentPage = 0;
  int _selectedBottomIndex = 0;

  final List<HeroCardData> _heroCards = const [
    HeroCardData(
      chip: 'CHRONIQUE',
      title: 'Mali : qui se cache derrière l...',
      description:
          'Ils attaquent en même temps dans toutes les régions, avec des armes sophistiquées. Pourtant, silence de la communauté dite internationale. Préfère-t-on les terroristes aux autorités militaires ? Indifférence ou complicité ? Que penser de la lutte contre le terrorisme ?',
      buttonText: 'Regarder maintenant',
      buttonWidthFactor: 0.74,
      backgroundImage:
          'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=1200&q=80',
      backgroundTint: Color(0xFF6B2DFF),
      chipColor: Color(0xFFB85CF6),
      overlayOpacity: 0.62,
    ),
    HeroCardData(
      chip: 'Parlons vrai',
      title: 'LA FRANÇAFRIQUE EST-ELLE...',
      description:
          'Les anciens sommets France-Afrique se tiendront désormais à Nairobi sous l’appellation “Africa Forwa...',
      buttonText: 'Regarder',
      buttonWidthFactor: 0.36,
      backgroundImage:
          'https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?auto=format&fit=crop&w=1200&q=80',
      backgroundTint: Color(0xFF16253B),
      chipColor: Color(0xFF7FB4E6),
      overlayOpacity: 0.58,
    ),
  ];

  final List<CategoryChipData> _categories = const [
    CategoryChipData(label: 'Documentaire', selected: true),
    CategoryChipData(label: 'Reportage', selected: false),
    CategoryChipData(label: 'Chronique', selected: false),
  ];

  final List<RecentVideoData> _recentVideos = const [
    RecentVideoData(
      title: 'Le robot va-t-il tuer l’homme ?',
      duration: '54 min : 04 s',
      tag: 'Gratuit',
      image:
          'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=1200&q=80',
      overlayLabel: 'Chronique',
    ),
    RecentVideoData(
      title: 'FANON : ...',
      duration: '42 min : 12 s',
      tag: 'Gratuit',
      image:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=1200&q=80',
      overlayLabel: 'Les Immortels',
    ),
    RecentVideoData(
      title: 'Afrique Forward',
      duration: '38 min : 31 s',
      tag: 'Premium',
      image:
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=1200&q=80',
      overlayLabel: 'Parlons vrai',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_pageController.hasClients) return;
      final next = (_currentPage + 1) % _heroCards.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _TopBar(),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildHeroCarousel(context),
                    const SizedBox(height: 18),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Parcourir par catégorie',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.6,
                          height: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildCategoryChips(),
                    const SizedBox(height: 18),
                    _buildThumbnailStrip(context),
                    const SizedBox(height: 18),
                    _buildSectionHeader(
                      icon: Icons.timer_outlined,
                      title: 'Les vidéos les plus récentes',
                    ),
                    const SizedBox(height: 14),
                    _buildRecentVideos(context),
                    const SizedBox(height: 18),
                    _buildSectionHeader(
                      icon: Icons.star_rounded,
                      title: 'Les vidéos les mieux notées',
                    ),
                    const SizedBox(height: 18),
                    _buildHighlightedActions(context),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _selectedBottomIndex,
        onChanged: (i) async {
          setState(() => _selectedBottomIndex = i);
          if (i == 4) {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const DownloadHistoryPage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildHeroCarousel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AspectRatio(
        aspectRatio: 0.82,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _heroCards.length,
          onPageChanged: (index) => setState(() => _currentPage = index),
          itemBuilder: (context, index) {
            final card = _heroCards[index];
            return _HeroCard(card: card, isActive: index == _currentPage);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = _categories[index];
          return _CategoryChip(label: item.label, selected: item.selected);
        },
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemCount: _categories.length,
      ),
    );
  }

  Widget _buildThumbnailStrip(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _recentVideos.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final video = _recentVideos[index];
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => VideoDetailPage(video: video),
                  ),
                );
              },
              child: _VideoStripCard(video: video),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecentVideos(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _recentVideos.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final video = _recentVideos[index];
          return SizedBox(
            width: 310,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => VideoDetailPage(video: video),
                  ),
                );
              },
              child: _RecentVideoCard(video: video),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHighlightedActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _ActionTile(
            icon: Icons.download_rounded,
            title: 'Historique de téléchargement',
            subtitle: 'Progression, terminé, en pause et suppression',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const DownloadHistoryPage()),
            ),
          ),
          const SizedBox(height: 14),
          _ActionTile(
            icon: Icons.storage_rounded,
            title: 'Gestion des fichiers',
            subtitle: 'Ouvrir, partager, supprimer, renommer',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const DownloadHistoryPage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF3DA6FF), size: 22),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoDetailPage extends StatelessWidget {
  const VideoDetailPage({super.key, required this.video});

  final RecentVideoData video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D10),
      body: SafeArea(
        child: Column(
          children: [
            _DetailTopBar(title: 'Reportage'),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: AspectRatio(
                      aspectRatio: 1.55,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              video.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(color: Colors.black.withOpacity(0.70)),
                          const Center(
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: 84,
                              color: Colors.white70,
                            ),
                          ),
                          const Positioned(
                            right: 18,
                            bottom: 18,
                            child: Icon(
                              Icons.fullscreen_rounded,
                              size: 34,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: const [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 22,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '7 juin 2026',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                      SizedBox(width: 22),
                      Icon(
                        Icons.access_time_rounded,
                        size: 22,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '29 min : 46 s',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '120 ANS DE GECAMINES : Qu\'en reste-t-il ?',
                    style: const TextStyle(
                      fontSize: 22,
                      height: 1.25,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _SocialCircle(
                        icon: Icons.facebook_outlined,
                        onTap: () {},
                      ),
                      const SizedBox(width: 12),
                      _SocialCircle(
                        icon: Icons.phone_in_talk_outlined,
                        onTap: () {},
                      ),
                      const SizedBox(width: 12),
                      _SocialCircle(icon: Icons.close_rounded, onTap: () {}),
                      const SizedBox(width: 12),
                      _SocialCircle(
                        icon: Icons.crop_square_rounded,
                        onTap: () {},
                      ),
                      const SizedBox(width: 12),
                      _SocialCircle(icon: Icons.share_outlined, onTap: () {}),
                      const Spacer(),
                      _DownloadButton(video: video),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Télécharger cette vidéo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Choisis une qualité. Le téléchargement apparaît ensuite dans l’historique avec sa progression.',
                    style: TextStyle(color: Colors.white70, height: 1.35),
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

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({required this.video});

  final RecentVideoData video;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: const Color(0xFF111114),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          builder: (_) => DownloadSheet(video: video),
        );
      },
      icon: const Icon(Icons.download_rounded),
      label: const Text('Télécharger'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1C1D20),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class DownloadSheet extends StatelessWidget {
  const DownloadSheet({super.key, required this.video});

  final RecentVideoData video;

  @override
  Widget build(BuildContext context) {
    final manager = context.watch<DownloadManager>();
    final qualities = const [
      ('MP4(180)', '55,45 MB'),
      ('MP4(270)', '79,40 MB'),
      ('MP4(720)', '257,42 MB'),
      ('MP4(1080)', '488,44 MB'),
      ('MP4(360)', '106,09 MB'),
      ('MP4(540)', '181,15 MB'),
    ];

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.78,
        child: Column(
          children: [
            const SizedBox(height: 14),
            Container(
              width: 56,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(height: 26),
            const Text(
              'Télécharger',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
                itemCount: qualities.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, index) {
                  final q = qualities[index];
                  return _DownloadQualityTile(
                    label: q.$1,
                    sizeLabel: q.$2,
                    onDownload: () => manager.startDownload(
                      title: '${video.title} ${q.$1}',
                      quality: q.$1,
                      sizeLabel: q.$2,
                      sourceUrl: video.image,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DownloadQualityTile extends StatelessWidget {
  const _DownloadQualityTile({
    required this.label,
    required this.sizeLabel,
    required this.onDownload,
  });

  final String label;
  final String sizeLabel;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF16181C),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 92,
            child: Text(label, style: const TextStyle(fontSize: 20)),
          ),
          const Spacer(),
          Text(
            '$sizeLabel MB',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          const Spacer(),
          IconButton(
            onPressed: onDownload,
            icon: const Icon(Icons.download_rounded, size: 30),
          ),
        ],
      ),
    );
  }
}

class DownloadHistoryPage extends StatelessWidget {
  const DownloadHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D10),
      body: SafeArea(
        child: Column(
          children: [
            const _DetailTopBar(title: 'Téléchargements'),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Consumer<DownloadManager>(
                builder: (context, manager, _) {
                  return Row(
                    children: [
                      _FilterPill(
                        label: 'Tous',
                        selected: manager.filter == DownloadFilter.all,
                        onTap: () => manager.setFilter(DownloadFilter.all),
                      ),
                      const SizedBox(width: 10),
                      _FilterPill(
                        label: 'En cours',
                        selected: manager.filter == DownloadFilter.downloading,
                        onTap: () =>
                            manager.setFilter(DownloadFilter.downloading),
                      ),
                      const SizedBox(width: 10),
                      _FilterPill(
                        label: 'Terminés',
                        selected: manager.filter == DownloadFilter.completed,
                        onTap: () =>
                            manager.setFilter(DownloadFilter.completed),
                      ),
                      const SizedBox(width: 10),
                      _FilterPill(
                        label: 'Échoués',
                        selected: manager.filter == DownloadFilter.failed,
                        onTap: () => manager.setFilter(DownloadFilter.failed),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Consumer<DownloadManager>(
                builder: (context, manager, _) {
                  final items = manager.filteredItems;
                  if (items.isEmpty) {
                    return const Center(
                      child: Text(
                        'Aucun téléchargement',
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      final item = items[index];
                      return _DownloadHistoryTile(item: item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DownloadHistoryTile extends StatelessWidget {
  const _DownloadHistoryTile({required this.item});

  final DownloadItem item;

  @override
  Widget build(BuildContext context) {
    final manager = context.watch<DownloadManager>();
    final statusColor = switch (item.status) {
      DownloadStatus.downloading => const Color(0xFF2F97F0),
      DownloadStatus.completed => const Color(0xFF4FC05E),
      DownloadStatus.failed => const Color(0xFFE25C5C),
      DownloadStatus.paused => const Color(0xFFE4B84C),
      DownloadStatus.canceled => Colors.white54,
      DownloadStatus.pending => Colors.white54,
    };

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF16181C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: 72,
                  height: 72,
                  color: const Color(0xFF0F1114),
                  child: item.thumbnailUrl == null
                      ? const Icon(
                          Icons.movie_outlined,
                          size: 30,
                          color: Colors.white30,
                        )
                      : Image.network(item.thumbnailUrl!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${item.quality} • ${item.sizeLabel}',
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.statusLabel,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                color: const Color(0xFF1B1D21),
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white70,
                ),
                onSelected: (value) async {
                  switch (value) {
                    case 'open':
                      await manager.openItem(item);
                      break;
                    case 'share':
                      await manager.shareItem(item);
                      break;
                    case 'delete':
                      await manager.deleteItem(item.id);
                      break;
                    case 'pause':
                      manager.pauseItem(item.id);
                      break;
                    case 'resume':
                      manager.resumeItem(item.id);
                      break;
                    case 'retry':
                      manager.retryItem(item.id);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (item.status == DownloadStatus.completed)
                    const PopupMenuItem(value: 'open', child: Text('Ouvrir')),
                  if (item.status == DownloadStatus.completed)
                    const PopupMenuItem(
                      value: 'share',
                      child: Text('Partager'),
                    ),
                  if (item.status == DownloadStatus.downloading)
                    const PopupMenuItem(value: 'pause', child: Text('Pause')),
                  if (item.status == DownloadStatus.paused)
                    const PopupMenuItem(
                      value: 'resume',
                      child: Text('Reprendre'),
                    ),
                  if (item.status == DownloadStatus.failed)
                    const PopupMenuItem(
                      value: 'retry',
                      child: Text('Réessayer'),
                    ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Supprimer'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: item.progress,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '${(item.progress * 100).toStringAsFixed(0)}%',
                style: const TextStyle(color: Colors.white70),
              ),
              const Spacer(),
              Text(
                item.localPath == null
                    ? 'En attente'
                    : p.basename(item.localPath!),
                style: const TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
          if (item.status == DownloadStatus.downloading) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => manager.cancelItem(item.id),
                child: const Text('Annuler'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class DownloadManager extends ChangeNotifier {
  final Dio _dio = Dio();
  final Map<String, CancelToken> _cancelTokens = {};
  final List<DownloadItem> _items = [];
  DownloadFilter filter = DownloadFilter.all;

  List<DownloadItem> get items => List.unmodifiable(_items);

  List<DownloadItem> get filteredItems {
    switch (filter) {
      case DownloadFilter.all:
        return items;
      case DownloadFilter.downloading:
        return items
            .where(
              (e) =>
                  e.status == DownloadStatus.downloading ||
                  e.status == DownloadStatus.paused ||
                  e.status == DownloadStatus.pending,
            )
            .toList();
      case DownloadFilter.completed:
        return items
            .where((e) => e.status == DownloadStatus.completed)
            .toList();
      case DownloadFilter.failed:
        return items
            .where(
              (e) =>
                  e.status == DownloadStatus.failed ||
                  e.status == DownloadStatus.canceled,
            )
            .toList();
    }
  }

  void setFilter(DownloadFilter value) {
    filter = value;
    notifyListeners();
  }

  void seedFakeItems() {
    _items.addAll([
      DownloadItem(
        id: '1',
        title: '120 ANS DE GECAMINES : Qu\'en reste-t-il ?',
        quality: 'MP4(720)',
        sizeLabel: '257,42 MB',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=1200&q=80',
        progress: 1,
        status: DownloadStatus.completed,
        localPath: '/storage/emulated/0/Download/gecamines_720.mp4',
      ),
      DownloadItem(
        id: '2',
        title: 'LA FRANÇAFRIQUE EST-ELLE...',
        quality: 'MP4(1080)',
        sizeLabel: '488,44 MB',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?auto=format&fit=crop&w=1200&q=80',
        progress: 0.42,
        status: DownloadStatus.downloading,
      ),
      DownloadItem(
        id: '3',
        title: 'Le robot va-t-il tuer l’homme ?',
        quality: 'MP4(360)',
        sizeLabel: '106,09 MB',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=1200&q=80',
        progress: 0.0,
        status: DownloadStatus.pending,
      ),
      DownloadItem(
        id: '4',
        title: 'Afrique Forward',
        quality: 'MP4(540)',
        sizeLabel: '181,15 MB',
        thumbnailUrl:
            'https://images.unsplash.com/photo-1534447677768-be436bb09401?auto=format&fit=crop&w=1200&q=80',
        progress: 0.67,
        status: DownloadStatus.paused,
      ),
    ]);
  }

  Future<void> startDownload({
    required String title,
    required String quality,
    required String sizeLabel,
    required String sourceUrl,
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final item = DownloadItem(
      id: id,
      title: title,
      quality: quality,
      sizeLabel: sizeLabel,
      progress: 0,
      status: DownloadStatus.pending,
      thumbnailUrl: sourceUrl,
    );
    _items.insert(0, item);
    notifyListeners();

    final cancelToken = CancelToken();
    _cancelTokens[id] = cancelToken;

    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName =
          '${title.replaceAll(RegExp(r'[^a-zA-Z0-9\-\_]+'), '_')}_${quality.replaceAll(RegExp(r'[^a-zA-Z0-9\-\_]+'), '_')}.mp4';
      final savePath = p.join(dir.path, 'downloads', fileName);
      await Directory(p.dirname(savePath)).create(recursive: true);

      item.status = DownloadStatus.downloading;
      notifyListeners();

      await _dio.download(
        sourceUrl,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) {
          if (total <= 0) return;
          item.progress = received / total;
          notifyListeners();
        },
      );

      item.status = DownloadStatus.completed;
      item.progress = 1;
      item.localPath = savePath;
      notifyListeners();
    } on DioException catch (_) {
      item.status = cancelToken.isCancelled
          ? DownloadStatus.canceled
          : DownloadStatus.failed;
      notifyListeners();
    } catch (_) {
      item.status = DownloadStatus.failed;
      notifyListeners();
    } finally {
      _cancelTokens.remove(id);
    }
  }

  void pauseItem(String id) {
    final item = _items.where((e) => e.id == id).firstOrNull;
    if (item == null) return;
    final token = _cancelTokens[id];
    token?.cancel('paused');
    item.status = DownloadStatus.paused;
    notifyListeners();
  }

  void resumeItem(String id) {
    final item = _items.where((e) => e.id == id).firstOrNull;
    if (item == null) return;
    if (item.status != DownloadStatus.paused) return;
    item.status = DownloadStatus.pending;
    notifyListeners();
  }

  void cancelItem(String id) {
    final token = _cancelTokens[id];
    token?.cancel('canceled');
    final item = _items.where((e) => e.id == id).firstOrNull;
    if (item != null) {
      item.status = DownloadStatus.canceled;
      notifyListeners();
    }
  }

  void retryItem(String id) {
    final item = _items.where((e) => e.id == id).firstOrNull;
    if (item == null) return;
    item.status = DownloadStatus.pending;
    item.progress = 0;
    notifyListeners();
  }

  Future<void> deleteItem(String id) async {
    final item = _items.where((e) => e.id == id).firstOrNull;
    if (item == null) return;

    if (item.localPath != null) {
      final file = File(item.localPath!);
      if (await file.exists()) {
        await file.delete();
      }
    }

    _cancelTokens[id]?.cancel('deleted');
    _cancelTokens.remove(id);
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  Future<void> openItem(DownloadItem item) async {
    if (item.localPath == null) return;
    await OpenFilex.open(item.localPath!);
  }

  Future<void> shareItem(DownloadItem item) async {
    if (item.localPath == null) return;
    await Share.shareXFiles([XFile(item.localPath!)], text: item.title);
  }
}

class DownloadItem {
  DownloadItem({
    required this.id,
    required this.title,
    required this.quality,
    required this.sizeLabel,
    required this.progress,
    required this.status,
    this.localPath,
    this.thumbnailUrl,
  });

  final String id;
  final String title;
  final String quality;
  final String sizeLabel;
  String? localPath;
  final String? thumbnailUrl;
  double progress;
  DownloadStatus status;

  String get statusLabel {
    return switch (status) {
      DownloadStatus.downloading => 'Téléchargement en cours',
      DownloadStatus.completed => 'Terminé',
      DownloadStatus.failed => 'Échec',
      DownloadStatus.paused => 'En pause',
      DownloadStatus.canceled => 'Annulé',
      DownloadStatus.pending => 'En attente',
    };
  }
}

enum DownloadStatus {
  pending,
  downloading,
  paused,
  completed,
  failed,
  canceled,
}

enum DownloadFilter { all, downloading, completed, failed }

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: const BoxDecoration(
        color: Color(0xFF11161B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_rounded, color: Colors.white, size: 34),
          const Spacer(),
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 22),
            decoration: BoxDecoration(
              color: const Color(0xFF1E80C7),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Text(
              'AFO Média',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
          const Spacer(),
          const Text('🇫🇷', style: TextStyle(fontSize: 30, height: 1)),
          const SizedBox(width: 18),
          const Icon(Icons.search_rounded, color: Colors.white, size: 34),
          const SizedBox(width: 18),
          const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
            size: 36,
          ),
          const SizedBox(width: 14),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF141A20), width: 2),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://i.pravatar.cc/150?img=12'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailTopBar extends StatelessWidget {
  const _DetailTopBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
          const Spacer(),
          Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.18),
                  Colors.white.withOpacity(0.08),
                ],
              ),
            ),
            child: const Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.card, required this.isActive});

  final HeroCardData card;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(card.backgroundImage, 
          fit: BoxFit.cover),
          Container(
            color: card.backgroundTint.withOpacity(card.overlayOpacity),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.10),
                  Colors.transparent,
                  Colors.black.withOpacity(0.28),
                  Colors.black.withOpacity(0.58),
                ],
                stops: const [0.0, 0.28, 0.70, 1.0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Chip(label: card.chip, color: card.chipColor),
                const Spacer(),
                Text(
                  card.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.7,
                    height: 1.05,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  card.description,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.95),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    '...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      height: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: card.buttonWidthFactor,
                    child: _GradientButton(label: card.buttonText),
                  ),
                ),
              ],
            ),
          ),
          if (isActive)
            Positioned(
              bottom: 18,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    6,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == 5 ? 38 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: i == 5
                            ? Colors.white
                            : Colors.white.withOpacity(0.28),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.34),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2E98F4), Color(0xFFB33ACF)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {},
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.play_arrow_rounded,
                  size: 28,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF2F97F0) : const Color(0xFF222325),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: selected ? Colors.transparent : const Color(0xFF44464A),
          width: 1.2,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : const Color(0xFFB0B2B6),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _VideoStripCard extends StatelessWidget {
  const _VideoStripCard({required this.video});

  final RecentVideoData video;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(video.image, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.05),
                  Colors.black.withOpacity(0.12),
                  Colors.black.withOpacity(0.50),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: _SmallTag(text: video.overlayLabel),
          ),
          const Center(
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Color(0x90FFFFFF),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 34,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                video.duration,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentVideoCard extends StatelessWidget {
  const _RecentVideoCard({required this.video});

  final RecentVideoData video;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.40,
                child: Image.network(video.image, fit: BoxFit.cover),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.12),
                      Colors.black.withOpacity(0.45),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: _SmallTag(text: video.overlayLabel),
              ),
              const Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xCCFFFFFF),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 38,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                right: 12,
                bottom: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    video.duration,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          video.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.35,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF17371B),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF255B28)),
          ),
          child: Text(
            video.tag,
            style: const TextStyle(
              color: Color(0xFF4FC05E),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _SmallTag extends StatelessWidget {
  const _SmallTag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.26),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF16181C),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2228),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: const Color(0xFF2F97F0)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white60,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white54,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.currentIndex, required this.onChanged});

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111114),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.04))),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 84,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                label: 'Accueil',
                active: currentIndex == 0,
                onTap: () => onChanged(0),
              ),
              _NavItem(
                icon: Icons.sports_esports_outlined,
                label: 'Quizz',
                active: currentIndex == 1,
                onTap: () => onChanged(1),
              ),
              _NavItem(
                icon: Icons.cast_connected_outlined,
                label: 'Nos vidéos',
                active: currentIndex == 2,
                onTap: () => onChanged(2),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _NavItem(
                    icon: Icons.auto_awesome_outlined,
                    label: 'Shorts',
                    active: currentIndex == 3,
                    onTap: () => onChanged(3),
                  ),
                  Positioned(
                    right: -12,
                    top: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2F97F0),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'nouveau',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _NavItem(
                icon: Icons.download_rounded,
                label: 'Télécharg.',
                active: currentIndex == 4,
                onTap: () => onChanged(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF2F97F0) : Colors.white;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color.withOpacity(active ? 1 : 0.92),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: selected,
      label: Text(label),
      onSelected: (_) => onTap(),
      selectedColor: const Color(0xFF2F97F0),
      backgroundColor: const Color(0xFF1B1D21),
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.white70),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
        side: BorderSide(color: selected ? Colors.transparent : Colors.white12),
      ),
    );
  }
}

class _SocialCircle extends StatelessWidget {
  const _SocialCircle({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1C20),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white70, size: 24),
      ),
    );
  }
}

extension FirstOrNullExt<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

class HeroCardData {
  const HeroCardData({
    required this.chip,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonWidthFactor,
    required this.backgroundImage,
    required this.backgroundTint,
    required this.chipColor,
    required this.overlayOpacity,
  });

  final String chip;
  final String title;
  final String description;
  final String buttonText;
  final double buttonWidthFactor;
  final String backgroundImage;
  final Color backgroundTint;
  final Color chipColor;
  final double overlayOpacity;
}

class CategoryChipData {
  const CategoryChipData({required this.label, required this.selected});

  final String label;
  final bool selected;
}

class RecentVideoData {
  const RecentVideoData({
    required this.title,
    required this.duration,
    required this.tag,
    required this.image,
    required this.overlayLabel,
  });

  final String title;
  final String duration;
  final String tag;
  final String image;
  final String overlayLabel;
}
