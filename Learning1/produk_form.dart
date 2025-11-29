// File: lib/produk_form.dart
import 'package:flutter/material.dart';
import '../produk_detail.dart'; // Import halaman detail

class ProdukForm extends StatefulWidget {
  const ProdukForm({Key? key}) : super(key: key);
  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _kodeController = TextEditingController();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();

  @override
  void dispose() {
    _kodeController.dispose();
    _namaController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _kirimData() {
    // Ambil data dari controller
    String kode = _kodeController.text;
    String nama = _namaController.text;
    int harga = int.tryParse(_hargaController.text) ?? 0; // Konversi ke int, default 0 jika gagal

    // Validasi sederhana (bisa diperlengkap)
    if (kode.isNotEmpty && nama.isNotEmpty) {
      // 1. Gunakan Navigator.push dengan MaterialPageRoute
      Navigator.push(
        context,
        MaterialPageRoute(
          // 2. Buat instance ProdukDetail dan kirim data via konstruktor
          builder: (context) => ProdukDetail(
            kodeProduk: kode,
            namaProduk: nama,
            harga: harga,
          ),
        ),
      );
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kode dan Nama tidak boleh kosong!'), backgroundColor: Colors.orange),
       );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Data Produk')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(controller: _kodeController, decoration: const InputDecoration(labelText: "Kode Produk")),
              const SizedBox(height: 16),
              TextField(controller: _namaController, decoration: const InputDecoration(labelText: "Nama Produk")),
              const SizedBox(height: 16),
              TextField(controller: _hargaController, decoration: const InputDecoration(labelText: "Harga"), keyboardType: TextInputType.number),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _kirimData, // Panggil fungsi _kirimData
                child: const Text('Lihat Detail'),
              )
            ],
          ),
        ),
      ),
    );
  }
}