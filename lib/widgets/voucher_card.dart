import 'package:feriasjeri_app/models/voucher.dart';
import 'package:flutter/material.dart';

class VoucherCard extends StatelessWidget {
  final Voucher voucher;

  const VoucherCard({
    super.key,
    required this.voucher,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.tour, color: Colors.blue, size: 28),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    voucher.tour,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            _buildDetailRow(Icons.person, 'Nome', voucher.name),
            const SizedBox(height: 4.0),
            _buildDetailRow(Icons.phone, 'Telefone', voucher.phone),
            const SizedBox(height: 4.0),
            _buildDetailRow(Icons.location_on, 'Embarque', voucher.boarding),
            const SizedBox(height: 4.0),
            _buildDetailRow(Icons.people, 'ADTs', voucher.adts),
            if (voucher.obs.isNotEmpty)
              Column(
                children: [
                  const SizedBox(height: 8.0),
                  _buildDetailRow(Icons.note, 'Observação', voucher.obs),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(width: 8.0),
        Text(
          '$label: ',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black54),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
