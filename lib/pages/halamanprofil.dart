import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pengenalanprofesi/services/user_service.dart'; // Impor file layanan

class HalamanprofilPage extends StatefulWidget {
  const HalamanprofilPage({super.key});

  @override
  State<HalamanprofilPage> createState() => _HalamanprofilPageState();
}

class _HalamanprofilPageState extends State<HalamanprofilPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _schoolLevelController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  String _profileImageUrl = ''; // Menyimpan URL gambar profil

  // Fungsi untuk mengambil data pengguna dari Firestore
  _loadUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid) // Mengambil data pengguna berdasarkan UID
          .get();

      if (userDoc.exists) {
        setState(() {
          _nameController.text = userDoc['name'] ?? '';
          _emailController.text = user.email ?? '';
          _schoolLevelController.text = userDoc['schoolLevel'] ?? '';
          _usernameController.text = userDoc['username'] ?? '';
          _roleController.text = userDoc['role'] ?? '';
          _profileImageUrl =
              userDoc['profileImageUrl'] ?? ''; // Mengambil URL gambar profil
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User data not found in Firestore.')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserProfile(); // Memuat data pengguna saat halaman dibuka
  }

  // Fungsi untuk menyimpan perubahan profil pengguna ke Firestore
  _saveProfileChanges() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await saveUser(user, _usernameController.text, _emailController.text,
          _nameController.text, _schoolLevelController.text);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Halaman Profil'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Pengguna
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: _profileImageUrl.isNotEmpty
                      ? NetworkImage(_profileImageUrl)
                      : const AssetImage('assets/images/sri.png')
                          as ImageProvider, // Gambar default jika tidak ada
                ),
              ),
              const SizedBox(height: 30), // Mengurangi jarak antar elemen

              // Nama
              _buildProfileField(
                icon: Icons.person,
                label: 'Name',
                controller: _nameController,
              ),

              // Email
              _buildProfileField(
                icon: Icons.email,
                label: 'Email',
                controller: _emailController,
                enabled: false,
              ),

              // Username
              _buildProfileField(
                icon: Icons.account_circle,
                label: 'Username',
                controller: _usernameController,
              ),

              // School Level
              _buildProfileField(
                icon: Icons.school,
                label: 'Jenjang Sekolah',
                controller: _schoolLevelController,
              ),

              // Role
              _buildProfileField(
                icon: Icons.security,
                label: 'Role',
                controller: _roleController,
                enabled: false,
              ),

              const SizedBox(height: 20),

              // Button untuk menyimpan perubahan
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 5,
                  ),
                  onPressed: _saveProfileChanges,
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk membuat profil field yang lebih modern dan bersih
  Widget _buildProfileField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    bool enabled = true,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(10.0), // Mengurangi padding agar lebih kompak
        child: TextField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.teal), // Warna ikon
            labelText: label,
            labelStyle: const TextStyle(color: Colors.black), // Warna label
            fillColor: Colors.lightBlue.shade50, // Warna latar belakang
            filled: true, // Mengaktifkan latar belakang
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: Colors.teal, width: 2), // Warna border
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: Colors.teal, width: 2), // Warna border saat fokus
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2), // Warna border saat tidak fokus
            ),
          ),
        ),
      ),
    );
  }
}
