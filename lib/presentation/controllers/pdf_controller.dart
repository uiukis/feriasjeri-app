import 'package:get/get.dart';
import 'package:feriasjeri_app/data/models/voucher.dart';
import 'package:feriasjeri_app/data/repositories/pdf_repository.dart';

class PdfController extends GetxController {
  final PdfRepository pdfRepository = PdfRepository();

  Future<void> generateAndDownloadPdf(Voucher voucher) async {
    try {
      await pdfRepository.downloadPdf(voucher);
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possível gerar o PDF');
    }
  }
}
