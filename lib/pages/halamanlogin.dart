import 'package:pengenalanprofesi/main.dart';
import 'package:pengenalanprofesi/pages/dashboardadminbottomup.dart';
import 'package:pengenalanprofesi/pages/halamanregister.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HalamanloginPage extends StatefulWidget {
  const HalamanloginPage({super.key});

  @override
  State<HalamanloginPage> createState() => _HalamanloginPageState();
}

class _HalamanloginPageState extends State<HalamanloginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode(); // Fokus pada kolom password
  String _emailError = '';
  String _passwordError = '';
  bool _isPasswordVisible = false;
  bool _isPasswordFieldFocused = false; // Status fokus pada kolom password

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      if (_emailController.text.isNotEmpty) {
        setState(() {
          _emailError = '';
        });
      }
    });

    _passwordController.addListener(() {
      if (_passwordController.text.isNotEmpty) {
        setState(() {
          _passwordError = '';
        });
      }
    });

    // Mendengarkan perubahan fokus pada kolom password
    _passwordFocusNode.addListener(() {
      setState(() {
        _isPasswordFieldFocused = _passwordFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    bool isValid = true;
    if (email.isEmpty) {
      setState(() {
        _emailError = 'Email belum terisi';
      });
      isValid = false;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Harap masukkan password terlebih dahulu';
      });
      isValid = false;
    }

    if (!isValid) return;

    try {
      // Mencoba login menggunakan Firebase Authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Mengecek apakah widget masih terpasang dan menampilkan dialog sukses
      if (mounted) {
        // Menampilkan dialog sukses dan menunggu dialog selesai
        await _showSuccessDialog();

        // Cek role pengguna dan arahkan ke halaman yang sesuai
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get()
              .then((docSnapshot) {
            if (docSnapshot.exists) {
              String role = docSnapshot.data()?['role'] ?? 'user';
              // Navigasi ke halaman yang sesuai berdasarkan role
              if (role == 'admin') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardAdmin()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              }
            }
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        if (e.code == 'user-not-found') {
          _showErrorDialog('Email belum terdaftar');
        } else if (e.code == 'wrong-password') {
          _showErrorDialog('Password salah');
        } else {
          _showErrorDialog('Email/Password salah!');
        }
      }
    }
  }

  // Dialog untuk login sukses
  Future<void> _showSuccessDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false, // Agar tidak bisa menutup dialog sembarangan
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green.shade700,
                  size: 60,
                ),
                const SizedBox(height: 15),
                Text(
                  'Login Sukses!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );

    // Menunggu 2 detik sebelum menutup dialog dan pindah ke halaman lain
    await Future.delayed(const Duration(seconds: 1));

    // Tutup dialog setelah 2 detik
    Navigator.of(context, rootNavigator: true).pop();
  }

  // Dialog untuk login gagal
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false, // Agar tidak bisa menutup dialog sembarangan
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade700,
                  size: 60,
                ),
                const SizedBox(height: 15),
                Text(
                  'Login Gagal!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red.shade500,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );

    // Menunggu 2 detik sebelum menutup dialog
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context, rootNavigator: true)
          .pop(); // Tutup dialog setelah 2 detik
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Login'),
        backgroundColor: Colors.teal[400],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Image(
                  image: AssetImage('assets/images/login/1.png'),
                  width: 200, // Menyesuaikan ukuran gambar jika diperlukan
                  height: 200, // Menyesuaikan ukuran gambar jika diperlukan
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  errorText: _emailError.isEmpty ? null : _emailError,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  errorText: _passwordError.isEmpty ? null : _passwordError,
                  suffixIcon: _isPasswordFieldFocused
                      ? IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HalamanregisterPage(),
                    ),
                  );
                },
                child: const Text(
                  "Belum punya akun? Daftar di sini",
                  style: TextStyle(color: Colors.teal, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:calculateapp/pages/halamanpilihan.dart';
// import 'package:calculateapp/pages/halamanregister.dart'; // Impor halaman register
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class HalamanloginPage extends StatefulWidget {
//   const HalamanloginPage({super.key});

//   @override
//   State<HalamanloginPage> createState() => _HalamanloginPageState();
// }

// class _HalamanloginPageState extends State<HalamanloginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FocusNode _passwordFocusNode = FocusNode(); // Fokus pada kolom password
//   String _emailError = '';
//   String _passwordError = '';
//   bool _isPasswordVisible = false;
//   bool _isPasswordFieldFocused = false; // Status fokus pada kolom password

//   @override
//   void initState() {
//     super.initState();

//     _emailController.addListener(() {
//       if (_emailController.text.isNotEmpty) {
//         setState(() {
//           _emailError = '';
//         });
//       }
//     });

//     _passwordController.addListener(() {
//       if (_passwordController.text.isNotEmpty) {
//         setState(() {
//           _passwordError = '';
//         });
//       }
//     });

//     // Mendengarkan perubahan fokus pada kolom password
//     _passwordFocusNode.addListener(() {
//       setState(() {
//         _isPasswordFieldFocused = _passwordFocusNode.hasFocus;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _passwordFocusNode.dispose();
//     super.dispose();
//   }

//   Future<void> _login() async {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();

//     bool isValid = true;
//     if (email.isEmpty) {
//       setState(() {
//         _emailError = 'Email belum terisi';
//       });
//       isValid = false;
//     }

//     if (password.isEmpty) {
//       setState(() {
//         _passwordError = 'Harap masukkan password terlebih dahulu';
//       });
//       isValid = false;
//     }

//     if (!isValid) return;

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Login Sukses!'),
//             backgroundColor: Color.fromARGB(255, 3, 108, 47),
//           ),
//         );

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const HalamanpilihanPage()),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       if (mounted) {
//         if (e.code == 'user-not-found') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Email belum terdaftar')),
//           );
//         } else if (e.code == 'wrong-password') {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Password salah')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('email/password salah!')),
//           );
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Halaman Login'),
//         backgroundColor: Colors.teal[400],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 40),
//               const Center(
//                 child: CircleAvatar(
//                   radius: 75,
//                   backgroundColor: Colors.teal,
//                   child: CircleAvatar(
//                     radius: 70,
//                     backgroundImage: AssetImage('assets/images/logologin.png'),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   prefixIcon: const Icon(Icons.email),
//                   errorText: _emailError.isEmpty ? null : _emailError,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _passwordController,
//                 focusNode: _passwordFocusNode,
//                 obscureText: !_isPasswordVisible,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   prefixIcon: const Icon(Icons.lock),
//                   errorText: _passwordError.isEmpty ? null : _passwordError,
//                   suffixIcon: _isPasswordFieldFocused
//                       ? IconButton(
//                           icon: Icon(
//                             _isPasswordVisible
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _isPasswordVisible = !_isPasswordVisible;
//                             });
//                           },
//                         )
//                       : null,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: _login,
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.teal,
//                   minimumSize: const Size(double.infinity, 50),
//                 ),
//                 child: const Text('Login'),
//               ),
//               const SizedBox(height: 20),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const HalamanregisterPage(),
//                     ),
//                   );
//                 },
//                 child: const Text(
//                   "Belum punya akun? Daftar di sini",
//                   style: TextStyle(color: Colors.teal, fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
