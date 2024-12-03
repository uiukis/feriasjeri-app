import 'package:flutter/material.dart';
import 'package:feriasjeri_app/models/voucher.dart';
import 'expandable.dart';
import 'package:intl/intl.dart';

class VoucherCard extends StatelessWidget {
  final Voucher voucher;

  const VoucherCard({
    super.key,
    required this.voucher,
  });

  @override
  Widget build(BuildContext context) {
    final startDate =
        DateFormat('dd/MM/yyyy').format(voucher.startDate.toDate());
    final endDate = DateFormat('dd/MM/yyyy').format(voucher.endDate.toDate());

    return Expandable(
      width: MediaQuery.sizeOf(context).width * .5,
      closedHeight: MediaQuery.sizeOf(context).height * .1,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            voucher.tour.toUpperCase(),
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Row(
            children: [
              const Icon(Icons.date_range, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                '$startDate - $endDate',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.access_time, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                voucher.time,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.people, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Adultos: ${voucher.adult} | Crianças: ${voucher.child ?? 0}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.attach_money, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Pago: R\$ ${voucher.partialValue.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                voucher.boardingValue != 0
                    ? Text(
                        ' | Pagar no embarque: R\$ ${voucher.boardingValue?.toStringAsFixed(2)} ',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.money, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Valor Total: R\$ ${voucher.totalValue.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.notes, size: 16, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Observações: ${voucher.obs}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollable: true,
    );
  }
}
