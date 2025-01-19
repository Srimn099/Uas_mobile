import 'package:pengenalanprofesi/components/textname.dart';
import 'package:flutter/material.dart';

class SplashPages extends StatefulWidget {
  const SplashPages({super.key});

  @override
  State<SplashPages> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  @override
  void initState() {
    super.initState();
    // Menunggu 5 detik sebelum berpindah ke halaman utama
    Future.delayed(const Duration(seconds: 5), () {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/halamanlogin');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Smart Calculator',
              style: TextStyle(
                fontSize: 24,
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            CircleAvatar(
              backgroundColor: Colors.deepPurple,
              radius: 50,
              backgroundImage: AssetImage('assets/images/sri.png'),
              // child: Icon(
              //   Icons.camera_alt_outlined,
              //   color: Colors.white,
              // ),
            ),
            SizedBox(height: 10),
            TextName(label: 'NIM', value: '15-2020-099'),
            SizedBox(height: 3),
            TextName(label: 'Nama Lengkap', value: 'Sri Mulyaningsih'),
          ],
        ),
      ),
    );
  }
}
