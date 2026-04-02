// test/unit/sepatu_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/data/models/sepatu_model.dart';

void main() {
  group('SepatuModel', () {
    const sepatu = SepatuModel(
      nama: 'Jordan 1 Red Classic',
      gambar: 'assets/images/sepatu3.png',
      merk: 'Jordan',
      kategori: 'Basketball',
      harga: 2150000,
      deskripsi: 'Sepatu basketball high-cut ikonik warna merah.',
      material: 'Premium leather upper, rubber outsole.',
      ukuranTersedia: ['39', '40', '41', '42'],
      rating: 4.9,
      isFavorit: true,
    );

    test('membuat objek dengan semua field yang benar', () {
      expect(sepatu.nama, equals('Jordan 1 Red Classic'));
      expect(sepatu.merk, equals('Jordan'));
      expect(sepatu.kategori, equals('Basketball'));
      expect(sepatu.harga, equals(2150000));
      expect(sepatu.rating, equals(4.9));
      expect(sepatu.isFavorit, isTrue);
    });

    test('hargaFormatted mengembalikan format Rupiah yang benar', () {
      expect(sepatu.hargaFormatted, equals('Rp 2.150.000'));
    });

    test('hargaFormatted untuk harga ratusan ribu', () {
      const s = SepatuModel(
        nama: 'Test', gambar: 'a', merk: 'b', kategori: 'c',
        harga: 650000, deskripsi: 'd', material: 'e',
        ukuranTersedia: [], rating: 4.0, isFavorit: false,
      );
      expect(s.hargaFormatted, equals('Rp 650.000'));
    });

    test('copyWith mengubah hanya field yang diberikan', () {
      final updated = sepatu.copyWith(nama: 'Air Zoom Pro Blue', harga: 1350000);
      expect(updated.nama, equals('Air Zoom Pro Blue'));
      expect(updated.harga, equals(1350000));
      expect(updated.merk, equals(sepatu.merk));
      expect(updated.kategori, equals(sepatu.kategori));
      expect(updated.rating, equals(sepatu.rating));
    });

    test('copyWith tanpa argumen menghasilkan objek identik', () {
      final copy = sepatu.copyWith();
      expect(copy.nama, equals(sepatu.nama));
      expect(copy.merk, equals(sepatu.merk));
      expect(copy.harga, equals(sepatu.harga));
    });

    test('dua objek dengan nama sama dianggap equal', () {
      const other = SepatuModel(
        nama: 'Jordan 1 Red Classic',
        gambar: 'assets/images/lain.png',
        merk: 'Brand Lain',
        kategori: 'Casual',
        harga: 999999,
        deskripsi: 'Deskripsi berbeda.',
        material: 'Material lain.',
        ukuranTersedia: ['40'],
        rating: 3.0,
        isFavorit: false,
      );
      expect(sepatu, equals(other));
    });

    test('dua objek dengan nama berbeda tidak equal', () {
      const other = SepatuModel(
        nama: 'Classic White Gum',
        gambar: 'assets/images/sepatu3.png',
        merk: 'Jordan',
        kategori: 'Basketball',
        harga: 2150000,
        deskripsi: 'Sepatu basketball high-cut ikonik.',
        material: 'Premium leather upper.',
        ukuranTersedia: ['39', '40', '41', '42'],
        rating: 4.9,
        isFavorit: true,
      );
      expect(sepatu, isNot(equals(other)));
    });

    test('hashCode konsisten dengan equality', () {
      const same = SepatuModel(
        nama: 'Jordan 1 Red Classic',
        gambar: 'assets/images/berbeda.png',
        merk: 'Berbeda',
        kategori: '-',
        harga: 0,
        deskripsi: '-',
        material: '-',
        ukuranTersedia: [],
        rating: 0,
        isFavorit: false,
      );
      expect(sepatu.hashCode, equals(same.hashCode));
    });

    test('toString menampilkan nama dan merk', () {
      expect(sepatu.toString(), contains('Jordan 1 Red Classic'));
      expect(sepatu.toString(), contains('Jordan'));
    });
  });
}
