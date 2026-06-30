// lib/features/reader/controllers/reader_controller.dart

import 'package:egliloo/data/models/content_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReaderController extends GetxController {
  final content = Rxn<ContentModel>();
  final fontSize = 16.0.obs;
  final isDarkMode = true.obs;
  final fontFamily = 'DM Sans'.obs;
  final scrollController = ScrollController();
  final readingProgress = 0.0.obs;
  final showSettingsPanel = false.obs;

  final fontFamilies = [
    'DM Sans',
    'Georgia',
    'Playfair Display',
    'Courier New',
  ];

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is ContentModel) content.value = arg;

    scrollController.addListener(() {
      final max = scrollController.position.maxScrollExtent;
      if (max > 0) {
        readingProgress.value = scrollController.offset / max;
      }
    });
  }

  void increaseFontSize() {
    if (fontSize.value < 24) fontSize.value += 1;
  }

  void decreaseFontSize() {
    if (fontSize.value > 12) fontSize.value -= 1;
  }

  void toggleDarkMode() => isDarkMode.toggle();
  void setFontFamily(String f) => fontFamily.value = f;
  void toggleSettingsPanel() => showSettingsPanel.toggle();

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
