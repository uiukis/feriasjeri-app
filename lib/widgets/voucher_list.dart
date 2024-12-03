import 'package:feriasjeri_app/models/voucher.dart';
import 'package:feriasjeri_app/services/voucher_service.dart';
import 'package:feriasjeri_app/widgets/voucher_card.dart';
import 'package:flutter/material.dart';

class VoucherList extends StatelessWidget {
  final bool isAdmin;
  final VoucherService voucherService = VoucherService();

  VoucherList({
    super.key,
    required this.isAdmin,
  });

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
        return ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: vouchers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: VoucherCard(voucher: vouchers[index]),
            );
          },
        );
      },
    );
  }
}
