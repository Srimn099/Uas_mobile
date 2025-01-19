import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Fungsi untuk menyimpan data pengguna ke Firestore
Future<void> saveUser(User user, String username, String email, String name,
    String schoolLevel) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  await users.doc(user.uid).set({
    'username': username,
    'email': email,
    'name': name,
    'schoolLevel': schoolLevel,
  });
}
