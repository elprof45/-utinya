import 'package:get/get.dart';
import 'package:egliloo/features/search/controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppSearchController>(() => AppSearchController(), fenix: true);
  }
}
