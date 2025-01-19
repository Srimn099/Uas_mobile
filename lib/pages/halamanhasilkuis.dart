// import 'package:flutter/material.dart';

// class HasilKuisPage extends StatelessWidget {
//   final int correctAnswers;
//   final int totalQuestions;
//   final List<Map<String, dynamic>>
//       questionAnswers; // Menambahkan parameter untuk pertanyaan dan jawaban

//   const HasilKuisPage({
//     super.key,
//     required this.correctAnswers,
//     required this.totalQuestions,
//     required this.questionAnswers, // Mengambil data pertanyaan dan jawaban
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Menghitung jumlah jawaban salah
//     int wrongAnswers = totalQuestions - correctAnswers;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hasil Kuis'),
//         backgroundColor: Colors.teal.shade800,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             // Menambahkan SingleChildScrollView agar bisa scroll
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Hasil Kuis',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'BubbleFont',
//                     color: Colors.teal,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 // Menampilkan jumlah benar dalam Card yang menarik
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade400,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//                   child: Column(
//                     children: [
//                       const Icon(
//                         Icons.check_circle,
//                         size: 60,
//                         color: Colors.white,
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         'Jawaban Benar',
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         '$correctAnswers/${totalQuestions}',
//                         style: const TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // Menampilkan jumlah salah dalam Card yang menarik
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade400,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//                   child: Column(
//                     children: [
//                       const Icon(
//                         Icons.cancel,
//                         size: 60,
//                         color: Colors.white,
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         'Jawaban Salah',
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         '$wrongAnswers/${totalQuestions}',
//                         style: const TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 40),

//                 // Menampilkan detail jawaban
//                 const Text(
//                   'Detail Jawaban',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'BubbleFont',
//                     color: Colors.teal,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: totalQuestions,
//                   itemBuilder: (context, index) {
//                     final question = questionAnswers[index];
//                     final questionText = question['question'];
//                     final userAnswer = question['userAnswer'];
//                     final correctAnswer = question['correctAnswer'];
//                     final isCorrect = userAnswer == correctAnswer;

//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 10),
//                       color:
//                           isCorrect ? Colors.green.shade50 : Colors.red.shade50,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ListTile(
//                         title: Text(
//                           questionText,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         subtitle: Text(
//                           'Jawaban Anda: $userAnswer\nJawaban Benar: $correctAnswer',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: isCorrect ? Colors.green : Colors.red,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // Tombol untuk kembali ke halaman utama
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.pop(context); // Kembali ke halaman sebelumnya
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 18, horizontal: 30),
//                     backgroundColor: Colors.teal.shade800, // Background color
//                     shape: RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.circular(30), // Rounded corners
//                     ),
//                     elevation: 10, // Add elevation for a 3D effect
//                     shadowColor:
//                         Colors.black.withOpacity(0.5), // Subtle shadow effect
//                   ),
//                   icon: const Icon(
//                     Icons.home, // Home icon
//                     size: 24, // Icon size
//                     color: Colors.white, // Icon color
//                   ),
//                   label: Text(
//                     'Kembali ke Home',
//                     style: const TextStyle(
//                       fontSize: 16, // Font size slightly larger
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'SignikaNegative', // Custom font
//                       letterSpacing: 1.2, // Add space between letters
//                       color: Colors.white, // Text color
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
