import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HalamanuserPage extends StatefulWidget {
  const HalamanuserPage({super.key});

  @override
  State<HalamanuserPage> createState() => _HalamanuserPageState();
}

class _HalamanuserPageState extends State<HalamanuserPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  String? _schoolLevel; // Store the selected school level
  String? _userIdToUpdate;

  // List of predefined school levels
  List<String> schoolLevels = ['SD', 'SMP', 'SMA'];

  // Reset input form
  void _resetForm() {
    _nameController.clear();
    _emailController.clear();
    _usernameController.clear();
    _roleController.clear();
    setState(() {
      _schoolLevel = null;
      _userIdToUpdate = null;
    });
  }

  // Add User
  Future<void> _addUser() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _schoolLevel == null ||
        _usernameController.text.isEmpty ||
        _roleController.text.isEmpty) {
      _showSnackbar('Semua kolom harus diisi');
      return;
    }

    try {
      await _firestore.collection('users').add({
        'name': _nameController.text,
        'email': _emailController.text,
        'schoolLevel': _schoolLevel,
        'username': _usernameController.text,
        'role': _roleController.text,
        'createdAt': Timestamp.now(),
      });
      _showSnackbar('Pengguna berhasil ditambahkan');
      _resetForm();
    } catch (e) {
      _showSnackbar('Terjadi kesalahan: $e');
    }
  }

  // Update User
  Future<void> _updateUser() async {
    if (_userIdToUpdate == null) {
      _showSnackbar('Pilih pengguna untuk diperbarui');
      return;
    }

    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _schoolLevel == null ||
        _usernameController.text.isEmpty ||
        _roleController.text.isEmpty) {
      _showSnackbar('Semua kolom harus diisi');
      return;
    }

    try {
      await _firestore.collection('users').doc(_userIdToUpdate).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'schoolLevel': _schoolLevel,
        'username': _usernameController.text,
        'role': _roleController.text,
      });
      _showSnackbar('Pengguna berhasil diperbarui');
      _resetForm();
    } catch (e) {
      _showSnackbar('Terjadi kesalahan: $e');
    }
  }

  // Delete User
  Future<void> _deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      _showSnackbar('Pengguna berhasil dihapus');
    } catch (e) {
      _showSnackbar('Terjadi kesalahan: $e');
    }
  }

  // Show Snackbar
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
        title: const Text('Manage User'),
        backgroundColor: Colors.teal[600],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.teal[200]!, Colors.teal[400]!],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Dropdown for school level
                    DropdownButtonFormField<String>(
                      value: _schoolLevel,
                      decoration: const InputDecoration(
                        labelText: 'Jenjang Sekolah',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: schoolLevels
                          .map((level) => DropdownMenuItem<String>(
                                value: level,
                                child: Text(level),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _schoolLevel = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Pilih jenjang sekolah' : null,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _roleController.text.isEmpty
                          ? null
                          : _roleController.text,
                      decoration: const InputDecoration(
                        labelText: 'Role',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: ['admin', 'user']
                          .map((role) => DropdownMenuItem<String>(
                                value: role,
                                child: Text(role),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _roleController.text = value ?? '';
                        });
                      },
                      validator: (value) => value == null ? 'Pilih role' : null,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed:
                              _userIdToUpdate == null ? _addUser : _updateUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[600],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            _userIdToUpdate == null ? 'Tambah' : 'Perbarui',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, size: 27),
                          onPressed: _resetForm,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('users')
                      .orderBy('createdAt')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('Tidak ada data pengguna'));
                    }

                    final users = snapshot.data!.docs;

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        var user = users[index];
                        var userId = user.id;
                        var name = user['name'] ?? 'Tidak ada nama';
                        var email = user['email'] ?? 'Tidak ada email';
                        var schoolLevel =
                            user['schoolLevel'] ?? 'Tidak ada data';
                        var username = user['username'] ?? 'Tidak ada username';

                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            title: Text(
                              name,
                              style: const TextStyle(fontSize: 18),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _nameController.text = name;
                                    _emailController.text = email;
                                    _schoolLevel = schoolLevel;
                                    _usernameController.text = username;
                                    _roleController.text = user['role'] ?? '';
                                    _userIdToUpdate = userId;
                                    setState(() {});
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () => _deleteUser(userId),
                                ),
                              ],
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(name),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Email: $email'),
                                          Text('Jenjang: $schoolLevel'),
                                          Text('Username: $username'),
                                          Text(
                                              'Role: ${user['role'] ?? 'Tidak ada role'}'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Tutup'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
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
      ),
    );
  }
}
