// lib/app/bindings/main_binding.dart
import 'package:egliloo/features/explore/controllers/explore_controller.dart';
import 'package:egliloo/features/feed/controllers/feed_controller.dart';
import 'package:egliloo/features/home/controllers/home_controller.dart';
import 'package:egliloo/features/home/views/main_view.dart';
import 'package:egliloo/features/library/controllers/library_controller.dart';
import 'package:egliloo/features/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<ExploreController>(() => ExploreController(), fenix: true);
    Get.lazyPut<FeedController>(() => FeedController(), fenix: true);
    Get.lazyPut<LibraryController>(() => LibraryController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }
}
