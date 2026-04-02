// test/widget/bottom_nav_widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/core/theme/app_theme.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/core/theme/theme_notifier.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/shared/widgets/bottom_nav_widget.dart';

Widget buildNavTestApp(String initialRoute) {
  final notifier = ThemeNotifier(initial: ThemeMode.light);
  final router = GoRouter(
    initialLocation: initialRoute,
    routes: [
      ShellRoute(
        builder: (context, state, child) => Scaffold(
          body: child,
          bottomNavigationBar: BottomNavWidget(child: child),
        ),
        routes: [
          GoRoute(path: '/', builder: (_, __) => const SizedBox(key: Key('home'))),
          GoRoute(path: '/sepatu', builder: (_, __) => const SizedBox(key: Key('sepatu'))),
          GoRoute(path: '/profile', builder: (_, __) => const SizedBox(key: Key('profile'))),
        ],
      ),
    ],
  );

  return ThemeProvider(
    notifier: notifier,
    child: MaterialApp.router(
      theme: AppTheme.lightTheme,
      routerConfig: router,
    ),
  );
}

void main() {
  group('BottomNavWidget', () {
    testWidgets('merender tiga item navigasi', (tester) async {
      await tester.pumpWidget(buildNavTestApp('/'));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Sepatu'), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);
    });

    testWidgets('menampilkan ikon home aktif di halaman home', (tester) async {
      await tester.pumpWidget(buildNavTestApp('/'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('menekan Sepatu menavigasi ke halaman Sepatu', (tester) async {
      await tester.pumpWidget(buildNavTestApp('/'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sepatu'));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('sepatu')), findsOneWidget);
    });

    testWidgets('menekan Profil menavigasi ke halaman Profil', (tester) async {
      await tester.pumpWidget(buildNavTestApp('/'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Profil'));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('profile')), findsOneWidget);
    });

    testWidgets('menampilkan NavigationBar sebagai bottom bar', (tester) async {
      await tester.pumpWidget(buildNavTestApp('/'));
      await tester.pumpAndSettle();

      expect(find.byType(NavigationBar), findsOneWidget);
    });
  });
}
