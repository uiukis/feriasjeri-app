import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:feriasjeri_app/models/voucher.dart';

class VoucherWidget extends StatelessWidget {
  final Voucher voucher;

  const VoucherWidget({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: VoucherTopClipper(),
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
            Expanded(
              flex: 7,
              child: ClipPath(
                clipper: VoucherTopClipper(),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            voucher.tour.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Data Início",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(voucher.startDate.toDate()),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text("Data Fim",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14)),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(voucher.endDate.toDate()),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        _infoRow("Adultos",
                            '${voucher.adult} | Crianças: ${voucher.child ?? 0}'),
                        _infoRow("Pago",
                            'R\$ ${voucher.partialValue.toStringAsFixed(2)}'),
                        if (voucher.boardingValue != 0)
                          _infoRow("Pagar no embarque",
                              'R\$ ${voucher.boardingValue?.toStringAsFixed(2)}'),
                        _infoRow("Valor Total",
                            'R\$ ${voucher.totalValue.toStringAsFixed(2)}'),
                        if (voucher.obs!.isNotEmpty)
                          _infoRow("Observações", voucher.obs!),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ClipPath(
                clipper: VoucherBottomClipper(),
                child: Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: const Text("Fechar"),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class VoucherTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);
    path.arcToPoint(
      Offset(20, size.height),
      radius: const Radius.circular(20),
      clockwise: true,
    );
    path.lineTo(size.width - 20, size.height);
    path.arcToPoint(
      Offset(size.width, size.height - 20),
      radius: const Radius.circular(20),
      clockwise: true,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class VoucherBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 20);
    path.arcToPoint(
      const Offset(20, 0),
      radius: const Radius.circular(20),
      clockwise: false,
    );
    path.lineTo(size.width - 20, 0);
    path.arcToPoint(
      Offset(size.width, 20),
      radius: const Radius.circular(20),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
