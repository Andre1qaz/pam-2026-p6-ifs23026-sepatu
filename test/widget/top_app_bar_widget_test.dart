// test/widget/top_app_bar_widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/core/theme/app_theme.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/core/theme/theme_notifier.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/shared/widgets/top_app_bar_widget.dart';

Widget buildTestApp({required Widget child}) {
  final notifier = ThemeNotifier(initial: ThemeMode.light);
  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (_, __) => child),
  ]);

  return ThemeProvider(
    notifier: notifier,
    child: MaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
    ),
  );
}

void main() {
  group('TopAppBarWidget', () {
    testWidgets('menampilkan judul dengan benar', (tester) async {
      await tester.pumpWidget(buildTestApp(
        child: const Scaffold(
          appBar: TopAppBarWidget(title: 'SoleStore'),
          body: SizedBox(),
        ),
      ));
      expect(find.text('SoleStore'), findsOneWidget);
    });

    testWidgets('tidak menampilkan tombol back secara default', (tester) async {
      await tester.pumpWidget(buildTestApp(
        child: const Scaffold(
          appBar: TopAppBarWidget(title: 'Home'),
          body: SizedBox(),
        ),
      ));
      expect(find.byIcon(Icons.arrow_back), findsNothing);
    });

    testWidgets('menampilkan tombol back saat showBackButton = true', (tester) async {
      await tester.pumpWidget(buildTestApp(
        child: const Scaffold(
          appBar: TopAppBarWidget(title: 'Detail', showBackButton: true),
          body: SizedBox(),
        ),
      ));
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('menampilkan tombol toggle light mode', (tester) async {
      await tester.pumpWidget(buildTestApp(
        child: const Scaffold(
          appBar: TopAppBarWidget(title: 'Home'),
          body: SizedBox(),
        ),
      ));
      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    });

    testWidgets('tombol toggle mengubah ikon saat ditekan', (tester) async {
      await tester.pumpWidget(buildTestApp(
        child: const Scaffold(
          appBar: TopAppBarWidget(title: 'Home'),
          body: SizedBox(),
        ),
      ));
      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
      await tester.tap(find.byIcon(Icons.light_mode_outlined));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
    });

    testWidgets('menampilkan tombol search saat withSearch = true', (tester) async {
      await tester.pumpWidget(buildTestApp(
        child: const Scaffold(
          appBar: TopAppBarWidget(title: 'Sepatu', withSearch: true),
          body: SizedBox(),
        ),
      ));
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('menekan tombol search menampilkan TextField', (tester) async {
      await tester.pumpWidget(buildTestApp(
        child: const Scaffold(
          appBar: TopAppBarWidget(title: 'Sepatu', withSearch: true),
          body: SizedBox(),
        ),
      ));
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('menekan tombol close menutup search dan mereset query', (tester) async {
      String query = '';
      await tester.pumpWidget(buildTestApp(
        child: Scaffold(
          appBar: TopAppBarWidget(
            title: 'Sepatu',
            withSearch: true,
            onSearchQueryChange: (q) => query = q,
          ),
          body: const SizedBox(),
        ),
      ));
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'jordan');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsNothing);
      expect(query, equals(''));
    });

    testWidgets('tidak menampilkan tombol search secara default', (tester) async {
      await tester.pumpWidget(buildTestApp(
        child: const Scaffold(
          appBar: TopAppBarWidget(title: 'Profil'),
          body: SizedBox(),
        ),
      ));
      expect(find.byIcon(Icons.search), findsNothing);
    });
  });
}
