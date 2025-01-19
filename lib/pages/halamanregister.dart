import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pengenalanprofesi/pages/halamanlogin.dart'; // Impor halaman login

class HalamanregisterPage extends StatefulWidget {
  const HalamanregisterPage({super.key});

  @override
  State<HalamanregisterPage> createState() => _HalamanregisterPageState();
}

class _HalamanregisterPageState extends State<HalamanregisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Menyimpan pilihan jenjang sekolah
  String? _selectedSchoolLevel;

  // Daftar pilihan jenjang sekolah
  final List<String> _schoolLevels = ['SD', 'SMP', 'SMA'];

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Cek apakah password dan repeat password cocok
    if (_passwordController.text != _repeatPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password dan Repeat Password tidak cocok')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Mendaftar pengguna menggunakan Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final userId = userCredential.user?.uid;

      // Simpan data pengguna ke Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': _nameController.text.trim(),
        'schoolLevel': _selectedSchoolLevel ??
            '', // Menggunakan jenjang sekolah yang dipilih
        'username': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
        'createdAt':
            FieldValue.serverTimestamp(), // Menyimpan waktu pendaftaran
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran berhasil!')),
      );

      Navigator.pop(context); // Kembali ke halaman login
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Terjadi kesalahan.";
      if (e.code == 'weak-password') {
        errorMessage = "Password terlalu lemah.";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "Email sudah digunakan.";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Daftar'),
        backgroundColor: Colors.teal[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Center(
                  child: Image(
                    image: AssetImage('assets/images/login/2.png'),
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 30),
                // Input Nama
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Dropdown Jenjang Sekolah
                DropdownButtonFormField<String>(
                  value: _selectedSchoolLevel,
                  decoration: const InputDecoration(
                    labelText: 'Jenjang Sekolah',
                    prefixIcon: Icon(Icons.school),
                  ),
                  items: _schoolLevels.map((String level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSchoolLevel = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih jenjang sekolah';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Input Username
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Input Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Masukkan email yang valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Input Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    if (value.length < 6) {
                      return 'Password harus memiliki setidaknya 6 karakter';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                // Input Repeat Password
                TextFormField(
                  controller: _repeatPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Konfirmasi Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Repeat Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Tombol Daftar
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _registerUser,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.teal,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Daftar'),
                      ),
                const SizedBox(height: 10),
                // Tombol Sudah Punya Akun? Login
                TextButton(
                  onPressed: () {
                    // Navigasi ke halaman login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HalamanloginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sudah punya akun? Login di sini",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
