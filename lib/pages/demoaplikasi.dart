import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Pastikan untuk menambahkan package ini di pubspec.yaml

class DemoAplikasiPage extends StatefulWidget {
  const DemoAplikasiPage({super.key});

  @override
  State<DemoAplikasiPage> createState() => _DemoAplikasiPagePageState();
}

class _DemoAplikasiPagePageState extends State<DemoAplikasiPage> {
  final String youtubeUrl =
      'https://www.youtube.com/watch?v=YOUR_VIDEO_ID'; // Ganti dengan link YouTube Anda

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Aplikasi'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity, // Pastikan mengisi seluruh layar
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 165, 228, 223),
              Colors.teal.shade300
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Mengubah warna teks dan menambahkan bayangan
              const Text(
                'Demo Aplikasi\nPengenalan Profesi',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(2, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  _launchURL(youtubeUrl);
                },
                child: Text(
                  youtubeUrl,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 17, 125, 213),
                    decoration: TextDecoration.underline,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Background color
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(25.0), // Rounded corners
                  ),
                  elevation: 5, // Menambahkan bayangan pada tombol
                ),
                onPressed: () {
                  _launchURL(youtubeUrl);
                },
                child: const Text(
                  'Klik Di Sini',
                  style: TextStyle(
                    color: Color.fromARGB(255, 228, 227, 227),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
