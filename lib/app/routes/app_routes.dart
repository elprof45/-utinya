// lib/app/routes/app_routes.dart

part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const languageSelection = '/language-selection';
  static const interestSelection = '/interest-selection';
  static const auth = '/auth';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const otp = '/auth/otp';
  static const main = '/main';
  static const home = '/main/home';
  static const explore = '/main/explore';
  static const feed = '/main/feed';
  static const library = '/main/library';
  static const profile = '/main/profile';
  static const detail = '/detail';
  static const search = '/search';
  static const audioPlayer = '/player/audio';
  static const videoPlayer = '/player/video';
  static const reader = '/reader';
  static const africaMap = '/africa-map';
  static const quiz = '/quiz';
  static const community = '/community';
  static const notifications = '/notifications';
  static const settings = '/settings';
}
