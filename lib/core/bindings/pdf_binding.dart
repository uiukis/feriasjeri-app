import 'package:get/get.dart';
import 'package:feriasjeri_app/data/repositories/pdf_repository.dart';
import 'package:feriasjeri_app/presentation/controllers/pdf_controller.dart';

class PdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PdfRepository());
    Get.put(PdfController());
  }
}
