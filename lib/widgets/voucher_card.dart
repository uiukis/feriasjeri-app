import 'package:flutter/material.dart';
import 'package:feriasjeri_app/models/voucher.dart';
import 'expandable.dart';
import 'package:intl/intl.dart';

class VoucherCard extends StatefulWidget {
  final Voucher voucher;

  const VoucherCard({
    super.key,
    required this.voucher,
  });

  @override
  VoucherCardState createState() => VoucherCardState();
}

class VoucherCardState extends State<VoucherCard> {
  final GlobalKey _contentKey = GlobalKey();

  double getOpenedHeight() {
    if (widget.voucher.obs!.isEmpty && widget.voucher.boardingValue == 0) {
      return 270;
    }
    if (widget.voucher.obs!.isNotEmpty && widget.voucher.boardingValue != 0) {
      return 320;
    }
    return 300;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final startDate =
        DateFormat('dd/MM/yyyy').format(widget.voucher.startDate.toDate());
    final endDate =
        DateFormat('dd/MM/yyyy').format(widget.voucher.endDate.toDate());

    return Expandable(
      closedHeight: 100,
      openedHeight: getOpenedHeight(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.voucher.tour.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.date_range,
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                '$startDate - $endDate',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.access_time,
                size: 16,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              Text(
                widget.voucher.time,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
      content: SingleChildScrollView(
        key: _contentKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.people,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Adultos: ${widget.voucher.adult} | Crianças: ${widget.voucher.child ?? 0}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(
                  Icons.money_off,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Pago: R\$ ${widget.voucher.partialValue.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: widget.voucher.boardingValue != 0 ? 8 : 0,
            ),
            widget.voucher.boardingValue != 0
                ? Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Pagar no embarque: R\$ ${widget.voucher.boardingValue?.toStringAsFixed(2)} ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(
                  Icons.money,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Valor Total: R\$ ${widget.voucher.totalValue.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            widget.voucher.obs!.isNotEmpty
                ? Row(
                    children: [
                      const Icon(
                        Icons.notes,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Observações: ${widget.voucher.obs}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 8,
            ),
            FloatingActionButton.extended(
              label: const Text("Gerar voucher"),
              onPressed: () => {},
            )
          ],
        ),
      ),
      isScrollable: true,
    );
  }
}
