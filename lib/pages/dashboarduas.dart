import 'package:pengenalanprofesi/pages/halamanarsitektur.dart';
import 'package:pengenalanprofesi/pages/halamanastronot.dart';
import 'package:pengenalanprofesi/pages/halamanchef.dart';
import 'package:pengenalanprofesi/pages/halamandokter.dart';
import 'package:pengenalanprofesi/pages/halamannahkoda.dart';
import 'package:pengenalanprofesi/pages/halamanpemadam.dart';
import 'package:pengenalanprofesi/pages/halamanpeternak.dart';
import 'package:pengenalanprofesi/pages/halamanpilot.dart';
import 'package:pengenalanprofesi/pages/halamanpolisi.dart';
import 'package:pengenalanprofesi/pages/halamantentara.dart';
import 'package:flutter/material.dart';

class DashboarduasPage extends StatefulWidget {
  const DashboarduasPage({super.key});

  @override
  State<DashboarduasPage> createState() => _DashboarduasPageState();
}

class _DashboarduasPageState extends State<DashboarduasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengenalan Profesi'),
        backgroundColor: Colors.teal[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2, // Two items per row
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children: [
            _buildDashboardItem(
              context,
              'assets/images/chef.png', // Path to your image for Chef
              'Chef',
              Colors.blueAccent,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamanchefPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              'assets/images/tentara.png', // Path to your image for Tentara
              'Tentara',
              Colors.redAccent,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamantentaraPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              'assets/images/dokter.png', // Path to your image for Dokter
              'Dokter',
              Colors.orangeAccent,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamandokterPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              'assets/images/pilot.png', // Path to your image for Pilot
              'Pilot',
              Colors.purpleAccent,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamanpilotPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              'assets/images/pemadam.png', // Path to your image for Pemadam Kebakaran
              'Damkar',
              Colors.greenAccent,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamanpemadamPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              'assets/images/polisi.png', // Path to your image for Polisi
              'Polisi',
              Colors.pinkAccent,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamanpolisiPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              'assets/images/peternak.png', // Path to your image for Peternak
              'Peternak',
              Colors.deepOrangeAccent, // Adjust color
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamanpeternakPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              'assets/images/nahkoda.png', // Path to your image for Nahkoda
              'Nahkoda',
              Colors.indigoAccent, // Adjust color
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamannahkodaPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              'assets/images/astronot.png', // Path to your image for Astronot
              'Astronot',
              Colors.amber, // Adjust color
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamanastronotPage()),
                );
              },
            ),
            _buildDashboardItem(
              context,
              'assets/images/arsitektur.png', // Path to your image for Astronot
              'Arsitektur',
              Colors.grey, // Adjust color
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamanarsitekturPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(BuildContext context, String imagePath,
      String title, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap, // Menjalankan aksi saat item diklik
      child: Card(
        color: color,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar profesi
            Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            // Teks tanpa latar belakang atau border
            Text(
              title,
              style: const TextStyle(
                fontSize: 20, // Ukuran teks profesi
                fontWeight: FontWeight.bold,
                color: Colors.white, // Warna teks
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
