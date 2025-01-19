import 'package:flutter/material.dart';
import 'package:pengenalanprofesi/pages/fotoarsitektur.dart';

class HalamanarsitekturPage extends StatefulWidget {
  const HalamanarsitekturPage({super.key});

  @override
  State<HalamanarsitekturPage> createState() => _HalamanarsitekturPageState();
}

class _HalamanarsitekturPageState extends State<HalamanarsitekturPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profesi Arsitektur'),
        backgroundColor: Colors.teal[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gambar Chef dengan border bulat
              Center(
                child: Container(
                  width: 220, // Ukuran total termasuk border
                  height: 220, // Ukuran total termasuk border
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.teal, // Warna isi border
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/arsitektur.png',
                      width: 200, // Ukuran gambar
                      height: 200, // Ukuran gambar
                      fit: BoxFit.cover, // Gambar memenuhi area
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Judul dengan font bubble
              const Text(
                'Arsitektur',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  fontFamily: 'BubbleFont', // Menggunakan font bubble
                ),
              ),
              const SizedBox(height: 10),
              // Deskripsi dengan font bubble
              const Text(
                'Arsitek bertugas merancang bangunan dan rumah.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.5,
                  fontFamily: 'BubbleFont', // Menggunakan font bubble
                ),
              ),
              const SizedBox(height: 20),
              // Tombol untuk melihat foto
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman FotoChefPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FotoarsitekturPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal, // Warna teks tombol
                ),
                child: const Text('Lihat Foto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
