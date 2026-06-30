import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.backgroundDark,
    appBar: AppBar(
      backgroundColor: AppColors.backgroundDark,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: AppColors.textPrimaryDark,
        ),
        onPressed: Get.back,
      ),
      title: Text(
        'Communauté',
        style: AppTypography.titleLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
      ),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('💬', style: const TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          Text(
            'Communauté AfriBook',
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.textPrimaryDark,
            ),
          ),
          Text(
            'Bientôt disponible',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiaryDark,
            ),
          ),
        ],
      ),
    ),
  );
}
