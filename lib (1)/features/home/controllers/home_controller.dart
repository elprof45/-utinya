import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/models/content_model.dart';
import '../../../app/data/models/user_model.dart';
import '../../../app/data/providers/mock_data_provider.dart';
import '../../../app/routes/app_routes.dart';
import '../../navigation/controllers/nav_controller.dart';

class HomeController extends GetxController {
  final PageController bannerController = PageController(viewportFraction: 0.88);
  final RxInt currentBanner = 0.obs;

  final Rx<UserModel> user = UserModel(
    name: 'Amara Diallo',
    avatarColorIndex: 1,
    isAuthenticated: true,
  ).obs;

  final RxList<ContentModel> featured = MockDataProvider.featured.obs;
  final RxList<ContentModel> audioTales = MockDataProvider.byType(ContentType.audio).obs;
  final RxList<ContentModel> richHistory = MockDataProvider.richHistory.obs;
  final RxList<ContentModel> videos = MockDataProvider.byType(ContentType.video).obs;

  final TextEditingController searchController = TextEditingController();
  final RxList<ContentModel> searchResults = <ContentModel>[].obs;

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  void onBannerScroll(int index) => currentBanner.value = index;

  void search(String query) {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }
    final q = query.toLowerCase();
    searchResults.value = MockDataProvider.allContent
        .where((c) => c.title.toLowerCase().contains(q) || c.category.toLowerCase().contains(q))
        .toList();
  }

  void clearSearch() {
    searchController.clear();
    searchResults.clear();
  }

  void openDetail(ContentModel content) => Get.toNamed(Routes.detail, arguments: content);

  void goToTab(int index) {
    if (Get.isRegistered<NavController>()) {
      Get.find<NavController>().changeIndex(index);
    }
  }

  @override
  void onClose() {
    bannerController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
