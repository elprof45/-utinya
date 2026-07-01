import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../lib/app/theme/theme/app_colors.dart';
import '../../../app/widgets/avatar_placeholder.dart';
import '../../../app/widgets/tribal_divider.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: Obx(() {
        final user = controller.user.value;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 32),
          children: [
            Row(
              children: [
                AvatarPlaceholder(
                  colorIndex: user.avatarColorIndex,
                  size: 64,
                  initials: _initials(user.name),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Member since ${user.joinDate}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Get.snackbar(
                    'Edit profile',
                    'Profile editing is coming soon.',
                  ),
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TribalDivider(margin: const EdgeInsets.symmetric(vertical: 2)),
            const SizedBox(height: 10),
            Text(
              'Your Afrolore journey',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.7,
              children: [
                _StatCard(
                  icon: Icons.headphones_rounded,
                  label: 'Hours Listened',
                  value: user.hoursListened.toStringAsFixed(1),
                  colorIndex: 0,
                ),
                _StatCard(
                  icon: Icons.menu_book_rounded,
                  label: 'Stories Read',
                  value: '${user.storiesRead}',
                  colorIndex: 1,
                ),
                _StatCard(
                  icon: Icons.bookmark_rounded,
                  label: 'Proverbs Saved',
                  value: '${user.proverbsSaved}',
                  colorIndex: 2,
                ),
                _StatCard(
                  icon: Icons.play_circle_fill_rounded,
                  label: 'Videos Watched',
                  value: '${user.videosWatched}',
                  colorIndex: 3,
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              'Your interests',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: user.interests
                  .map(
                    (i) => Chip(
                      label: Text(i, style: const TextStyle(fontSize: 12.5)),
                      backgroundColor: AppColors.sand,
                      side: BorderSide(
                        color: AppColors.ochre.withValues(alpha: 0.3),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 22),
            TribalDivider(
              color: AppColors.emerald,
              margin: const EdgeInsets.symmetric(vertical: 2),
            ),
            const SizedBox(height: 10),
            Text('Preferences', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            _SwitchTile(
              icon: Icons.download_for_offline_rounded,
              title: 'Offline Downloads',
              subtitle: 'Save tales and audio for offline access',
              value: controller.offlineDownloads.value,
              onChanged: controller.toggleOffline,
            ),
            _SwitchTile(
              icon: Icons.dark_mode_rounded,
              title: 'Dark Theme',
              subtitle: 'Switch to the espresso night theme',
              value: controller.isDarkMode.value,
              onChanged: controller.toggleDarkMode,
            ),
            _SwitchTile(
              icon: Icons.notifications_active_rounded,
              title: 'Notifications',
              subtitle: 'New chronicles, replies and weekly proverbs',
              value: controller.notificationsEnabled.value,
              onChanged: controller.toggleNotifications,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.translate_rounded,
                color: AppColors.terracotta,
              ),
              title: const Text(
                'Language',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('Content language: ${user.language}'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => _openLanguagePicker(context),
            ),
            const SizedBox(height: 18),
            OutlinedButton(
              onPressed: controller.logout,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: AppColors.terracotta),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout_rounded,
                    color: AppColors.terracotta,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Log Out',
                    style: TextStyle(
                      color: AppColors.terracotta,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  void _openLanguagePicker(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Content language',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ...controller.languages.map(
              (lang) => Obx(
                () => RadioListTile<String>(
                  value: lang,
                  groupValue: controller.user.value.language,
                  activeColor: AppColors.terracotta,
                  contentPadding: EdgeInsets.zero,
                  title: Text(lang),
                  onChanged: (value) {
                    if (value != null) controller.changeLanguage(value);
                    Get.back();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final int colorIndex;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.colorIndex,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.avatarFor(colorIndex);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: Icon(icon, color: AppColors.terracotta),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.terracotta,
    );
  }
}
