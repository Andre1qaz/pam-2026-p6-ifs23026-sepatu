// test/screens/profile_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/core/theme/app_theme.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/core/theme/theme_notifier.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/features/profile/profile_screen.dart';

Widget buildProfileTest() {
  final notifier = ThemeNotifier(initial: ThemeMode.light);
  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (_, __) => const ProfileScreen()),
  ]);

  return ThemeProvider(
    notifier: notifier,
    child: MaterialApp.router(
      theme: AppTheme.lightTheme,
      routerConfig: router,
    ),
  );
}

void main() {
  group('ProfileScreen', () {
    testWidgets('merender tanpa error', (tester) async {
      await tester.pumpWidget(buildProfileTest());
      await tester.pumpAndSettle();

      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('menampilkan judul "Profil" di AppBar', (tester) async {
      await tester.pumpWidget(buildProfileTest());
      await tester.pumpAndSettle();

      expect(find.text('Profil'), findsOneWidget);
    });

    testWidgets('menampilkan foto profil', (tester) async {
      await tester.pumpWidget(buildProfileTest());
      await tester.pumpAndSettle();

      // ClipOval digunakan untuk foto profil bulat
      expect(find.byType(ClipOval), findsOneWidget);
    });

    testWidgets('menampilkan nama pengguna', (tester) async {
      await tester.pumpWidget(buildProfileTest());
      await tester.pumpAndSettle();

      expect(find.text('Andre Christian Saragih'), findsOneWidget);
    });

    testWidgets('menampilkan username ifs23026', (tester) async {
      await tester.pumpWidget(buildProfileTest());
      await tester.pumpAndSettle();

      expect(find.text('ifs23026'), findsOneWidget);
    });

    testWidgets('menampilkan kartu "Tentang Saya"', (tester) async {
      await tester.pumpWidget(buildProfileTest());
      await tester.pumpAndSettle();

      expect(find.text('Tentang Saya'), findsOneWidget);
    });

    testWidgets('halaman dapat di-scroll', (tester) async {
      await tester.pumpWidget(buildProfileTest());
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
