import 'package:feriasjeri_app/views/create_voucher_screen.dart';
import 'package:feriasjeri_app/views/login_screen.dart';
import 'package:feriasjeri_app/widgets/bar_bottom_sheet.dart';
import 'package:feriasjeri_app/widgets/custom_icon_button.dart';
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
  double modalHeight = 0.75;
  double voucherListOffset = -20;

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

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      modalHeight -= details.primaryDelta! / MediaQuery.of(context).size.height;
      modalHeight = modalHeight.clamp(0.4, 1);

      voucherListOffset = modalHeight > 0.75 ? 0 : -20;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      if (modalHeight > 0.75) {
        modalHeight = 1;
        voucherListOffset = 0;
      } else {
        modalHeight = 0.75;
        voucherListOffset = -20;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              icon: Icons.menu,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const SizedBox.shrink(),
            CustomIconButton(
              icon: Icons.search,
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.6,
                child: AnimatedScale(
                  scale: 1 + (modalHeight - 0.65) * 0.2,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onVerticalDragUpdate: _onVerticalDragUpdate,
              onVerticalDragEnd: _onVerticalDragEnd,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: MediaQuery.of(context).size.height * modalHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(modalHeight == 1 ? 0 : 20),
                    topRight: Radius.circular(modalHeight == 1 ? 0 : 20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: const Offset(0, -20),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration:
                          Duration(milliseconds: modalHeight == 1 ? 300 : 600),
                      alignment: modalHeight == 1
                          ? Alignment.topCenter
                          : Alignment.topLeft,
                      child: Padding(
                        padding: modalHeight == 1
                            ? const EdgeInsets.only(top: 25)
                            : const EdgeInsets.only(top: 15, left: 20),
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                          style: TextStyle(
                            fontSize: modalHeight == 1 ? 20 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          child: const Text(
                            'Vouchers',
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      top: voucherListOffset,
                      left: 0,
                      right: 0,
                      child: const VoucherList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openSlidingModal,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
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
