import 'package:pengenalanprofesi/pages/halamantebakgambar4.dart';
import 'package:flutter/material.dart';

class Halamantebakgambar3Page extends StatefulWidget {
  const Halamantebakgambar3Page({super.key});

  @override
  State<Halamantebakgambar3Page> createState() =>
      _Halamantebakgambar3PageState();
}

class _Halamantebakgambar3PageState extends State<Halamantebakgambar3Page> {
  final TextEditingController _controller =
      TextEditingController(); // Controller untuk input teks
  bool _isAnswerCorrect = false; // Flag untuk menampilkan tombol Next

  void _checkAnswer() {
    String userAnswer = _controller.text
        .trim()
        .toLowerCase(); // Ambil teks dan konversi ke huruf kecil
    if (userAnswer == "guru") {
      setState(() {
        _isAnswerCorrect = true; // Set flag jadi true ketika jawaban benar
      });
      _showDialog("Yeyyy jawaban Benar!", Colors.green, Icons.check_circle);
    } else {
      _showDialog(
          "Opss, jawaban Salah. Ayo coba lagi!", Colors.red, Icons.error);
    }
  }

  void _showDialog(String message, Color color, IconData icon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 60,
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  backgroundColor: color,
                ),
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const Halamantebakgambar4Page(), // Halaman berikutnya
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tebak Gambar'),
        backgroundColor: Colors.teal[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/tebakgambar/3.png', // Path file gambar
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Masukkan Jawaban',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkAnswer, // Fungsi untuk memeriksa jawaban
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[400], // Warna utama tombol
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12), // Padding tombol
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12), // Bentuk melengkung
                  ),
                  shadowColor: Colors.black, // Warna bayangan
                  elevation: 8, // Tinggi bayangan
                ),
                child: const Text(
                  'Cek Jawaban',
                  style: TextStyle(
                    fontSize: 14, // Ukuran teks
                    color: Colors.white, // Warna teks
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Menampilkan tombol Next hanya jika jawaban benar
              if (_isAnswerCorrect)
                Align(
                  alignment: Alignment.centerRight, // Menempatkan teks di kanan
                  child: GestureDetector(
                    onTap:
                        _goToNextPage, // Fungsi untuk menuju halaman berikutnya
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal[600]!, Colors.teal[400]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
