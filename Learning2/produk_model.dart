// 1. Definisikan Model Data
class Produk {
  final String nama;
  final String deskripsi;
  final int harga;
  final String imageUrl;
  final int kuantitas;// Tambahan untuk gambar

  Produk({
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.imageUrl,
    required this.kuantitas,
  });
}