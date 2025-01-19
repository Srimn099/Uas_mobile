import 'package:flutter/material.dart';
import 'package:pengenalanprofesi/pages/fotodokter.dart';

class HalamandokterPage extends StatefulWidget {
  const HalamandokterPage({super.key});

  @override
  State<HalamandokterPage> createState() => _HalamandokterPageState();
}

class _HalamandokterPageState extends State<HalamandokterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profesi Dokter'),
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
                      'assets/images/dokter.png',
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
                'Dokter',
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
                'Dokter membantu kita tetap sehat dan mengobati serta merawat kita ketika kita sakit.',
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
                        builder: (context) => const FotodokterPage()),
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
