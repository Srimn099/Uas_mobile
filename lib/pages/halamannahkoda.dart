import 'package:flutter/material.dart';
import 'package:pengenalanprofesi/pages/fotonahkoda.dart';

class HalamannahkodaPage extends StatefulWidget {
  const HalamannahkodaPage({super.key});

  @override
  State<HalamannahkodaPage> createState() => _HalamannahkodaPageState();
}

class _HalamannahkodaPageState extends State<HalamannahkodaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profesi Nahkoda'),
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
                      'assets/images/nahkoda.png',
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
                'Nahkoda',
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
                'Nahkoda bertugas mengemudikan kapal laut.',
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
                        builder: (context) => const FotonahkodaPage()),
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
