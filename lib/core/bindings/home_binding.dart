import 'package:feriasjeri_app/data/repositories/pdf_repository.dart';
import 'package:feriasjeri_app/presentation/controllers/pdf_controller.dart';
import 'package:feriasjeri_app/presentation/controllers/voucher_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PdfRepository());
    Get.put(PdfController());

    Get.put(VoucherController());
  }
}
