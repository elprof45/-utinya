import 'package:get/get.dart';
import '../../../app/data/models/comment_model.dart';
import '../../../app/data/models/content_model.dart';
import '../../../app/data/providers/mock_data_provider.dart';
import '../../../app/routes/app_routes.dart';

class FeedController extends GetxController {
  final RxList<ContentModel> items = MockDataProvider.feedItems.obs;
  final RxInt currentIndex = 0.obs;

  void onPageChanged(int index) => currentIndex.value = index;

  void toggleLike(int index) {
    final item = items[index];
    item.isLiked = !item.isLiked;
    item.likes += item.isLiked ? 1 : -1;
    items.refresh();
  }

  void toggleBookmark(int index) {
    items[index].isBookmarked = !items[index].isBookmarked;
    items.refresh();
  }

  void share(int index) {
    items[index].shares += 1;
    items.refresh();
    Get.snackbar('Shared', '"${items[index].title}" link copied to clipboard.');
  }

  List<CommentModel> commentsFor(int index) => MockDataProvider.commentsFor(items[index].id);

  void addComment(int index, String text) {
    if (text.trim().isEmpty) return;
    MockDataProvider.addComment(items[index].id, text.trim());
    items[index].commentsCount += 1;
    items.refresh();
  }

  void openDetail(int index) => Get.toNamed(Routes.detail, arguments: items[index]);
}
