import 'package:get/get.dart';
import 'package:egliloo/data/datasources/local/mock_data.dart';
import 'package:egliloo/data/models/content_model.dart';

class LibraryController extends GetxController {
  final bookmarks = <ContentModel>[].obs;
  final downloads = <ContentModel>[].obs;
  final history = <ContentModel>[].obs;
  final selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    bookmarks.value = MockData.contents.take(3).toList();
    downloads.value = MockData.contents.take(2).toList();
    history.value = MockData.contents;
  }

  void selectTab(int i) => selectedTab.value = i;
}
