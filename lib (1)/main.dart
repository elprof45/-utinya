import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import '../lib/app/theme/theme/app_theme.dart';

void main() {
  runApp(const AfroloreApp());
}

class AfroloreApp extends StatelessWidget {
  const AfroloreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Afrolore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      initialRoute: Routes.onboarding,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
