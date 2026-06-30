import 'package:get/get.dart';
import 'package:egliloo/data/datasources/local/mock_data.dart';
import 'package:egliloo/data/models/content_model.dart';

class FeedController extends GetxController {
  final feedItems = <ContentModel>[].obs;
  final isLoading = true.obs;
  final likedIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    feedItems.value = [...MockData.contents, ...MockData.contents.reversed];
    isLoading.value = false;
  }

  void toggleLike(String id) {
    if (likedIds.contains(id)) {
      likedIds.remove(id);
    } else {
      likedIds.add(id);
    }
  }

  bool isLiked(String id) => likedIds.contains(id);
}
