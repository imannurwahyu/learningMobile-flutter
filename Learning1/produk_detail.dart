// File: lib/produk_detail.dart
import 'package:flutter/material.dart';

// Halaman ini hanya menampilkan data, bisa StatelessWidget
class ProdukDetail extends StatelessWidget {
  // 3. Deklarasikan variabel final untuk menerima data
  final String? kodeProduk;
  final String? namaProduk;
  final int? harga;

  // 4. Buat konstruktor yang menerima data
  const ProdukDetail({
    Key? key,
    required this.kodeProduk, // Gunakan required jika data wajib ada
    required this.namaProduk,
    this.harga, // Bisa nullable jika opsional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 5. Tampilkan data yang diterima
            Text("Kode:", style: Theme.of(context).textTheme.titleSmall),
            Text(kodeProduk ?? 'Tidak ada data', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text("Nama:", style: Theme.of(context).textTheme.titleSmall),
            Text(namaProduk ?? 'Tidak ada data', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text("Harga:", style: Theme.of(context).textTheme.titleSmall),
            Text('Rp ${harga?.toString() ?? 'Tidak ada data'}', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.green)),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context), // Kembali
                child: const Text('Kembali ke Form'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}