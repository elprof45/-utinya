import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class OnboardingStepData {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;

  OnboardingStepData({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingStepData> steps = [
    OnboardingStepData(
      title: 'Preserve Living Heritage',
      description:
          'Discover oral traditions, folktales and proverbs passed down through generations across the African continent.',
      icon: Icons.auto_stories_rounded,
      gradient: const [Color(0xFFD4AF37), Color(0xFFC05A3E)],
    ),
    OnboardingStepData(
      title: 'Epic History, Retold',
      description:
          'Explore the empires, kingdoms and legendary figures that shaped Africa, told through audio chronicles and rich visuals.',
      icon: Icons.account_balance_rounded,
      gradient: const [Color(0xFF0A5C36), Color(0xFF1E1611)],
    ),
    OnboardingStepData(
      title: 'Listen. Read. Watch.',
      description:
          'Immerse yourself in narrated tales, illustrated stories and short films — wherever you are, whenever you like.',
      icon: Icons.headphones_rounded,
      gradient: const [Color(0xFFC05A3E), Color(0xFF6E1F12)],
    ),
  ];

  bool get isLastPage => currentPage.value == steps.length - 1;

  void onPageChanged(int index) => currentPage.value = index;

  void nextPage() {
    if (isLastPage) {
      getStarted();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void skip() => Get.offNamed(Routes.config);

  void getStarted() => Get.offNamed(Routes.config);

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
