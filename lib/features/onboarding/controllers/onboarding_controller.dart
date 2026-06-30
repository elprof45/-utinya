// lib/features/onboarding/controllers/onboarding_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:egliloo/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;
  final _storage = GetStorage();

  final pages = [
    OnboardingPage(
      emoji: '📚',
      title: 'Lisez l\'Afrique',
      subtitle:
          'Des milliers de livres, contes, légendes et histoires du continent africain à portée de main.',
      bgColor: const Color(0xFF1A0F04),
      accentColor: const Color(0xFFD4943A),
    ),
    OnboardingPage(
      emoji: '🎙️',
      title: 'Écoutez les Griots',
      subtitle:
          'Plongez dans des podcasts, livres audio et narrations IA multilingues dans vos langues africaines.',
      bgColor: const Color(0xFF0A1F15),
      accentColor: const Color(0xFF52B788),
    ),
    OnboardingPage(
      emoji: '🌍',
      title: 'Explorez le Continent',
      subtitle:
          'Naviguez sur une carte interactive de l\'Afrique et découvrez les trésors culturels de chaque pays.',
      bgColor: const Color(0xFF0D0A1A),
      accentColor: const Color(0xFF4895EF),
    ),
    OnboardingPage(
      emoji: '⭐',
      title: 'Gagnez des Badges',
      subtitle:
          'Lisez chaque jour, complétez des quiz, montez de niveau et devenez un Gardien du Patrimoine Africain.',
      bgColor: const Color(0xFF1A0F04),
      accentColor: const Color(0xFFE9C46A),
    ),
  ];

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void skipOnboarding() => completeOnboarding();

  void completeOnboarding() {
    _storage.write('hasSeenOnboarding', true);
    Get.offAllNamed(Routes.languageSelection);
  }

  void onPageChanged(int index) => currentPage.value = index;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingPage {
  final String emoji;
  final String title;
  final String subtitle;
  final Color bgColor;
  final Color accentColor;

  const OnboardingPage({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.accentColor,
  });
}
