import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manipulasi Data',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const TodoListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// 1. Ubah menjadi StatefulWidget
class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  // 2. Simpan data di dalam State
  final List<String> _tasks = ["Belajar Flutter", "Makan Siang", "Tidur"];
  
  // 3. Controller untuk TextField
  final TextEditingController _taskController = TextEditingController();

  // 4. Fungsi untuk menambah data
  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      // 5. Gunakan setState() untuk memberi tahu Flutter agar me-render ulang UI
      setState(() {
        _tasks.add(_taskController.text);
      });
      _taskController.clear(); // Kosongkan field setelah ditambahkan
      Navigator.pop(context); // Tutup dialog
    }
  }

  // 6. Fungsi untuk menghapus data
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Fungsi untuk menampilkan dialog tambah
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Tugas Baru"),
          content: TextField(
            controller: _taskController,
            autofocus: true,
            decoration: const InputDecoration(labelText: "Nama Tugas"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: _addTask, // Panggil fungsi tambah
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Tugas"),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              title: Text(task),
              // 7. Tambahkan aksi hapus
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteTask(index), // Panggil fungsi hapus
              ),
              onLongPress: () {
                // (Contoh interaksi lain)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Tugas: $task")),
                );
              },
            ),
          );
        },
      ),
      // 8. Tombol untuk menambah data
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Panggil dialog
        tooltip: 'Tambah Tugas',
        child: const Icon(Icons.add),
      ),
    );
  }
}