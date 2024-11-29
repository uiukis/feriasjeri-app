import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> checkAdmin() async {
  final email = FirebaseAuth.instance.currentUser?.email;
  if (email != null) {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(email).get();

      if (userDoc.exists) {
        return userDoc.data()?['isAdmin'] ?? false;
      }
    } catch (e) {
      ('Erro ao verificar admin: $e');
    }
  }
  return false;
}
