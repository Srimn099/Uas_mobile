import 'package:flutter/material.dart';

class HasilKuisPage extends StatelessWidget {
  final List<Map<String, dynamic>> result;

  const HasilKuisPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    int correctAnswers = result.where((r) => r['isCorrect'] == true).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuis'),
        backgroundColor: Colors.teal[700],
        elevation: 10,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.teal.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skor Anda: $correctAnswers / ${result.length}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  var r = result[index];
                  return Card(
                    elevation: 6,
                    margin: const EdgeInsets.only(bottom: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r['question'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Jawaban Anda: ${r['userAnswer']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Jawaban Benar: ${r['correctAnswer']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                r['isCorrect']
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color:
                                    r['isCorrect'] ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                r['isCorrect'] ? 'Benar' : 'Salah',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: r['isCorrect']
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
