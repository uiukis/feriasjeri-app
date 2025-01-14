import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:feriasjeri_app/models/voucher.dart';

class VoucherWidget extends StatelessWidget {
  final Voucher voucher;

  const VoucherWidget({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    color: Colors.blue.shade50,
                  ),
                  child: Text(
                    voucher.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _infoRow(
                            CrossAxisAlignment.start,
                            "Data de Entrada",
                            DateFormat('dd/MM/yyyy').format(
                              voucher.startDate.toDate(),
                            ),
                          ),
                          _infoRow(
                            CrossAxisAlignment.center,
                            "Horário",
                            voucher.time,
                          ),
                          _infoRow(
                            CrossAxisAlignment.end,
                            "Data de Saída",
                            DateFormat('dd/MM/yyyy').format(
                              voucher.endDate.toDate(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _infoRow(CrossAxisAlignment.start, "Pago",
                              'R\$ ${voucher.partialValue.toStringAsFixed(2)}'),
                          if (voucher.boardingValue != 0)
                            _infoRow(
                                CrossAxisAlignment.center,
                                "Pagar no embarque",
                                'R\$ ${voucher.boardingValue?.toStringAsFixed(2)}'),
                          _infoRow(CrossAxisAlignment.end, "Valor Total",
                              'R\$ ${voucher.totalValue.toStringAsFixed(2)}'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _infoRow(CrossAxisAlignment.start, "Adultos",
                              '${voucher.adult}'),
                          if (voucher.child != 0)
                            _infoRow(CrossAxisAlignment.end, "Crianças",
                                '${voucher.child}'),
                        ],
                      ),
                      if (voucher.obs!.isNotEmpty)
                        _infoRow(CrossAxisAlignment.start, "Observações",
                            voucher.obs!),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
      ],
    );
  }

  Widget _infoRow(CrossAxisAlignment alignment, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
