import 'package:get/get.dart';

import '../../features/auth/controllers/auth_controller.dart';
import '../../features/auth/views/auth_view.dart';
import '../../features/config/controllers/config_controller.dart';
import '../../features/config/views/config_view.dart';
import '../../features/detail/controllers/detail_controller.dart';
import '../../features/detail/views/detail_view.dart';
import '../../features/feed/controllers/feed_controller.dart';
import '../../features/foryou/controllers/foryou_controller.dart';
import '../../features/history/controllers/history_controller.dart';
import '../../features/home/controllers/home_controller.dart';
import '../../features/navigation/controllers/nav_controller.dart';
import '../../features/navigation/views/main_nav_view.dart';
import '../../features/onboarding/controllers/onboarding_controller.dart';
import '../../features/onboarding/views/onboarding_view.dart';
import '../../features/profile/controllers/profile_controller.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> pages = [
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.auth,
      page: () => const AuthView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController());
      }),
    ),
    GetPage(
      name: Routes.config,
      page: () => const ConfigView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ConfigController());
      }),
    ),
    GetPage(
      name: Routes.main,
      page: () => const MainNavView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => NavController());
        Get.lazyPut(() => HomeController());
        Get.lazyPut(() => FeedController());
        Get.lazyPut(() => ForYouController());
        Get.lazyPut(() => HistoryController());
        Get.lazyPut(() => ProfileController());
      }),
    ),
    GetPage(
      name: Routes.detail,
      page: () => const DetailView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DetailController());
      }),
    ),
  ];
}
