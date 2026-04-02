// lib/features/sepatu/sepatu_detail_screen.dart

import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../data/models/sepatu_model.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/top_app_bar_widget.dart';

class SepatuDetailScreen extends StatefulWidget {
  const SepatuDetailScreen({super.key, required this.sepatuName});
  final String sepatuName;

  @override
  State<SepatuDetailScreen> createState() => _SepatuDetailScreenState();
}

class _SepatuDetailScreenState extends State<SepatuDetailScreen> {
  SepatuModel? _sepatu;
  String? _selectedUkuran;

  @override
  void initState() {
    super.initState();
    // Simulasi async data loading
    Future.microtask(() {
      final result = DummyData.getSepatuData()
          .where((s) => s.nama == widget.sepatuName)
          .firstOrNull;
      if (mounted) {
        setState(() => _sepatu = result);
        if (result == null && mounted) Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_sepatu == null) {
      return Scaffold(
        appBar: TopAppBarWidget(title: widget.sepatuName, showBackButton: true),
        body: const LoadingWidget(),
      );
    }

    return Scaffold(
      appBar: TopAppBarWidget(title: _sepatu!.nama, showBackButton: true),
      body: _SepatuDetailBody(
        sepatu: _sepatu!,
        selectedUkuran: _selectedUkuran,
        onUkuranSelected: (u) => setState(() => _selectedUkuran = u),
      ),
      bottomNavigationBar: _BuyBar(
        sepatu: _sepatu!,
        selectedUkuran: _selectedUkuran,
      ),
    );
  }
}

class _SepatuDetailBody extends StatelessWidget {
  const _SepatuDetailBody({
    required this.sepatu,
    required this.selectedUkuran,
    required this.onUkuranSelected,
  });

  final SepatuModel sepatu;
  final String? selectedUkuran;
  final ValueChanged<String> onUkuranSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Image
          Container(
            width: double.infinity,
            height: 280,
            color: colorScheme.surfaceContainerHighest,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    sepatu.gambar,
                    height: 240,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.shopping_bag, size: 100, color: colorScheme.primary),
                  ),
                ),
                if (sepatu.isFavorit)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.favorite, color: Colors.white, size: 18),
                    ),
                  ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      sepatu.kategori,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sepatu.nama,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            sepatu.merk,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: colorScheme.tertiary),
                            const SizedBox(width: 4),
                            Text(
                              sepatu.rating.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          sepatu.hargaFormatted,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Divider(color: colorScheme.outline.withValues(alpha: 0.3)),
                const SizedBox(height: 16),

                // Pilih Ukuran
                Text(
                  'Pilih Ukuran',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: sepatu.ukuranTersedia.map((u) {
                    final isSelected = selectedUkuran == u;
                    return GestureDetector(
                      onTap: () => onUkuranSelected(u),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 52,
                        height: 42,
                        decoration: BoxDecoration(
                          color: isSelected ? colorScheme.primary : colorScheme.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.outline.withValues(alpha: 0.5),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: colorScheme.primary.withValues(alpha: 0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            u,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: isSelected
                                      ? colorScheme.onPrimary
                                      : colorScheme.onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),
                _InfoCard(title: 'Deskripsi', content: sepatu.deskripsi),
                const SizedBox(height: 12),
                _InfoCard(title: 'Material & Bahan', content: sepatu.material),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.content});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 6),
            Text(content, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _BuyBar extends StatelessWidget {
  const _BuyBar({required this.sepatu, required this.selectedUkuran});
  final SepatuModel sepatu;
  final String? selectedUkuran;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.primary, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart_outlined, color: colorScheme.primary),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      selectedUkuran == null
                          ? 'Pilih ukuran terlebih dahulu!'
                          : '${sepatu.nama} (Ukuran $selectedUkuran) ditambahkan ke keranjang!',
                    ),
                    backgroundColor: selectedUkuran == null
                        ? colorScheme.error
                        : colorScheme.primary,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      selectedUkuran == null
                          ? 'Pilih ukuran terlebih dahulu!'
                          : 'Pembelian ${sepatu.nama} ukuran $selectedUkuran berhasil! 🎉',
                    ),
                    backgroundColor: selectedUkuran == null
                        ? colorScheme.error
                        : Colors.green.shade700,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Beli Sekarang',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
