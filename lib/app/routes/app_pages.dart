// lib/app/routes/app_pages.dart

import 'package:egliloo/app/bindings/auth_binding.dart';
import 'package:get/get.dart';

import 'package:egliloo/features/auth/views/auth_view.dart';
import 'package:egliloo/features/auth/views/login_view.dart';
import 'package:egliloo/features/auth/views/register_view.dart';
import 'package:egliloo/features/auth/views/otp_view.dart';
import 'package:egliloo/features/community/controllers/community_controller.dart';
import 'package:egliloo/features/community/views/community_view.dart';
import 'package:egliloo/app/bindings/detail_binding.dart';
import 'package:egliloo/features/detail/views/detail_view.dart';
import 'package:egliloo/app/bindings/explore_binding.dart';
import 'package:egliloo/features/explore/views/explore_view.dart';
import 'package:egliloo/app/bindings/feed_binding.dart';
import 'package:egliloo/features/feed/views/feed_view.dart';
import 'package:egliloo/app/bindings/home_binding.dart';
import 'package:egliloo/features/home/views/home_view.dart';
import 'package:egliloo/app/bindings/library_binding.dart';
import 'package:egliloo/features/library/views/library_view.dart';
import 'package:egliloo/features/map/controllers/map_controller.dart';
import 'package:egliloo/features/map/views/africa_map_view.dart';
import 'package:egliloo/features/notifications/controllers/notification_controller.dart';
import 'package:egliloo/features/notifications/views/notifications_view.dart';
import 'package:egliloo/features/onboarding/controllers/onboarding_controller.dart';
import 'package:egliloo/features/onboarding/views/interest_selection_view.dart';
import 'package:egliloo/features/onboarding/views/language_selection_view.dart';
import 'package:egliloo/features/onboarding/views/onboarding_view.dart';
import 'package:egliloo/features/player/audio/views/audio_player_view.dart';
import 'package:egliloo/features/player/video/views/video_player_view.dart';
import 'package:egliloo/app/bindings/profile_binding.dart';
import 'package:egliloo/features/profile/views/profile_view.dart';
import 'package:egliloo/features/quiz/controllers/quiz_controller.dart';
import 'package:egliloo/features/quiz/views/quiz_view.dart';
import 'package:egliloo/features/reader/controllers/reader_controller.dart';
import 'package:egliloo/features/reader/views/reader_view.dart';
import 'package:egliloo/app/bindings/search_binding.dart';
import 'package:egliloo/features/search/views/search_view.dart';
import 'package:egliloo/app/bindings/settings_binding.dart';
import 'package:egliloo/features/settings/views/settings_view.dart';
import 'package:egliloo/features/splash/controllers/splash_controller.dart';
import 'package:egliloo/features/splash/views/splash_view.dart';
import 'package:egliloo/app/bindings/main_binding.dart';
import 'package:egliloo/features/home/views/main_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    // ─── SPLASH ─────────────────────────────────────────────────────────────
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
      transition: Transition.fadeIn,
    ),

    // ─── ONBOARDING ─────────────────────────────────────────────────────────
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
      binding: BindingsBuilder(
        () => Get.lazyPut<OnboardingController>(() => OnboardingController()),
      ),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.languageSelection,
      page: () => const LanguageSelectionView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.interestSelection,
      page: () => const InterestSelectionView(),
      transition: Transition.rightToLeft,
    ),

    // ─── AUTH ────────────────────────────────────────────────────────────────
    GetPage(
      name: Routes.auth,
      page: () => const AuthView(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.otp,
      page: () => const OtpView(),
      transition: Transition.rightToLeft,
    ),

    // ─── MAIN (with bottom nav) ───────────────────────────────────────────
    GetPage(
      name: Routes.main,
      page: () => const MainView(),
      binding: MainBinding(),
      transition: Transition.fadeIn,
      children: [
        GetPage(
          name: Routes.home,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: Routes.explore,
          page: () => const ExploreView(),
          binding: ExploreBinding(),
        ),
        GetPage(
          name: Routes.feed,
          page: () => const FeedView(),
          binding: FeedBinding(),
        ),
        GetPage(
          name: Routes.library,
          page: () => const LibraryView(),
          binding: LibraryBinding(),
        ),
        GetPage(
          name: Routes.profile,
          page: () => const ProfileView(),
          binding: ProfileBinding(),
        ),
      ],
    ),

    // ─── DETAIL ──────────────────────────────────────────────────────────────
    GetPage(
      name: Routes.detail,
      page: () => const DetailView(),
      binding: DetailBinding(),
      transition: Transition.cupertino,
    ),

    // ─── SEARCH ──────────────────────────────────────────────────────────────
    GetPage(
      name: Routes.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
      transition: Transition.downToUp,
    ),

    // ─── PLAYERS ─────────────────────────────────────────────────────────────
    GetPage(
      name: Routes.audioPlayer,
      page: () => const AudioPlayerView(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.videoPlayer,
      page: () => const VideoPlayerView(),
      transition: Transition.fadeIn,
    ),

    // ─── READER ──────────────────────────────────────────────────────────────
    GetPage(
      name: Routes.reader,
      page: () => const ReaderView(),
      binding: BindingsBuilder(() {
        Get.put(ReaderController());
      }),
      transition: Transition.cupertino,
    ),

    // ─── MAP ─────────────────────────────────────────────────────────────────
    GetPage(
      name: Routes.africaMap,
      page: () => const AfricaMapView(),
      binding: BindingsBuilder(() {
        Get.put(MapController());
      }),
      transition: Transition.fadeIn,
    ),

    // ─── QUIZ ────────────────────────────────────────────────────────────────
    GetPage(
      name: Routes.quiz,
      page: () => const QuizView(),
      binding: BindingsBuilder(() {
        Get.put(QuizController());
      }),
      transition: Transition.rightToLeft,
    ),

    // ─── COMMUNITY ───────────────────────────────────────────────────────────
    GetPage(
      name: Routes.community,
      page: () => const CommunityView(),
      binding: BindingsBuilder(() {
        Get.put(CommunityController());
      }),
      transition: Transition.rightToLeft,
    ),

    // ─── NOTIFICATIONS ───────────────────────────────────────────────────────
    GetPage(
      name: Routes.notifications,
      page: () => const NotificationsView(),
      binding: BindingsBuilder(() {
        Get.put(NotificationController());
      }),
      transition: Transition.rightToLeft,
    ),

    // ─── SETTINGS ────────────────────────────────────────────────────────────
    GetPage(
      name: Routes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
