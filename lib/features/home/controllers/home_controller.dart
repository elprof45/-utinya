// lib/features/home/controllers/home_controller.dart

import 'package:get/get.dart';
import 'package:egliloo/data/datasources/local/mock_data.dart';
import 'package:egliloo/data/models/content_model.dart';
import 'package:egliloo/data/models/author_model.dart';

class HomeController extends GetxController {
  final isLoading = true.obs;
  final featuredContent = <ContentModel>[].obs;
  final trendingContent = <ContentModel>[].obs;
  final newContent = <ContentModel>[].obs;
  final audioBooks = <ContentModel>[].obs;
  final podcasts = <ContentModel>[].obs;
  final tales = <ContentModel>[].obs;
  final popularAuthors = <AuthorModel>[].obs;
  final continueReading = <ContentModel>[].obs;
  final todayProverb = <String, String>{}.obs;
  final video = <ContentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    // Simule un appel API
    await Future.delayed(const Duration(milliseconds: 800));

    featuredContent.value = MockData.getFeatured();
    trendingContent.value = MockData.getTrending();
    newContent.value = MockData.contents
        .where(
          (c) =>
              c.isNew ||
              c.publishedAt.isAfter(
                DateTime.now().subtract(const Duration(days: 30)),
              ),
        )
        .take(6)
        .toList();
    audioBooks.value = MockData.getByType(ContentType.audiobook);
    podcasts.value = MockData.getByType(ContentType.podcast);
    tales.value = MockData.getByType(ContentType.tale);
    popularAuthors.value = MockData.authors;
    continueReading.value = MockData.contents.take(3).toList();
    todayProverb.value = MockData.getTodayProverbFull();

    isLoading.value = false;
  }

  @override
  Future<void> refresh() => loadData();
}
