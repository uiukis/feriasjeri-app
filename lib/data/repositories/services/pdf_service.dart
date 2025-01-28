// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:feriasjeri_app/data/models/voucher.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

  Future<Uint8List> generatePdf(Voucher voucher) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(16.0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Voucher',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Passeio: ${voucher.tour}',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Data de Início: ${dateFormatter.format(voucher.startDate.toDate())}',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Data de Término: ${dateFormatter.format(voucher.endDate.toDate())}',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Horário de Embarque: ${voucher.time}',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Informações do Cliente',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Nome: ${voucher.name}',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Telefone: ${voucher.phone}',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Local de Embarque: ${voucher.boarding}',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Detalhes da Reserva',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Adultos: ${voucher.adult}',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Crianças: ${voucher.child ?? 0}',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Valor Parcial: R\$ ${voucher.partialValue.toStringAsFixed(2)}',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Valor do Embarque: R\$ ${voucher.boardingValue?.toStringAsFixed(2) ?? '0.00'}',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.Text(
                  'Valor Total: R\$ ${voucher.totalValue.toStringAsFixed(2)}',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Observações',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                voucher.obs!.isNotEmpty
                    ? pw.Text(
                        voucher.obs!,
                        style: const pw.TextStyle(fontSize: 16),
                      )
                    : pw.Text(
                        'Nenhuma observação fornecida.',
                        style: const pw.TextStyle(fontSize: 16),
                      ),
              ],
            ),
          );
        },
      ),
    );

    return await pdf.save();
  }

  Future<void> downloadPdf(Voucher voucher) async {
    try {
      final pdfBytes = await generatePdf(voucher);

      final blob = html.Blob([pdfBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..target = 'blank'
        ..download = 'voucher.pdf'
        ..click();

      html.Url.revokeObjectUrl(url);
    } catch (e) {
      throw Exception('Erro ao salvar o PDF: $e');
    }
  }
}
