// lib/core/router/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/home_screen.dart';
import '../../features/sepatu/sepatu_screen.dart';
import '../../features/sepatu/sepatu_detail_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../constants/route_constants.dart';
import '../../shared/widgets/bottom_nav_widget.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteConstants.home,
  routes: [
    // ShellRoute digunakan agar bottom navigation bar
    // tidak di-rebuild setiap berpindah halaman
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: RouteConstants.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RouteConstants.sepatu,
          builder: (context, state) => const SepatuScreen(),
        ),
        GoRoute(
          path: RouteConstants.sepatuDetail,
          builder: (context, state) {
            final name = state.pathParameters['name'] ?? '';
            return SepatuDetailScreen(sepatuName: name);
          },
        ),
        GoRoute(
          path: RouteConstants.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);

/// Shell widget yang membungkus semua halaman
/// dan menampilkan bottom navigation bar
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavWidget(child: child),
    );
  }
}
