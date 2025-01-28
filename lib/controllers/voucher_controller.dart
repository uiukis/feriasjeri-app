import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:feriasjeri_app/data/models/voucher.dart';
import 'package:feriasjeri_app/data/repositories/services/voucher_service.dart';

class VoucherController extends GetxController
    with GetTickerProviderStateMixin {
  var vouchers = <Voucher>[];
  var isLoading = true.obs;
  var searchQuery = "".obs;
  var animationControllers = <Rx<AnimationController>>[].obs;

  final VoucherService voucherService = VoucherService();

  @override
  void onInit() {
    super.onInit();
    fetchVouchers();
  }

  Future<void> fetchVouchers() async {
    isLoading(true);
    try {
      vouchers = await voucherService.fetchVouchers();
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
}
