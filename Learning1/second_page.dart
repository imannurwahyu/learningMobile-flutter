// File: lib/second_page.dart
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
        // AppBar otomatis menampilkan tombol back jika bisa kembali
      ),
      body: Center(
        child: ElevatedButton(
          // 4. Callback untuk kembali ke halaman sebelumnya
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}