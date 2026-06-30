// lib/features/home/views/home_view.dart
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/features/home/widgets/_build_content.dart';
import 'package:egliloo/features/home/widgets/_build_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:egliloo/features/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Obx(() {
        if (controller.isLoading.value) {
          return BuildShimmer();
        }
        return BuildContent();
      }),
    );
  }
}
