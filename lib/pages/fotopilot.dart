import 'package:flutter/material.dart';

class FotopilotPage extends StatelessWidget {
  const FotopilotPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar path foto
    final List<String> fotoPaths = [
      'assets/images/fotopilot/1.png',
      'assets/images/fotopilot/2.png',
      'assets/images/fotopilot/3.png',
      'assets/images/fotopilot/4.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Foto Pilot'),
        backgroundColor: Colors.teal[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Jumlah kolom dalam grid
            crossAxisSpacing: 12.0, // Jarak antar kolom
            mainAxisSpacing: 12.0, // Jarak antar baris
            childAspectRatio: 1.0, // Membuat kotak gambar lebih proporsional
          ),
          itemCount: fotoPaths.length, // Jumlah gambar
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Transisi ke halaman foto detail dengan efek zoom
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailFotoPage(fotoPath: fotoPaths[index]),
                  ),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(fotoPaths[index]),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: const Center(
                    child: Text(
                      'Tap to view',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailFotoPage extends StatelessWidget {
  final String fotoPath;

  const DetailFotoPage({super.key, required this.fotoPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Foto'),
        backgroundColor: Colors.teal[400],
      ),
      body: Center(
        child: Hero(
          tag: fotoPath,
          child: InteractiveViewer(
            maxScale: 4.0, // Zoom-in gambar
            minScale: 0.5, // Zoom-out gambar
            child: Image.asset(
              fotoPath,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }
}
