import 'package:flutter/material.dart';
import 'package:pengenalanprofesi/pages/demoaplikasi.dart';
import 'package:pengenalanprofesi/pages/halamandevelop.dart';
import 'package:pengenalanprofesi/pages/halamanlogin.dart';
import 'halamanprofil.dart'; // Pastikan untuk mengimpor halaman profil

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.teal),
                title: const Text(
                  'Pengaturan Profil',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HalamanprofilPage(),
                    ),
                  );
                },
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.info, color: Colors.teal),
                title: const Text(
                  'Tentang Aplikasi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HalamandevelopPage(),
                    ),
                  );
                },
              ),
            ),

            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.play_circle, color: Colors.teal),
                title: const Text(
                  'Demo Aplikasi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DemoAplikasiPage(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20), // Spacer
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Background color
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                ),
              ),
              onPressed: () {
                // Logika untuk logout
                _showLogoutConfirmationDialog(context);
              },
              icon:
                  const Icon(Icons.logout, color: Colors.white), // Ikon logout
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                // Logika untuk logout, misalnya menghapus token atau kembali ke halaman login
                Navigator.of(context).pop(); // Menutup dialog

                // Navigasi ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const HalamanloginPage()), // Ganti LoginPage() dengan halaman login yang sesuai
                );
              },
            ),
          ],
        );
      },
    );
  }
}
