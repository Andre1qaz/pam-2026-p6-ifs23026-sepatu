// test/integration/app_navigation_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/app.dart';

void main() {
  group('Navigasi Aplikasi (End-to-End)', () {
    testWidgets('aplikasi berjalan dan menampilkan HomeScreen', (tester) async {
      await tester.pumpWidget(const SoleStoreApp());
      await tester.pumpAndSettle();

      expect(find.widgetWithText(AppBar, 'Home'), findsOneWidget);
    });

    testWidgets('navigasi dari Home ke Sepatu via BottomNav', (tester) async {
      await tester.pumpWidget(const SoleStoreApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sepatu'));
      await tester.pumpAndSettle();

      expect(find.text('Koleksi Sepatu'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('navigasi dari Home ke Profil via BottomNav', (tester) async {
      await tester.pumpWidget(const SoleStoreApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Profil'));
      await tester.pumpAndSettle();

      expect(find.text('Tentang Saya'), findsOneWidget);
    });

    testWidgets('toggle dark mode mengubah tema aplikasi', (tester) async {
      await tester.pumpWidget(const SoleStoreApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);

      await tester.tap(find.byIcon(Icons.light_mode_outlined));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
    });

    testWidgets('toggle dark mode tetap aktif saat berpindah halaman', (tester) async {
      await tester.pumpWidget(const SoleStoreApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.light_mode_outlined));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sepatu'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
    });

    testWidgets('pencarian di halaman Sepatu dapat menemukan sepatu', (tester) async {
      await tester.pumpWidget(const SoleStoreApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('Sepatu')));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Air');
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(ListView),
          matching: find.text('Air Zoom Pro Blue'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('navigasi kembali ke Home dari Sepatu menggunakan BottomNav', (tester) async {
      await tester.pumpWidget(const SoleStoreApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('Sepatu')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      expect(find.textContaining('SoleStore'), findsWidgets);
    });
  });
}
