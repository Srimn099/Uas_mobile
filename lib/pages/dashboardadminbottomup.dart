import 'package:flutter/material.dart';
import 'package:pengenalanprofesi/pages/dashboardadmin.dart';
import 'package:pengenalanprofesi/pages/halamanpengaturan.dart';
// import 'package:pengenalanprofesi/pages/halamanprofil.dart';
import 'package:pengenalanprofesi/pages/halamanuser.dart';
import 'package:pengenalanprofesi/pages/piechart.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  int _selectedIndex = 0; // Menyimpan index halaman yang dipilih

  // Daftar halaman yang akan ditampilkan sesuai tab yang dipilih
  final List<Widget> _pages = [
    const AdminDashboardPage(), // Halaman Dashboard
    const HalamanuserPage(), // Halaman Manage User
    const PieChartPage(), // Halaman Grafik User
    const HalamanPengaturan(), // Halaman Profile
  ];

  // Fungsi untuk mengubah halaman ketika tab dipilih
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[
          _selectedIndex], // Menampilkan halaman berdasarkan indeks yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Menandakan tab yang aktif
        onTap: _onItemTapped, // Fungsi untuk mengubah halaman
        backgroundColor:
            const Color.fromARGB(219, 209, 202, 202), // Warna item yang dipilih
        selectedItemColor: Colors.teal[700], // Warna latar belakang
        unselectedItemColor: const Color.fromARGB(
            255, 186, 207, 216), // Warna item yang tidak dipilih
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard', // Tab Dashboard
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Manage User', // Tab Manage User
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Grafik User', // Tab Grafik User
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings', // Tab Profile
          ),
        ],
      ),
    );
  }
}
