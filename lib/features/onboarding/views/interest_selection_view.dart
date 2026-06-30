// lib/features/onboarding/views/interest_selection_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/routes/app_pages.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class InterestSelectionView extends StatefulWidget {
  const InterestSelectionView({super.key});

  @override
  State<InterestSelectionView> createState() => _InterestSelectionViewState();
}

class _InterestSelectionViewState extends State<InterestSelectionView> {
  final Set<String> selected = {};

  final interests = [
    {'id': 'tales', 'label': 'Contes & Légendes', 'emoji': '🌙'},
    {'id': 'history', 'label': 'Histoire', 'emoji': '📜'},
    {'id': 'mythology', 'label': 'Mythologies', 'emoji': '⚡'},
    {'id': 'cuisine', 'label': 'Cuisine', 'emoji': '🍲'},
    {'id': 'music', 'label': 'Musique', 'emoji': '🥁'},
    {'id': 'travel', 'label': 'Voyage', 'emoji': '✈️'},
    {'id': 'traditions', 'label': 'Traditions', 'emoji': '🎭'},
    {'id': 'religion', 'label': 'Religions', 'emoji': '🕌'},
    {'id': 'children', 'label': 'Enfants', 'emoji': '👶'},
    {'id': 'science', 'label': 'Sciences', 'emoji': '🔬'},
    {'id': 'biography', 'label': 'Biographies', 'emoji': '👑'},
    {'id': 'poetry', 'label': 'Poésie', 'emoji': '✍️'},
    {'id': 'podcast', 'label': 'Podcasts', 'emoji': '🎙️'},
    {'id': 'west', 'label': 'Afrique de l\'Ouest', 'emoji': '🌍'},
    {'id': 'central', 'label': 'Afrique Centrale', 'emoji': '🌿'},
    {'id': 'south', 'label': 'Afrique Australe', 'emoji': '🦁'},
    {'id': 'east', 'label': 'Afrique de l\'Est', 'emoji': '🏔️'},
    {'id': 'north', 'label': 'Afrique du Nord', 'emoji': '🐪'},
    {'id': 'diaspora', 'label': 'Diaspora', 'emoji': '🌐'},
    {'id': 'arts', 'label': 'Arts & Artisanat', 'emoji': '🎨'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.xxl),
              Text('✨', style: TextStyle(fontSize: 40.sp)),
              SizedBox(height: AppSpacing.base),
              Text(
                'Vos centres d\'intérêt',
                style: AppTypography.headlineMedium.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Sélectionnez au moins 3 thèmes pour personnaliser votre expérience.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
              SizedBox(height: AppSpacing.xl),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: interests
                        .map(
                          (i) => _InterestChip(
                            emoji: i['emoji']!,
                            label: i['label']!,
                            isSelected: selected.contains(i['id']),
                            onTap: () => setState(() {
                              if (selected.contains(i['id'])) {
                                selected.remove(i['id']);
                              } else {
                                selected.add(i['id']!);
                              }
                            }),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.base),
              ElevatedButton(
                onPressed: selected.length >= 3
                    ? () => Get.offAllNamed(Routes.auth)
                    : null,
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: AppColors.surfaceDark2,
                  disabledForegroundColor: AppColors.textTertiaryDark,
                ),
                child: Text(
                  selected.length >= 3
                      ? 'Continuer (${selected.length} sélectionnés)'
                      : 'Choisir au moins 3',
                ),
              ),
              SizedBox(height: AppSpacing.base),
            ],
          ),
        ),
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _InterestChip({
    required this.emoji,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySurface : AppColors.surfaceDark,
          borderRadius: AppRadius.fullAll,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderDark,
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: TextStyle(fontSize: 16.sp)),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.textSecondaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
