import 'package:get/get.dart';
import 'package:egliloo/features/explore/controllers/explore_controller.dart';

class ExploreBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<ExploreController>(() => ExploreController(), fenix: true);
}
