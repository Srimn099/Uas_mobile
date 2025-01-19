import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome

class HalamandevelopPage extends StatefulWidget {
  const HalamandevelopPage({super.key});

  @override
  State<HalamandevelopPage> createState() => _HalamandevelopPageState();
}

class _HalamandevelopPageState extends State<HalamandevelopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.teal,
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tentang Aplikasi
              const Text(
                'Tentang Aplikasi',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Aplikasi ini membantu pengguna untuk mengenal berbagai profesi dengan cara yang menyenangkan. '
                'Ada banyak informasi menarik, kuis seru, dan materi yang bisa membantu belajar tentang dunia profesi!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),

              // Pengembang Aplikasi
              const SizedBox(height: 20),
              const Text(
                'Pengembang Aplikasi',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),

              // Foto Pengembang
              const Center(
                child: ClipOval(
                  child: Image(
                    image: AssetImage('assets/images/sri.png'),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Nama Pengembang
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0), // Geser ke kanan sedikit
                child:
                    _buildDeveloperInfo(Icons.person, '', 'Sri Mulyaningsih'),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0), // Geser ke kanan sedikit
                child: _buildDeveloperInfo(
                    Icons.email, '', 'srimulyaningsih20juli.com'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: _buildDeveloperInfo(FontAwesomeIcons.instagram, '',
                    '@sri_mningsih'), // Instagram Icon
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0), // Geser ke kanan sedikit
                child: _buildDeveloperInfo(
                    FontAwesomeIcons.github, '', 'github.com/srimn099'),
              ),
              const SizedBox(height: 5),
              const Divider(),

              // Ucapan Terima Kasih
              const SizedBox(height: 15),
              const Text(
                'Terima kasih telah menggunakan aplikasi ini! Semoga bermanfaat.',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan informasi pengembang secara konsisten
  Widget _buildDeveloperInfo(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.teal,
          ),
          const SizedBox(width: 8),
          Text(
            '$label $value',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome

// class HalamandevelopPage extends StatefulWidget {
//   const HalamandevelopPage({super.key});

//   @override
//   State<HalamandevelopPage> createState() => _HalamandevelopPageState();
// }

// class _HalamandevelopPageState extends State<HalamandevelopPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
//         backgroundColor: Colors.teal,
//         elevation: 4.0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Tentang Aplikasi
//               const Text(
//                 'Tentang Aplikasi',
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.teal,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text(
//                 'Aplikasi ini membantu pengguna untuk mengenal berbagai profesi dengan cara yang menyenangkan. '
//                 'Ada banyak informasi menarik, kuis seru, dan materi yang bisa membantu belajar tentang dunia profesi!',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Divider(),

//               // Pengembang Aplikasi
//               const SizedBox(height: 20),
//               const Text(
//                 'Pengembang Aplikasi',
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.teal,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Foto Pengembang
//               Center(
//                 child: ClipOval(
//                   child: Image(
//                     image: AssetImage('assets/images/sri.png'),
//                     width: 150,
//                     height: 150,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Nama Pengembang
//               Padding(
//                 padding:
//                     const EdgeInsets.only(left: 20.0), // Geser ke kanan sedikit
//                 child:
//                     _buildDeveloperInfo(Icons.person, '', 'Sri Mulyaningsih'),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.only(left: 20.0), // Geser ke kanan sedikit
//                 child: _buildDeveloperInfo(
//                     Icons.email, '', 'srimulyaningsih20juli.com'),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0),
//                 child: _buildDeveloperInfo(FontAwesomeIcons.instagram, '',
//                     '@sri_mningsih'), // Instagram Icon
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.only(left: 20.0), // Geser ke kanan sedikit
//                 child: _buildDeveloperInfo(
//                     FontAwesomeIcons.github, '', 'github.com/srimn099'),
//               ),
//               const SizedBox(height: 5),
//               const Divider(),

//               // Ucapan Terima Kasih
//               const SizedBox(height: 15),
//               const Text(
//                 'Terima kasih telah menggunakan aplikasi ini! Semoga bermanfaat.',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontStyle: FontStyle.italic,
//                   color: Colors.black54,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget untuk menampilkan informasi pengembang secara konsisten
//   Widget _buildDeveloperInfo(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             color: Colors.teal,
//           ),
//           const SizedBox(width: 8),
//           Text(
//             '$label $value',
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
