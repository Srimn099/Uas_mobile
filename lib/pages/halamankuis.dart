import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pengenalanprofesi/pages/HasilKuisPage.dart';

class HalamanKuisPage extends StatefulWidget {
  const HalamanKuisPage({super.key});

  @override
  State<HalamanKuisPage> createState() => _HalamanKuisPageState();
}

class _HalamanKuisPageState extends State<HalamanKuisPage> {
  Map<String, String> userAnswers = {};
  List<Map<String, dynamic>> questions = [];

  Future<void> _getQuestions() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection('questions').get();
      List<Map<String, dynamic>> questionsData = [];
      for (var doc in querySnapshot.docs) {
        questionsData.add(doc.data());
      }
      setState(() {
        questions = questionsData;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data kuis: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getQuestions();
  }

  void _submitQuiz() {
    bool allAnswered = questions.every((question) {
      return userAnswers.containsKey(question['question']);
    });

    if (!allAnswered) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.warning, color: Colors.red, size: 30),
                SizedBox(width: 10),
                Text('Peringatan'),
              ],
            ),
            content: const Text('Belum ada jawaban yang dipilih.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tutup'),
              ),
            ],
          );
        },
      );
    } else {
      List<Map<String, dynamic>> result = [];

      for (var question in userAnswers.keys) {
        final questionData =
            questions.firstWhere((q) => q['question'] == question);
        final correctAnswer = questionData['answer'];
        final userAnswer = userAnswers[question];
        bool isCorrect = userAnswer == correctAnswer;

        result.add({
          'question': question,
          'userAnswer': userAnswer,
          'correctAnswer': correctAnswer,
          'isCorrect': isCorrect,
        });
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HasilKuisPage(result: result),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuis'),
        backgroundColor: Colors.teal[400],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: questions.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    var question = questions[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question['question'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Divider(thickness: 1, color: Colors.grey),
                            const SizedBox(height: 10),
                            for (int i = 0; i < 4; i++)
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                leading: Radio<String>(
                                  value: String.fromCharCode(65 + i),
                                  groupValue: userAnswers[question['question']],
                                  activeColor: Colors.teal.shade900,
                                  onChanged: (value) {
                                    setState(() {
                                      userAnswers[question['question']] =
                                          value!;
                                    });
                                  },
                                ),
                                title: Text(
                                  "${String.fromCharCode(65 + i)}. ${question['options'][i]}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                horizontalTitleGap: 0,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: _submitQuiz,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.shade900,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: const Icon(Icons.check, color: Colors.white),
        label: const Text(
          'Kirim Jawaban',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
