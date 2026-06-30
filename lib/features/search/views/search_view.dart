// lib/features/search/views/search_view.dart

import 'package:egliloo/features/search/controllers/search_controller.dart';
import 'package:egliloo/features/search/widgets/search_app_bar.dart';
import 'package:egliloo/features/search/widgets/search_default_content.dart';
import 'package:egliloo/features/search/widgets/search_filters.dart';
import 'package:egliloo/features/search/widgets/search_results_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';

class SearchView extends GetView<AppSearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            const SearchAppBar(),
            const SearchFilters(),
            SizedBox(height: AppSpacing.base),
            Expanded(
              child: Obx(() {
                final query = controller.query.value.trim();

                if (query.isEmpty) {
                  return const SearchDefaultContent();
                }

                if (controller.isSearching.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (controller.results.isEmpty) {
                  return const SearchEmptyState();
                }

                return const SearchResultsList();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
