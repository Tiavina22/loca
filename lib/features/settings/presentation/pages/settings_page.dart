import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const _SettingsHeader(),
        const Divider(),
        _buildSettingsSection('Compte', [
          _SettingsItem(
            icon: Icons.person_outline,
            title: 'Profil',
            onTap: () {},
          ),
          _SettingsItem(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {},
          ),
        ]),
        const Divider(),
        _buildSettingsSection('Application', [
          _SettingsItem(
            icon: Icons.language,
            title: 'Langue',
            trailing: 'Français',
            onTap: () {},
          ),
          _SettingsItem(
            icon: Icons.dark_mode_outlined,
            title: 'Thème',
            trailing: 'Clair',
            onTap: () {},
          ),
        ]),
        const Divider(),
        _buildSettingsSection('Autre', [
          _SettingsItem(
            icon: Icons.info_outline,
            title: 'À propos',
            onTap: () {},
          ),
          _SettingsItem(icon: Icons.help_outline, title: 'Aide', onTap: () {}),
        ]),
      ],
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ),
        ...items,
      ],
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.person, size: 30),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chef Nivo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'chef.nivo@example.com',
                  style: TextStyle(color: AppColors.textSecondaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondaryColor),
      title: Text(title),
      trailing:
          trailing != null
              ? Text(
                trailing!,
                style: const TextStyle(color: AppColors.textSecondaryColor),
              )
              : const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
