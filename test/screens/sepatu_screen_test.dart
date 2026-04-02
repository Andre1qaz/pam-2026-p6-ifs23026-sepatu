// test/screens/sepatu_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/core/theme/app_theme.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/core/theme/theme_notifier.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/data/dummy_data.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/features/sepatu/sepatu_screen.dart';

Widget buildSepatuTest() {
  final notifier = ThemeNotifier(initial: ThemeMode.light);
  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (_, __) => const SepatuScreen()),
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
  group('SepatuScreen', () {
    testWidgets('merender tanpa error', (tester) async {
      await tester.pumpWidget(buildSepatuTest());
      await tester.pumpAndSettle();

      expect(find.byType(SepatuScreen), findsOneWidget);
    });

    testWidgets('menampilkan judul "Koleksi Sepatu" di AppBar', (tester) async {
      await tester.pumpWidget(buildSepatuTest());
      await tester.pumpAndSettle();

      expect(find.text('Koleksi Sepatu'), findsOneWidget);
    });

    testWidgets('menampilkan tombol search di AppBar', (tester) async {
      await tester.pumpWidget(buildSepatuTest());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('menampilkan semua sepatu dari DummyData', (tester) async {
      await tester.pumpWidget(buildSepatuTest());
      await tester.pumpAndSettle();

      final sepatuList = DummyData.getSepatuData();
      expect(find.text(sepatuList.first.nama), findsOneWidget);
    });

    testWidgets('menampilkan list sepatu menggunakan ListView', (tester) async {
      await tester.pumpWidget(buildSepatuTest());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('fungsi search memfilter sepatu berdasarkan nama', (tester) async {
      await tester.pumpWidget(buildSepatuTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Jordan');
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(ListView),
          matching: find.text('Air Zoom Pro Blue'),
        ),
        findsOneWidget,
      );
      expect(find.text('Classic White Gum'), findsNothing);
    });

    testWidgets('menampilkan pesan saat tidak ada hasil pencarian', (tester) async {
      await tester.pumpWidget(buildSepatuTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'xyzabc999');
      await tester.pumpAndSettle();

      expect(find.text('Tidak ada data!'), findsOneWidget);
    });

    testWidgets('menutup search mereset daftar sepatu', (tester) async {
      await tester.pumpWidget(buildSepatuTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Jordan');
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text(DummyData.getSepatuData().last.nama),
        500,
      );
      expect(find.text(DummyData.getSepatuData().last.nama), findsOneWidget);
    });
  });
}
