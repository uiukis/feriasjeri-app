import 'package:feriasjeri_app/widgets/voucher_widget.dart';
import 'package:flutter/material.dart';
import 'package:feriasjeri_app/models/voucher.dart';

class VoucherScreen extends StatelessWidget {
  final Voucher voucher;

  const VoucherScreen({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Expanded(
                child: VoucherWidget(voucher: voucher),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
