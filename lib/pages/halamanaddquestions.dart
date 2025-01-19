import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HalamanAddQuestionsPage extends StatefulWidget {
  const HalamanAddQuestionsPage({super.key});

  @override
  State<HalamanAddQuestionsPage> createState() =>
      _HalamanAddQuestionsPageState();
}

class _HalamanAddQuestionsPageState extends State<HalamanAddQuestionsPage> {
  // Controllers untuk text field
  final _questionController = TextEditingController();
  final _optionAController = TextEditingController();
  final _optionBController = TextEditingController();
  final _optionCController = TextEditingController();
  final _optionDController = TextEditingController();
  final _answerController = TextEditingController();

  // Key untuk form validation
  final _formKey1 = GlobalKey<FormState>();

  // Variabel untuk menyimpan ID pertanyaan yang sedang diperbarui
  String? _currentQuestionId;

  // Fungsi untuk menambahkan atau memperbarui pertanyaan di Firestore
  Future<void> _addQuestion() async {
    if (_formKey1.currentState!.validate()) {
      final newQuestion = {
        'question': _questionController.text.trim(),
        'options': [
          _optionAController.text.trim(),
          _optionBController.text.trim(),
          _optionCController.text.trim(),
          _optionDController.text.trim(),
        ],
        'answer': _answerController.text.trim().toUpperCase(),
      };

      try {
        if (_currentQuestionId == null) {
          // Jika _currentQuestionId null, artinya ini adalah pertanyaan baru
          await FirebaseFirestore.instance
              .collection('questions')
              .add(newQuestion);
          _showSuccessPopup('Pertanyaan berhasil ditambahkan!');
        } else {
          // Jika _currentQuestionId tidak null, berarti kita sedang memperbarui pertanyaan yang sudah ada
          await FirebaseFirestore.instance
              .collection('questions')
              .doc(_currentQuestionId)
              .update(newQuestion);
          _showSuccessPopup('Pertanyaan berhasil diperbarui!');
        }

        // Reset form setelah data berhasil ditambahkan atau diperbarui
        _refreshForm();
      } catch (e) {
        _showErrorPopup('Gagal menambahkan/ memperbarui pertanyaan: $e');
      }
    }
  }

  // Fungsi untuk menghapus pertanyaan dari Firestore
  Future<void> _deleteQuestion(String questionId) async {
    try {
      await FirebaseFirestore.instance
          .collection('questions')
          .doc(questionId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pertanyaan berhasil dihapus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menghapus pertanyaan: $e')),
      );
    }
  }

  // Fungsi untuk menampilkan dialog konfirmasi hapus
  void _showDeleteDialog(String questionId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 10),
              Text('Apakah Anda yakin ingin menghapus?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _deleteQuestion(questionId);
                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  // Popup sukses
  void _showSuccessPopup(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // Popup error
  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.red),
              const SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // Tombol refresh untuk mengosongkan form
  void _refreshForm() {
    _questionController.clear();
    _optionAController.clear();
    _optionBController.clear();
    _optionCController.clear();
    _optionDController.clear();
    _answerController.clear();
    _currentQuestionId = null; // Reset ID pertanyaan yang sedang diedit
  }

  // Fungsi untuk mengedit pertanyaan yang ada
  void _editQuestion(String questionId, String questionText,
      List<String> options, String answer) {
    _currentQuestionId = questionId;
    _questionController.text = questionText;
    _optionAController.text = options[0];
    _optionBController.text = options[1];
    _optionCController.text = options[2];
    _optionDController.text = options[3];
    _answerController.text = answer;
  }

  // Fungsi untuk menampilkan dialog detail pertanyaan
  void _showQuestionDetailDialog(String questionId, String questionText,
      List<String> options, String answer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(questionText),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('A. ${options[0]}'),
              Text('B. ${options[1]}'),
              Text('C. ${options[2]}'),
              Text('D. ${options[3]}'),
              Text('Jawaban: $answer'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Kuis'),
        backgroundColor: Colors.teal.shade800,
      ),
      body: SingleChildScrollView(
        // Membuat seluruh body scrollable
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tambah Pertanyaan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Form untuk menambah pertanyaan baru
            Form(
              key: _formKey1,
              child: Column(
                children: [
                  TextFormField(
                    controller: _questionController,
                    decoration: const InputDecoration(
                      labelText: 'Pertanyaan',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Pertanyaan tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _optionAController,
                    decoration: const InputDecoration(
                      labelText: 'Opsi A',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Opsi A tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _optionBController,
                    decoration: const InputDecoration(
                      labelText: 'Opsi B',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Opsi B tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _optionCController,
                    decoration: const InputDecoration(
                      labelText: 'Opsi C',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Opsi C tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _optionDController,
                    decoration: const InputDecoration(
                      labelText: 'Opsi D',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Opsi D tidak boleh kosong'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _answerController,
                    decoration: const InputDecoration(
                      labelText: 'Jawaban Benar (A/B/C/D)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Jawaban tidak boleh kosong';
                      }
                      if (!['A', 'B', 'C', 'D'].contains(value.toUpperCase())) {
                        return 'Jawaban harus A, B, C, atau D';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _addQuestion,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          backgroundColor: Colors.teal.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Tambah/Perbarui',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _refreshForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          backgroundColor: Colors.teal.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Refresh',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Daftar Pertanyaan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Menampilkan daftar pertanyaan yang ada di Firestore
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.4, // Menentukan ukuran daftar
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('questions')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('Tidak ada pertanyaan tersedia.'));
                  }

                  final questions = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final questionData = questions[index];
                      final questionId = questionData.id;
                      final questionText = questionData['question'] as String;
                      final options =
                          List<String>.from(questionData['options']);
                      final answer = questionData['answer'] as String;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 3,
                        color: Colors.teal.shade100, // Ubah warna box di sini
                        child: ListTile(
                          title: Text(questionText),
                          onTap: () {
                            _showQuestionDetailDialog(
                                questionId, questionText, options, answer);
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _editQuestion(questionId, questionText,
                                      options, answer);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _showDeleteDialog(questionId);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
