import 'package:feriasjeri_app/models/voucher.dart';
import 'package:feriasjeri_app/services/voucher_service.dart';
import 'package:feriasjeri_app/utils/check_admin.dart';
import 'package:feriasjeri_app/widgets/voucher_card.dart';
import 'package:flutter/material.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({
    super.key,
  });

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList>
    with TickerProviderStateMixin {
  bool isAdmin = false;

  final VoucherService voucherService = VoucherService();
  late List<AnimationController> _animationControllers;

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
    return StreamBuilder<List<Voucher>>(
      stream: voucherService.fetchVouchers(isAdmin),
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

        _animationControllers = List.generate(
          vouchers.length,
          (index) {
            final controller = AnimationController(
              duration: const Duration(milliseconds: 500),
              vsync: this,
            );

            Future.delayed(Duration(milliseconds: 100 * index), () {
              controller.forward();
            });

            return controller;
          },
        );

        return ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: vouchers.length,
          itemBuilder: (context, index) {
            final animation = Tween<Offset>(
              begin: const Offset(-1.0, 0), 
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: _animationControllers[index],
                curve: Curves.easeInOut,
              ),
            );

            return SlideTransition(
              position: animation,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: VoucherCard(voucher: vouchers[index]),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
