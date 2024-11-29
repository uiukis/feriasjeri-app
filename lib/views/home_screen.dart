import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feriasjeri_app/services/voucher_service.dart';
import 'package:feriasjeri_app/utils/check_admin.dart';
import 'package:feriasjeri_app/views/login_screen.dart';
import 'package:feriasjeri_app/views/voucher_screen.dart';
import 'package:feriasjeri_app/widgets/floating_modal.dart';
import 'package:feriasjeri_app/widgets/voucher_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/voucher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VoucherService _voucherService = VoucherService();
  bool isAdmin = false;

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _openSlidingModal() {
    showFloatingModalBottomSheet(
      context: context,
      builder: (context) {
        return const VoucherScreen();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _checkIfAdmin();
  }

  Future<void> _checkIfAdmin() async {
    final adminStatus = await checkAdmin();
    setState(() {
      isAdmin = adminStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bem-vindo!')),
      body: StreamBuilder<List<Voucher>>(
        stream: _voucherService.fetchVouchers(isAdmin),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum voucher encontrado.'));
          }

          final vouchers = snapshot.data!;
          return ListView.builder(
            itemCount: vouchers.length,
            itemBuilder: (context, index) {
              return VoucherCard(voucher: vouchers[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openSlidingModal,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          onPressed: _logout,
          icon: const Icon(Icons.logout),
          label: const Text('Logout'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
