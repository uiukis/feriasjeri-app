import 'package:feriasjeri_app/presentation/controllers/pdf_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:feriasjeri_app/data/models/voucher.dart';
import 'package:feriasjeri_app/data/repositories/voucher_repository.dart';

class VoucherController extends GetxController
    with GetTickerProviderStateMixin {
  var vouchers = <Voucher>[];
  RxBool isLoading = false.obs;
  var searchQuery = "".obs;
  var animationControllers = <Rx<AnimationController>>[].obs;

  final VoucherRepository voucherRepository = VoucherRepository();

  final PdfController pdfController = Get.find<PdfController>();

  @override
  void onInit() {
    super.onInit();
    fetchVouchers();
  }

  Future<void> fetchVouchers() async {
    isLoading(true);
    try {
      vouchers = await voucherRepository.fetchVouchers();
      initializeAnimationControllers(vouchers.length);
    } catch (e) {
      debugPrint("Error fetching vouchers: $e");
    } finally {
      isLoading(false);
    }
  }

  void initializeAnimationControllers(int length) {
    animationControllers.clear();
    animationControllers.addAll(List.generate(
      length,
      (index) {
        final controller = AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        );
        Future.delayed(Duration(milliseconds: 100 * index), () {
          controller.forward();
        });
        return Rx<AnimationController>(controller);
      },
    ));
  }

  List<Voucher> get filteredVouchers {
    return vouchers
        .where((voucher) =>
            voucher.tour
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            voucher.time
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  Future<void> generateAndDownloadVoucherPdf(Voucher voucher) async {
    try {
      isLoading.value = true;
      await pdfController.generateAndDownloadPdf(voucher);
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possível gerar o PDF');
    } finally {
      isLoading.value = false;
    }
  }
}
