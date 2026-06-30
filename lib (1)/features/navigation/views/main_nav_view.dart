import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../feed/views/feed_view.dart';
import '../../foryou/views/foryou_view.dart';
import '../../history/views/history_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/nav_controller.dart';

class MainNavView extends GetView<NavController> {
  const MainNavView({super.key});

  static const List<Widget> _pages = [
    HomeView(),
    FeedView(),
    ForYouView(),
    HistoryView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: _pages,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeIndex,
            selectedItemColor: AppColors.terracotta,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.dynamic_feed_rounded), label: 'Feed'),
              BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_rounded), label: 'For You'),
              BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'History'),
              BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
            ],
          )),
    );
  }
}
