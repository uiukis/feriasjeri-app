import 'package:feriasjeri_app/views/create_voucher_screen.dart';
import 'package:feriasjeri_app/views/login_screen.dart';
import 'package:feriasjeri_app/widgets/bar_bottom_sheet.dart';
import 'package:feriasjeri_app/widgets/custom_icon_button.dart';
import 'package:feriasjeri_app/widgets/advanced_expandable_card.dart';
import 'package:feriasjeri_app/widgets/voucher_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _appBarColor = Colors.transparent;
  BorderRadiusGeometry _modalBorderRadius = const BorderRadius.vertical(
    top: Radius.circular(16),
  );
  double _zoomFactor = 1;

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

  void _updateOffset(double offset) {
    double maxOffset = 25;
    double progress = (offset / maxOffset).clamp(0.0, 1.0);
    setState(() {
      _appBarColor = Color.lerp(
        Colors.transparent,
        Colors.grey.shade300,
        progress,
      )!;
      _zoomFactor = 1 + (progress * 0.1);
    });

    if (offset > 10 && _modalBorderRadius != BorderRadius.zero) {
      setState(() {
        _modalBorderRadius = BorderRadius.zero;
      });
    } else if (offset <= 10 &&
        _modalBorderRadius !=
            const BorderRadius.vertical(top: Radius.circular(16))) {
      setState(() {
        _modalBorderRadius = const BorderRadius.vertical(
          top: Radius.circular(16),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBarHeight = 80 + mediaQuery.padding.top;
    final maxModalHeightFactor =
        (mediaQuery.size.height - appBarHeight) / mediaQuery.size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: _appBarColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: appBarHeight,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              icon: Icons.menu,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const Text(
              'Vouchers',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
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
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.6,
              child: AnimatedScale(
                scale: _zoomFactor,
                duration: const Duration(milliseconds: 400),
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
          DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.75,
            maxChildSize: maxModalHeightFactor,
            builder: (context, scrollController) {
              scrollController.addListener(() {
                // debugPrint("Scroll offset: ${scrollController.offset}");
                _updateOffset(scrollController.offset);
              });

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: _modalBorderRadius,
                ),
                child: VoucherList(
                  scrollController: scrollController,
                ),
              );
            },
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
