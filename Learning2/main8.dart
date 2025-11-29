import 'package:flutter/material.dart';
import 'produk_page.dart'; // Impor halaman produk

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Produk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProdukPage(), // Mulai aplikasi di halaman ProdukPage
      debugShowCheckedModeBanner: false,
    );
  }
}