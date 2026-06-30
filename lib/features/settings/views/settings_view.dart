import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';
import 'package:egliloo/features/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Paramètres',
          style: AppTypography.titleLarge.copyWith(
            color: AppColors.textPrimaryDark,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.base),
        children: [
          _Section(
            title: 'Apparence',
            children: [
              Obx(
                () => _Toggle(
                  icon: Icons.dark_mode_rounded,
                  label: 'Mode sombre',
                  value: controller.isDarkMode.value,
                  onChanged: (_) => controller.toggleDarkMode(),
                ),
              ),
              _Item(
                icon: Icons.text_fields_rounded,
                label: 'Taille du texte',
                trailing: '16',
              ),
              _Item(
                icon: Icons.font_download_outlined,
                label: 'Police de caractères',
                trailing: 'DM Sans',
              ),
            ],
          ),
          SizedBox(height: AppSpacing.base),
          _Section(
            title: 'Notifications',
            children: [
              Obx(
                () => _Toggle(
                  icon: Icons.notifications_outlined,
                  label: 'Notifications',
                  value: controller.notificationsEnabled.value,
                  onChanged: (_) => controller.toggleNotifications(),
                ),
              ),
              Obx(
                () => _Toggle(
                  icon: Icons.wb_sunny_outlined,
                  label: 'Proverbe du jour',
                  value: controller.dailyProverbEnabled.value,
                  onChanged: (_) => controller.toggleDailyProverb(),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.base),
          _Section(
            title: 'Téléchargements',
            children: [
              Obx(
                () => _Toggle(
                  icon: Icons.wifi_rounded,
                  label: 'Wi-Fi uniquement',
                  value: controller.downloadWifiOnly.value,
                  onChanged: (_) => controller.toggleWifi(),
                ),
              ),
              Obx(
                () => _Item(
                  icon: Icons.audiotrack_rounded,
                  label: 'Qualité audio',
                  trailing: controller.audioQuality.value,
                ),
              ),
              Obx(
                () => _Item(
                  icon: Icons.hd_rounded,
                  label: 'Qualité vidéo',
                  trailing: controller.videoQuality.value,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.base),
          _Section(
            title: 'Lecture',
            children: [
              Obx(
                () => _Item(
                  icon: Icons.speed_rounded,
                  label: 'Vitesse par défaut',
                  trailing: '${controller.playbackSpeed.value}x',
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.base),
          _Section(
            title: 'À propos',
            children: [
              _Item(
                icon: Icons.info_outline_rounded,
                label: 'Version',
                trailing: '1.0.0',
              ),
              _Item(icon: Icons.privacy_tip_outlined, label: 'Confidentialité'),
              _Item(
                icon: Icons.gavel_rounded,
                label: 'Conditions d\'utilisation',
              ),
              _Item(icon: Icons.support_agent_rounded, label: 'Support'),
            ],
          ),
          SizedBox(height: AppSpacing.xl),
          OutlinedButton.icon(
            icon: const Icon(Icons.logout_rounded, color: AppColors.error),
            label: Text(
              'Se déconnecter',
              style: AppTypography.labelLarge.copyWith(color: AppColors.error),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.error),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: AppTypography.overline.copyWith(
          color: AppColors.textTertiaryDark,
        ),
      ),
      SizedBox(height: AppSpacing.sm),
      Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: AppColors.borderDark, width: 0.5),
        ),
        child: Column(
          children: children
              .map(
                (c) => Column(
                  children: [
                    c,
                    if (c != children.last)
                      Divider(color: AppColors.dividerDark, height: 1),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? trailing;
  const _Item({required this.icon, required this.label, this.trailing});
  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: AppColors.textSecondaryDark, size: 20),
    title: Text(
      label,
      style: AppTypography.bodyMedium.copyWith(
        color: AppColors.textPrimaryDark,
      ),
    ),
    trailing: trailing != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                trailing!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textTertiaryDark,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textTertiaryDark,
                size: 16,
              ),
            ],
          )
        : const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textTertiaryDark,
            size: 16,
          ),
  );
}

class _Toggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _Toggle({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: AppColors.textSecondaryDark, size: 20),
    title: Text(
      label,
      style: AppTypography.bodyMedium.copyWith(
        color: AppColors.textPrimaryDark,
      ),
    ),
    trailing: Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.primary,
    ),
  );
}
