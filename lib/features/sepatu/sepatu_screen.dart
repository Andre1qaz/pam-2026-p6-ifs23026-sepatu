// lib/features/sepatu/sepatu_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/route_constants.dart';
import '../../data/dummy_data.dart';
import '../../data/models/sepatu_model.dart';
import '../../shared/widgets/top_app_bar_widget.dart';

class SepatuScreen extends StatefulWidget {
  const SepatuScreen({super.key});

  @override
  State<SepatuScreen> createState() => _SepatuScreenState();
}

class _SepatuScreenState extends State<SepatuScreen> {
  List<SepatuModel> _sepatuList = DummyData.getSepatuData();
  String _searchQuery = '';

  void _onSearchQueryChange(String query) {
    setState(() {
      _searchQuery = query;
      _sepatuList = DummyData.getSepatuData()
          .where((s) =>
              s.nama.toLowerCase().contains(query.toLowerCase()) ||
              s.merk.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBarWidget(
        title: 'Koleksi Sepatu',
        withSearch: true,
        searchQuery: _searchQuery,
        onSearchQueryChange: _onSearchQueryChange,
      ),
      body: _SepatuBody(
        sepatuList: _sepatuList,
        onOpen: (name) => context.go('${RouteConstants.sepatu}/$name'),
      ),
    );
  }
}

class _SepatuBody extends StatelessWidget {
  const _SepatuBody({required this.sepatuList, required this.onOpen});

  final List<SepatuModel> sepatuList;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (sepatuList.isEmpty) {
      return Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search_off, size: 48, color: colorScheme.onSurfaceVariant),
                const SizedBox(height: 12),
                Text('Tidak ada data!',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sepatuList.length,
      itemBuilder: (context, index) => _SepatuItemCard(
        sepatu: sepatuList[index],
        onOpen: onOpen,
      ),
    );
  }
}

class _SepatuItemCard extends StatelessWidget {
  const _SepatuItemCard({required this.sepatu, required this.onOpen});

  final SepatuModel sepatu;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => onOpen(sepatu.nama),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 90,
                  height: 90,
                  color: colorScheme.surfaceContainerHighest,
                  child: Image.asset(
                    sepatu.gambar,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.shopping_bag, size: 40, color: colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            sepatu.nama,
                            style: Theme.of(context).textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (sepatu.isFavorit)
                          Icon(Icons.favorite, size: 16, color: colorScheme.primary),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      sepatu.merk,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        sepatu.kategori,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sepatu.hargaFormatted,
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: colorScheme.tertiary),
                            const SizedBox(width: 3),
                            Text(sepatu.rating.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
