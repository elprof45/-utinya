import 'package:get/get.dart';
import 'package:egliloo/features/feed/controllers/feed_controller.dart';

class FeedBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<FeedController>(() => FeedController());
}
