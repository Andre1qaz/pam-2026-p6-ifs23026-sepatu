// test/unit/dummy_data_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/data/dummy_data.dart';
import 'package:pam_2026_p6_ifs23026_sepatu/data/models/sepatu_model.dart';

void main() {
  group('DummyData.getSepatuData()', () {
    late List<SepatuModel> sepatuList;

    setUp(() {
      sepatuList = DummyData.getSepatuData();
    });

    test('mengembalikan list yang tidak kosong', () {
      expect(sepatuList, isNotEmpty);
    });

    test('mengembalikan minimal 10 sepatu', () {
      expect(sepatuList.length, greaterThanOrEqualTo(10));
    });

    test('semua sepatu memiliki nama yang tidak kosong', () {
      for (final s in sepatuList) {
        expect(s.nama, isNotEmpty,
            reason: 'Nama tidak boleh kosong untuk: ${s.nama}');
      }
    });

    test('semua sepatu memiliki path gambar yang valid', () {
      for (final s in sepatuList) {
        expect(s.gambar, startsWith('assets/images/'),
            reason: 'Path gambar tidak valid untuk: ${s.nama}');
        expect(s.gambar, endsWith('.png'),
            reason: 'Gambar harus .png untuk: ${s.nama}');
      }
    });

    test('semua sepatu memiliki deskripsi yang tidak kosong', () {
      for (final s in sepatuList) {
        expect(s.deskripsi, isNotEmpty,
            reason: 'Deskripsi kosong untuk: ${s.nama}');
      }
    });

    test('semua sepatu memiliki ukuran tersedia yang tidak kosong', () {
      for (final s in sepatuList) {
        expect(s.ukuranTersedia, isNotEmpty,
            reason: 'Ukuran kosong untuk: ${s.nama}');
      }
    });

    test('semua sepatu memiliki rating antara 0 dan 5', () {
      for (final s in sepatuList) {
        expect(s.rating, greaterThanOrEqualTo(0.0));
        expect(s.rating, lessThanOrEqualTo(5.0));
      }
    });

    test('tidak ada nama sepatu yang duplikat', () {
      final namaList = sepatuList.map((s) => s.nama).toList();
      final namaSet = namaList.toSet();
      expect(namaSet.length, equals(namaList.length),
          reason: 'Ditemukan nama sepatu yang duplikat');
    });

    test('data "Jordan 1 Red Classic" terdapat dalam list', () {
      final jordan = sepatuList
          .where((s) => s.nama == 'Jordan 1 Red Classic')
          .firstOrNull;
      expect(jordan, isNotNull);
      expect(jordan!.merk, equals('Jordan'));
      expect(jordan.kategori, equals('Basketball'));
    });

    test('filter pencarian berdasarkan nama bekerja dengan benar', () {
      final hasil = sepatuList
          .where((s) => s.nama.toLowerCase().contains('white'))
          .toList();
      expect(hasil.length, greaterThanOrEqualTo(1));
    });

    test('filter pencarian berdasarkan merk Vans', () {
      final vans = sepatuList
          .where((s) => s.merk == 'Vans')
          .toList();
      expect(vans.length, greaterThanOrEqualTo(2));
    });

    test('memanggil getSepatuData dua kali menghasilkan data yang sama', () {
      final list2 = DummyData.getSepatuData();
      expect(sepatuList.length, equals(list2.length));
      for (int i = 0; i < sepatuList.length; i++) {
        expect(sepatuList[i].nama, equals(list2[i].nama));
      }
    });
  });
}
