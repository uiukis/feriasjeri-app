import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feriasjeri_app/data/models/voucher.dart';
import 'package:feriasjeri_app/data/repositories/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VoucherService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> saveVoucher(Voucher voucher) async {
    try {
      if (userId != null) {
        await _firestore.collection('vouchers').add({
          ...voucher.toJson(),
          'userId': userId,
        });
      } else {
        throw Exception('Usuário não autenticado');
      }
    } catch (e) {
      throw Exception('Erro ao salvar voucher: $e');
    }
  }

  Future<List<Voucher>> fetchVouchers() async {
    final UserService userService = UserService();

    bool isAdmin = await userService.checkUserAdmin();

    if (isAdmin) {
      final snapshot = await _firestore
          .collection('vouchers')
          .where('userId', isEqualTo: null)
          .get();

      return snapshot.docs.map((doc) => Voucher.fromJson(doc.data())).toList();
    } else {
      if (userId != null) {
        final snapshot = await _firestore
            .collection('vouchers')
            .where('userId', isEqualTo: userId)
            .get();

        return snapshot.docs
            .map((doc) => Voucher.fromJson(doc.data()))
            .toList();
      } else {
        throw Exception('Usuário não autenticado');
      }
    }
  }

  Future<void> updateVoucher(String voucherId, Voucher voucher) async {
    try {
      await _firestore
          .collection('vouchers')
          .doc(voucherId)
          .update(voucher.toJson());
    } catch (e) {
      throw Exception('Erro ao atualizar voucher: $e');
    }
  }

  Future<void> deleteVoucher(String voucherId) async {
    try {
      await _firestore.collection('vouchers').doc(voucherId).delete();
    } catch (e) {
      throw Exception('Erro ao excluir voucher: $e');
    }
  }
}
