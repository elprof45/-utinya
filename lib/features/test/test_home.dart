import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

// void main() {
//   runApp(const AfoMediaApp());
// }

class AfoMediaAppN1 extends StatelessWidget {
  const AfoMediaAppN1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AFO Média',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0D10),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
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
                    _buildRecentVideos(),
                    const SizedBox(height: 18),
                    _buildSectionHeader(
                      icon: Icons.star_rounded,
                      title: 'Les vidéos les mieux notées',
                    ),
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
        onChanged: (i) => setState(() => _selectedBottomIndex = i),
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
            child: _VideoStripCard(video: video),
          );
        },
      ),
    );
  }

  Widget _buildRecentVideos() {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _recentVideos.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final video = _recentVideos[index];
          return SizedBox(width: 310, child: _RecentVideoCard(video: video));
        },
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
          Image.network(card.backgroundImage, fit: BoxFit.cover),
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
                icon: Icons.person_outline,
                label: 'Profil',
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
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
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
