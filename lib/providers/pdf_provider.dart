import 'package:feriasjeri_app/models/voucher.dart';
import 'package:flutter/material.dart';
import 'package:feriasjeri_app/services/pdf_services.dart';

class PdfProvider extends ChangeNotifier {
  final PdfService _pdfService = PdfService();
  bool isLoading = false;

  Future<void> generatePdf(Voucher voucher) async {
    _setLoading(true);
    try {
      await _pdfService.generatePdf(voucher);
    } catch (e) {
      debugPrint('Erro ao baixar PDF: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
