// lib/data/models/sepatu_model.dart

/// Model data untuk sepatu
/// Menggunakan immutable class (best practice Flutter/Dart)
class SepatuModel {
  const SepatuModel({
    required this.nama,
    required this.gambar,
    required this.merk,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.material,
    required this.ukuranTersedia,
    required this.rating,
    required this.isFavorit,
  });

  final String nama;
  final String gambar;        // Path asset, contoh: 'assets/images/sepatu1.png'
  final String merk;
  final String kategori;      // Basketball, Casual, Running, dll.
  final double harga;
  final String deskripsi;
  final String material;
  final List<String> ukuranTersedia;
  final double rating;
  final bool isFavorit;

  /// Format harga ke Rupiah
  String get hargaFormatted {
    final str = harga.toInt().toString();
    final buffer = StringBuffer();
    int counter = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      if (counter > 0 && counter % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
      counter++;
    }
    return 'Rp ${buffer.toString().split('').reversed.join()}';
  }

  /// Metode copyWith memudahkan pembuatan objek baru dengan data yang diubah sebagian
  SepatuModel copyWith({
    String? nama,
    String? gambar,
    String? merk,
    String? kategori,
    double? harga,
    String? deskripsi,
    String? material,
    List<String>? ukuranTersedia,
    double? rating,
    bool? isFavorit,
  }) {
    return SepatuModel(
      nama:            nama            ?? this.nama,
      gambar:          gambar          ?? this.gambar,
      merk:            merk            ?? this.merk,
      kategori:        kategori        ?? this.kategori,
      harga:           harga           ?? this.harga,
      deskripsi:       deskripsi       ?? this.deskripsi,
      material:        material        ?? this.material,
      ukuranTersedia:  ukuranTersedia  ?? this.ukuranTersedia,
      rating:          rating          ?? this.rating,
      isFavorit:       isFavorit       ?? this.isFavorit,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SepatuModel &&
          runtimeType == other.runtimeType &&
          nama == other.nama;

  @override
  int get hashCode => nama.hashCode;

  @override
  String toString() => 'SepatuModel(nama: $nama, merk: $merk)';
}
