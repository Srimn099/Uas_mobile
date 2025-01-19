import 'package:pengenalanprofesi/pages/fototentara.dart';
import 'package:flutter/material.dart';
// Impor halaman FotoChef

class HalamantentaraPage extends StatefulWidget {
  const HalamantentaraPage({super.key});

  @override
  State<HalamantentaraPage> createState() => _HalamantentaraPageState();
}

class _HalamantentaraPageState extends State<HalamantentaraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profesi Tentara'),
        backgroundColor: Colors.teal[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gambar Tentara dengan border bulat
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
                      'assets/images/tentara.png',
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
                'Tentara',
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
                'Tentara adalah seseorang yang bertugas untuk membela negara, menjaga keamanan, dan melindungi warga negara dari ancaman luar maupun dalam.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.5,
                  fontFamily: 'Salsa',
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
                        builder: (context) => const FototentaraPage()),
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
