import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetapiPage extends StatefulWidget {
  const GetapiPage({super.key});

  @override
  _GetapiPageState createState() => _GetapiPageState();
}

class _GetapiPageState extends State<GetapiPage> {
  List professions = [];

  // Controllers untuk form input
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Fungsi untuk mengambil data profesi
  Future<void> fetchProfessions() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2/api_profesi/get_professions.php'));

    if (response.statusCode == 200) {
      setState(() {
        professions = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Fungsi untuk menambahkan profesi
  Future<void> addProfession() async {
    const String apiUrl =
        'http://10.0.2.2/api_profesi/add_profession.php'; // URL API

    // Data yang akan dikirim
    final Map<String, dynamic> professionData = {
      'name': nameController.text,
      'description': descriptionController.text,
    };

    // Mengirim data dengan POST
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(professionData),
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      // Menampilkan popup dengan dialog custom
      if (responseData['success'] == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Sukses!"),
              content: Text(responseData['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    fetchProfessions();
                    nameController.clear();
                    descriptionController.clear();
                  },
                  child: const Text('Tutup'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Gagal!"),
              content: Text(responseData['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Tutup'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Gagal!"),
            content: const Text('Gagal menambahkan profesi'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tutup'),
              ),
            ],
          );
        },
      );
    }
  }

  // Fungsi untuk menghapus profesi
  Future<void> deleteProfession(String id) async {
    const String apiUrl =
        'http://10.0.2.2/api_profesi/delete_profession.php'; // URL API

    // Pastikan id dikirim sebagai string atau integer sesuai yang dibutuhkan API
    final Map<String, dynamic> data = {'id': id};

    // Mengirim data dengan POST
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      // Menampilkan popup dengan dialog custom
      if (responseData['success'] == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Sukses!"),
              content: Text(responseData['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    fetchProfessions();
                  },
                  child: const Text('Tutup'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Gagal!"),
              content: Text(responseData['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Tutup'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Gagal!"),
            content: const Text('Gagal menghapus profesi'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tutup'),
              ),
            ],
          );
        },
      );
    }
  }

  // Fungsi untuk menampilkan dialog konfirmasi sebelum menghapus profesi
  void confirmDeleteProfession(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Apakah Anda yakin ingin menghapus?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog tanpa tindakan
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                deleteProfession(
                    id); // Memanggil fungsi delete setelah konfirmasi
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchProfessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Local : Informasi Profesi'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Form untuk menambahkan profesi baru
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Profesi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi Profesi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: addProfession,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Warna latar tombol
                      foregroundColor: Colors.white, // Warna teks tombol
                    ),
                    child: const Text('Tambah Profesi'),
                  )
                ],
              ),
            ),

            // Menampilkan data profesi
            professions.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: professions.length,
                    itemBuilder: (context, index) {
                      final profession = professions[index];
                      return ListTile(
                        title: Text(
                          profession['name'], // Nama Profesi
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          profession['description'], // Deskripsi Profesi
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Panggil fungsi confirmDeleteProfession untuk menampilkan dialog konfirmasi
                            confirmDeleteProfession(
                                profession['id'].toString());
                          },
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
