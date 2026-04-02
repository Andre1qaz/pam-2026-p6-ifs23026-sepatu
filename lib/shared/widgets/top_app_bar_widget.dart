// lib/shared/widgets/top_app_bar_widget.dart

import 'package:flutter/material.dart';
import '../../core/theme/theme_notifier.dart';

class TopAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBarWidget({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.withSearch = false,
    this.searchQuery = '',
    this.onSearchQueryChange,
  });

  final String title;
  final bool showBackButton;
  final bool withSearch;
  final String searchQuery;
  final ValueChanged<String>? onSearchQueryChange;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<TopAppBarWidget> createState() => _TopAppBarWidgetState();
}

class _TopAppBarWidgetState extends State<TopAppBarWidget> {
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _closeSearch() {
    setState(() => _isSearching = false);
    widget.onSearchQueryChange?.call('');
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeNotifier = ThemeProvider.of(context);

    if (_isSearching) {
      return AppBar(
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _closeSearch,
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: widget.onSearchQueryChange,
          decoration: InputDecoration(
            hintText: 'Cari sepatu...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
          ),
        ),
      );
    }

    return AppBar(
      backgroundColor: colorScheme.surface,
      leading: widget.showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
      ),
      actions: [
        if (widget.withSearch)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => setState(() => _isSearching = true),
          ),
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
