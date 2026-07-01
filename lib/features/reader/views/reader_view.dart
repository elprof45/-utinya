// lib/features/reader/views/reader_view.dart

import 'package:egliloo/features/reader/controllers/reader_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class ReaderView extends GetView<ReaderController> {
  const ReaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDark = controller.isDarkMode.value;
      final bg = isDark ? AppColors.backgroundDark : const Color(0xFFF5EFE6);
      final textColor = isDark
          ? AppColors.textPrimaryDark
          : AppColors.textPrimaryLight;

      return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: bg,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: textColor),
            onPressed: Get.back,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings_rounded, color: textColor),
              onPressed: controller.toggleSettingsPanel,
            ),
            IconButton(
              icon: Icon(Icons.bookmark_border_rounded, color: textColor),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.share_outlined, color: textColor),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                // Progress bar
                Obx(
                  () => LinearProgressIndicator(
                    value: controller.readingProgress.value,
                    backgroundColor: isDark
                        ? AppColors.dividerDark
                        : AppColors.dividerLight,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                    minHeight: 2,
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    final content = controller.content.value;
                    final md =
                        content?.content ?? '_Aucun contenu disponible._';

                    return Markdown(
                      controller: controller.scrollController,
                      data: md,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.xxl,
                        vertical: AppSpacing.xl,
                      ),
                      styleSheet: _buildMarkdownStyle(
                        isDark: isDark,
                        fontSize: controller.fontSize.value,
                        fontFamily: controller.fontFamily.value,
                      ),
                    );
                  }),
                ),
              ],
            ),
            // Settings panel
            Obx(
              () => controller.showSettingsPanel.value
                  ? Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: _ReaderSettingsPanel(isDark: isDark),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      );
    });
  }

  MarkdownStyleSheet _buildMarkdownStyle({
    required bool isDark,
    required double fontSize,
    required String fontFamily,
  }) {
    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final secondaryColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final codeColor = isDark ? AppColors.surfaceDark2 : const Color(0xFFEDE7DC);

    return MarkdownStyleSheet(
      p: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize.sp,
        color: textColor,
        height: 1.8,
        letterSpacing: 0.3,
      ),
      h1: GoogleFonts.playfairDisplay(
        fontSize: (fontSize + 14).sp,
        fontWeight: FontWeight.w700,
        color: textColor,
        height: 1.3,
      ),
      h2: GoogleFonts.playfairDisplay(
        fontSize: (fontSize + 8).sp,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.4,
      ),
      h3: GoogleFonts.playfairDisplay(
        fontSize: (fontSize + 4).sp,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.5,
      ),
      blockquote: TextStyle(
        fontFamily: 'Georgia',
        fontSize: (fontSize + 2).sp,
        fontStyle: FontStyle.italic,
        color: AppColors.primary,
        height: 1.8,
      ),
      blockquoteDecoration: BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.primary, width: 3)),
        color: AppColors.primarySurface,
      ),
      blockquotePadding: EdgeInsets.symmetric(horizontal: AppSpacing.base),
      strong: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize.sp,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),
      em: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize.sp,
        fontStyle: FontStyle.italic,
        color: secondaryColor,
      ),
      code: TextStyle(
        fontFamily: 'Courier New',
        fontSize: (fontSize - 1).sp,
        color: AppColors.primary,
        backgroundColor: codeColor,
      ),
      codeblockDecoration: BoxDecoration(
        color: codeColor,
        borderRadius: AppRadius.mdAll,
      ),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
        ),
      ),
      a: const TextStyle(
        color: AppColors.primary,
        decoration: TextDecoration.underline,
      ),
    );
  }
}

class _ReaderSettingsPanel extends StatelessWidget {
  final bool isDark;

  const _ReaderSettingsPanel({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ReaderController>();
    final bg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;

    return Container(
      padding: EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(color: bg, boxShadow: AppElevation.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Font size
          Row(
            children: [
              Text(
                'Taille du texte',
                style: AppTypography.titleSmall.copyWith(color: textColor),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.remove_rounded, color: textColor),
                onPressed: c.decreaseFontSize,
              ),
              Obx(
                () => Text(
                  '${c.fontSize.value.toInt()}',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_rounded, color: textColor),
                onPressed: c.increaseFontSize,
              ),
            ],
          ),
          Divider(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
          // Theme toggle
          Row(
            children: [
              Text(
                'Mode sombre',
                style: AppTypography.titleSmall.copyWith(color: textColor),
              ),
              const Spacer(),
              Obx(
                () => Switch(
                  value: c.isDarkMode.value,
                  onChanged: (_) => c.toggleDarkMode(),
                  activeThumbColor: AppColors.primary,
                ),
              ),
            ],
          ),
          Divider(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
          // Font family
          Text(
            'Police',
            style: AppTypography.titleSmall.copyWith(color: textColor),
          ),
          SizedBox(height: AppSpacing.sm),
          Obx(
            () => Wrap(
              spacing: AppSpacing.sm,
              children: c.fontFamilies
                  .map(
                    (f) => ChoiceChip(
                      label: Text(
                        f,
                        style: AppTypography.caption.copyWith(color: textColor),
                      ),
                      selected: c.fontFamily.value == f,
                      selectedColor: AppColors.primarySurface,
                      onSelected: (_) => c.setFontFamily(f),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
