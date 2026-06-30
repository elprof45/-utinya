// lib/features/detail/controllers/detail_controller.dart

import 'package:egliloo/data/models/category_model.dart' show CommentModel;
import 'package:egliloo/data/models/content_model.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final content = Rxn<ContentModel>();
  final isLiked = false.obs;
  final isBookmarked = false.obs;
  final isFollowingAuthor = false.obs;
  final comments = <CommentModel>[].obs;
  final isLoadingComments = false.obs;
  final selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is ContentModel) {
      content.value = arg;
      _loadComments();
    }
  }

  void toggleLike() => isLiked.toggle();
  void toggleBookmark() => isBookmarked.toggle();
  void toggleFollowAuthor() => isFollowingAuthor.toggle();
  void selectTab(int i) => selectedTab.value = i;

  Future<void> _loadComments() async {
    isLoadingComments.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    comments.value = [
      CommentModel(
        id: 'c1',
        contentId: content.value?.id ?? '',
        userId: 'u1',
        userName: 'Kofi A.',
        userAvatar: 'https://i.pravatar.cc/150?img=3',
        text:
            'Cette histoire m\'a profondément touché. La sagesse d\'Anansi nous rappelle que l\'intelligence vaut mieux que la force brute. 🙏',
        likesCount: 47,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      CommentModel(
        id: 'c2',
        contentId: content.value?.id ?? '',
        userId: 'u2',
        userName: 'Adaeze M.',
        userAvatar: 'https://i.pravatar.cc/150?img=5',
        text:
            'Mon grand-père me racontait cette même histoire quand j\'étais petite. Merci AfriBook de préserver ces trésors !',
        likesCount: 89,
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      CommentModel(
        id: 'c3',
        contentId: content.value?.id ?? '',
        userId: 'u3',
        userName: 'Ibrahima D.',
        userAvatar: 'https://i.pravatar.cc/150?img=7',
        text:
            'J\'ai lu ça avec mes enfants hier soir. Ils ont adoré ! On a même fait le quiz ensemble.',
        likesCount: 32,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
    isLoadingComments.value = false;
  }
}
