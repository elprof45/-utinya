import 'package:get/get.dart';
import '../../../app/data/models/content_model.dart';
import '../../../app/data/providers/mock_data_provider.dart';
import '../../../app/routes/app_routes.dart';

class ForYouController extends GetxController {
  final RxList<ContentModel> recommendations =
      MockDataProvider.recommendedForYou.obs;
  final RxBool isRefreshing = false.obs;

  void toggleBookmark(ContentModel content) {
    content.isBookmarked = !content.isBookmarked;
    recommendations.refresh();
  }

  void toggleLike(ContentModel content) {
    content.isLiked = !content.isLiked;
    content.likes += content.isLiked ? 1 : -1;
    recommendations.refresh();
  }

  @override
  Future<void> refresh() async {
    isRefreshing.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    recommendations.value = MockDataProvider.recommendedForYou;
    isRefreshing.value = false;
  }

  void openDetail(ContentModel content) =>
      Get.toNamed(Routes.detail, arguments: content);
}
