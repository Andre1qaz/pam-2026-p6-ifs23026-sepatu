// lib/features/profile/profile_screen.dart

import 'package:flutter/material.dart';
import '../../core/theme/theme_notifier.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _ProfileAppBar(),
      body: _ProfileBody(),
    );
  }
}

class _ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ProfileAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeNotifier = ThemeProvider.of(context);
    return AppBar(
      backgroundColor: colorScheme.surface,
      title: Text('Profil',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: colorScheme.onSurface)),
      actions: [
        ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (_, mode, __) => IconButton(
            icon: Icon(
              mode == ThemeMode.dark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
            onPressed: themeNotifier.toggle,
          ),
        ),
      ],
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Foto Profil
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: Column(
              children: [
                // Foto profil
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.primary, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.25),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => CircleAvatar(
                        backgroundColor: colorScheme.primaryContainer,
                        child: Icon(Icons.person, size: 52, color: colorScheme.primary),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Andre Christian Saragih',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'ifs23026',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Institut Teknologi Del',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),

          // Stats Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _StatCard(label: 'Dibeli', value: '24', icon: Icons.shopping_bag),
                const SizedBox(width: 10),
                _StatCard(label: 'Favorit', value: '8', icon: Icons.favorite),
                const SizedBox(width: 10),
                _StatCard(label: 'Review', value: '12', icon: Icons.star),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Tentang Saya
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tentang Saya',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mahasiswa S1 Informatika di Institut Teknologi Del. '
                    'Passionate di bidang mobile development dan backend engineering. '
                    'Penggemar sneakers dengan koleksi lebih dari 20 pasang! 👟',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),

          // Menu aktivitas
          _MenuSection(
            title: 'Aktivitas',
            items: [
              _MenuItem(icon: Icons.receipt_long_outlined, label: 'Riwayat Pembelian', badge: '24'),
              _MenuItem(icon: Icons.favorite_outline, label: 'Sepatu Favorit', badge: '8'),
              _MenuItem(icon: Icons.local_shipping_outlined, label: 'Pesanan Aktif', badge: '2'),
              _MenuItem(icon: Icons.star_outline, label: 'Ulasan Saya', badge: '12'),
            ],
          ),

          // Menu pengaturan
          _MenuSection(
            title: 'Pengaturan',
            items: [
              _MenuItem(icon: Icons.person_outline, label: 'Edit Profil'),
              _MenuItem(icon: Icons.notifications_outlined, label: 'Notifikasi'),
              _MenuItem(icon: Icons.help_outline, label: 'Bantuan & FAQ'),
              _MenuItem(icon: Icons.info_outline, label: 'Tentang Aplikasi'),
            ],
          ),

          const SizedBox(height: 12),
          Text(
            'SoleStore v1.0.0 • IFS23026',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, required this.icon});
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Icon(icon, color: colorScheme.primary, size: 22),
              const SizedBox(height: 4),
              Text(value,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.primary,
                      )),
              Text(label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem({required this.icon, required this.label, this.badge});
  final IconData icon;
  final String label;
  final String? badge;
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({required this.title, required this.items});
  final String title;
  final List<_MenuItem> items;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurfaceVariant,
                    )),
          ),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: items.asMap().entries.map((entry) {
                final i = entry.key;
                final item = entry.value;
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item.icon, color: colorScheme.primary, size: 20),
                      ),
                      title: Text(item.label,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.badge != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(item.badge!,
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.w700,
                                      )),
                            ),
                          const SizedBox(width: 4),
                          Icon(Icons.chevron_right,
                              color: colorScheme.onSurfaceVariant, size: 18),
                        ],
                      ),
                      onTap: () {},
                    ),
                    if (i < items.length - 1)
                      Divider(
                        height: 1,
                        indent: 56,
                        endIndent: 16,
                        color: colorScheme.outline.withValues(alpha: 0.25),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
