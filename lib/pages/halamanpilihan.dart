import 'package:flutter/material.dart';

class HalamanpilihanPage extends StatefulWidget {
  const HalamanpilihanPage({super.key});

  @override
  State<HalamanpilihanPage> createState() => _HalamanpilihanPageState();
}

class _HalamanpilihanPageState extends State<HalamanpilihanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        elevation: 5,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 171, 186, 184),
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Gambar ilustrasi di atas
                Image.asset(
                  'assets/images/gambar1.png',
                  height: 230,
                ),
                const SizedBox(height: 8),

                // Baris tombol di atas
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSmallButton(
                      icon: Icons.newspaper,
                      label: 'News',
                      onPressed: () {
                        Navigator.pushNamed(context, '/news_page');
                      },
                    ),
                    const SizedBox(width: 10),
                    _buildSmallButton(
                      icon: Icons.cloud,
                      label: 'Api Loc',
                      onPressed: () {
                        Navigator.pushNamed(context, '/getapi');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Kartu Materi
                _buildFeatureCard(
                  icon: Icons.menu_book,
                  title: 'Materi',
                  subtitle: 'Belajar berbagai profesi!',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboarduas');
                  },
                  imagePath: 'assets/images/materilogo.png',
                ),
                const SizedBox(height: 15),

                // Kartu Tebak Gambar
                _buildFeatureCard(
                  icon: Icons.image_search,
                  title: 'Tebak Gambar',
                  subtitle: 'Game seru tentang profesi!',
                  color: Colors.purple,
                  onTap: () {
                    Navigator.pushNamed(context, '/halamantebakgambar');
                  },
                  imagePath: 'assets/images/tebakgambarlogo2.png',
                ),
                const SizedBox(height: 15),

                // Kartu Kuis
                _buildFeatureCard(
                  icon: Icons.quiz,
                  title: 'Kuis',
                  subtitle: 'Uji pengetahuanmu!',
                  color: Colors.green,
                  onTap: () {
                    Navigator.pushNamed(context, '/halamankuis');
                  },
                  imagePath: 'assets/images/iconquiz.png',
                ),
                const SizedBox(height: 15),

                // Kartu Menonton
                _buildFeatureCard(
                  icon: Icons.play_circle_fill,
                  title: 'Menonton',
                  subtitle: 'Tonton video edukasi!',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, '/halamannonton');
                  },
                  imagePath: 'assets/images/iconnonton3.png',
                ),
                const SizedBox(height: 10),

                // Tombol tambahan di bawah
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.all(8),
            shape: const CircleBorder(),
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                child: Image.asset(
                  imagePath,
                  height: 60,
                  width: 60,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
