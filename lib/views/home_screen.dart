import 'package:feriasjeri_app/utils/check_admin.dart';
import 'package:feriasjeri_app/views/login_screen.dart';
import 'package:feriasjeri_app/views/create_voucher_screen.dart';
import 'package:feriasjeri_app/widgets/bar_bottom_sheet.dart';
import 'package:feriasjeri_app/widgets/voucher_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    showBarModalBottomSheet(
      context: context,
      builder: (context) {
        return const CreateVoucherScreen();
      },
    );
  }

  Future<void> _checkIfAdmin() async {
    final adminStatus = await checkAdmin();
    setState(() {
      isAdmin = adminStatus;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkIfAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bem-vindo!')),
      body: VoucherList(isAdmin: isAdmin),
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
