import 'package:feriasjeri_app/data/models/voucher.dart';
import 'package:flutter/material.dart';
import 'package:feriasjeri_app/data/repositories/services/pdf_service.dart';

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
