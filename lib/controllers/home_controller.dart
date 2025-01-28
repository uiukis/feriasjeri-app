import 'package:feriasjeri_app/controllers/voucher_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final advancedDrawerController = AdvancedDrawerController();
  final appBarColor = Colors.transparent.obs;
  final modalBorderRadius = Rx<BorderRadiusGeometry>(
    const BorderRadius.vertical(top: Radius.circular(16)),
  );
  final zoomFactor = 1.0.obs;
  final searchQuery = ''.obs;
  final isSearchBarExpanded = false.obs;

  void handleMenuButtonPressed() {
    advancedDrawerController.showDrawer();
  }

  void updateOffset(double offset) {
    const maxOffset = 250;
    final progress = (offset / maxOffset).clamp(0.0, 1.0);

    if (progress == 0.0) {
      appBarColor.value = Colors.transparent;
    } else if (progress == 1.0) {
      appBarColor.value = Colors.grey.shade300;
    } else {
      appBarColor.value = Color.lerp(
        Colors.transparent,
        Colors.grey.shade300,
        progress,
      )!;
    }

    zoomFactor.value = 1 + (progress * 0.1);

    if (offset > 10 && modalBorderRadius.value != BorderRadius.zero) {
      modalBorderRadius.value = BorderRadius.zero;
    } else if (offset <= 10 &&
        modalBorderRadius.value !=
            const BorderRadius.vertical(top: Radius.circular(16))) {
      modalBorderRadius.value = const BorderRadius.vertical(
        top: Radius.circular(16),
      );
    }
  }

  void handleSearchBarExpand(bool isExpanded) {
    if (!isExpanded) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (Get.isRegistered<HomeController>()) {
          isSearchBarExpanded.value = isExpanded;
        }
      });
    } else {
      isSearchBarExpanded.value = isExpanded;
    }
  }

  void onSearch(String value) {
    Get.find<VoucherController>().searchQuery.value = value;
  }
}
