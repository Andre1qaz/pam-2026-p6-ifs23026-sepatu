// test/screens/home_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/core/theme/app_theme.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/core/theme/theme_notifier.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/features/home/home_screen.dart';

Widget buildHomeTest() {
  final notifier = ThemeNotifier(initial: ThemeMode.light);
  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/sepatu', builder: (_, __) => const SizedBox()),
    GoRoute(path: '/sepatu/:name', builder: (_, __) => const SizedBox()),
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
  group('HomeScreen', () {
    testWidgets('merender tanpa error', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('menampilkan judul "Home" di AppBar', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('menampilkan teks "SoleStore"', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.textContaining('SoleStore'), findsWidgets);
    });

    testWidgets('menampilkan minimal satu Card', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('menampilkan tombol toggle light mode tersedia di AppBar', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    });

    testWidgets('menampilkan teks Pilihan Terbaik', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.textContaining('Pilihan Terbaik'), findsOneWidget);
    });

    testWidgets('menampilkan teks Kategori', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.text('Kategori'), findsOneWidget);
    });
  });
}
