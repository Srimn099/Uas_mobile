import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pengenalanprofesi/pages/halamankuis.dart';
import 'package:pengenalanprofesi/pages/halamannonton.dart';
import 'package:pengenalanprofesi/pages/halamanpengaturan.dart';
import 'package:pengenalanprofesi/pages/news_page.dart';
import 'firebase_options.dart';

import 'package:pengenalanprofesi/pages/halamanlogin.dart';
import 'package:pengenalanprofesi/pages/halamanuser.dart';
import 'package:pengenalanprofesi/pages/halamanprofil.dart';
import 'package:pengenalanprofesi/pages/halamanaddquestions.dart';
import 'package:pengenalanprofesi/pages/Piechart.dart';
import 'package:pengenalanprofesi/pages/dashboarduas.dart';
import 'package:pengenalanprofesi/pages/halamantebakgambar.dart';
import 'package:pengenalanprofesi/pages/halamanpilihan.dart';
import 'package:pengenalanprofesi/pages/getapi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Mendapatkan token FCM dan mencetaknya di terminal
  final fcmToken = await FirebaseMessaging.instance.getToken();
  if (fcmToken != null) {
    print('FCM Token: $fcmToken'); // Cetak token ke konsol
  } else {
    print('Tidak dapat mengambil FCM token.');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HalamanloginPage(),
        '/halamanuser': (context) => const HalamanuserPage(),
        '/halamanaddquestions': (context) => const HalamanAddQuestionsPage(),
        '/halamanprofil': (context) => const HalamanprofilPage(),
        '/halamankuis': (context) => const HalamanKuisPage(),
        '/halamanpengaturan': (context) => const HalamanPengaturan(),
        '/piechart': (context) => const PieChartPage(),
        '/dashboarduas': (context) => const DashboarduasPage(),
        '/halamantebakgambar': (context) => const HalamantebakgambarPage(),
        '/halamanpilihan': (context) => const HalamanpilihanPage(),
        '/news_page': (context) => const NewsPage(),
        '/getapi': (context) => const GetapiPage(),
        '/halamannonton': (context) => const HalamannontonPage()
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Menyimpan index halaman yang dipilih

  // Daftar halaman yang akan ditampilkan sesuai tab yang dipilih
  final List<Widget> _pages = [
    const HalamanpilihanPage(), // Halaman Home
    const DashboarduasPage(),
    const HalamantebakgambarPage(),
    const HalamanKuisPage(),
    const HalamanPengaturan()
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
        backgroundColor: Colors.teal[700], // Warna latar belakang
        selectedItemColor: Colors.blueGrey, // Warna item yang dipilih
        unselectedItemColor: const Color.fromARGB(
            219, 209, 202, 202), // Warna item yang tidak dipilih
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', // Tab Home
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Materi', // Tab Profile
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Tebak Gambar', // Tab Profile
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Kuis', // Tab Profile
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings', // Tab Profile
          ),
        ],
      ),
    );
  }
}

// class DashboardAdminBottomUp extends StatefulWidget {
//   const DashboardAdminBottomUp({super.key});

//   @override
//   State<DashboardAdminBottomUp> createState() => _DashboardAdminBottomUpState();
// }

// class _DashboardAdminBottomUpState extends State<DashboardAdminBottomUp> {
//   int _selectedIndex = 0; // Menyimpan index halaman yang dipilih

//   // Daftar halaman yang akan ditampilkan sesuai tab yang dipilih
//   final List<Widget> _pages = [
//     const AdminDashboardPage(), // Halaman Dashboard
//     const HalamanuserPage(), // Halaman Manage User
//     const PieChartPage(), // Halaman Grafik User
//     const HalamanprofilPage(), // Halaman Profile
//   ];

//   // Fungsi untuk mengubah halaman ketika tab dipilih
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[
//           _selectedIndex], // Menampilkan halaman berdasarkan indeks yang dipilih
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex, // Menandakan tab yang aktif
//         onTap: _onItemTapped, // Fungsi untuk mengubah halaman
//         backgroundColor: Colors.teal[700], // Warna latar belakang
//         selectedItemColor:
//             const Color.fromARGB(219, 209, 202, 202), // Warna item yang dipilih
//         unselectedItemColor: Colors.blueGrey, // Warna item yang tidak dipilih
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Dashboard', // Tab Home
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.menu_book),
//             label: 'Manage User', // Tab Manage User
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.photo),
//             label: 'Grafik User', // Tab Grafik User
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile', // Tab Profile
//           ),
//         ],
//       ),
//     );
//   }
// }
