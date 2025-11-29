// File: lib/main7.dart
import 'package:flutter/material.dart';
import 'produk_form.dart'; // Import halaman form

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Data Passing Demo',
      home: ProdukForm(), // Mulai dari halaman form
      debugShowCheckedModeBanner: false,
    );
  }
}