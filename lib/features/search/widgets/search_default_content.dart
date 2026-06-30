// lib/features/search/widgets/search_default_content.dart
import 'package:egliloo/features/search/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class SearchDefaultContent extends GetView<AppSearchController> {
  const SearchDefaultContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Regroupement global de l'écoute réactive sous un seul Obx propre
      final historyList = controller.history;
      final suggestionList = controller.suggestions;

      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.sm,
        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          // Section Historique (affichée uniquement s'il n'est pas vide)
          if (historyList.isNotEmpty) ...[
            Row(
              children: [
                Text(
                  'Recherches récentes',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => controller.history.clear(),
                  child: Text(
                    'Effacer',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            // Utilisation directe des éléments dans la ListView racine (évite l'imbrication d'une Column)
            ...historyList.map(
              (historyItem) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.history_rounded,
                  color: AppColors.textTertiaryDark,
                ),
                title: Text(
                  historyItem,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimaryDark,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.textTertiaryDark,
                    size: 16,
                  ),
                  onPressed: () => controller.removeHistory(historyItem),
                ),
                onTap: () => controller.selectSuggestion(historyItem),
              ),
            ),
            SizedBox(height: AppSpacing.lg),
          ],

          // Section Tendances
          Text(
            'Tendances',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textPrimaryDark,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: suggestionList
                .map(
                  (suggestion) => GestureDetector(
                    onTap: () => controller.selectSuggestion(suggestion),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.base,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceDark,
                        borderRadius: AppRadius.fullAll,
                        border: Border.all(
                          color: AppColors.borderDark,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.trending_up_rounded,
                            color: AppColors.primary,
                            size: 14,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            suggestion,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: AppSpacing.xl,
          ), // Marge de sécurité basse pour le scroll
        ],
      );
    });
  }
}
