import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _fireauth = FirebaseAuth.instance;

  Future<bool> checkUserAdmin() async {
    String? email = _fireauth.currentUser?.email;
    if (email != null) {
      try {
        final userDoc = await _firestore.collection('users').doc(email).get();

        if (userDoc.exists) {
          return userDoc.data()?['isAdmin'] ?? false;
        }
      } catch (e) {
        ('Erro ao verificar admin: $e');
      }
    }
    return false;
  }
}
