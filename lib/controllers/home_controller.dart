import 'package:feriasjeri_app/utils/check_admin.dart';
import 'package:feriasjeri_app/views/create_voucher_screen.dart';
import 'package:feriasjeri_app/views/login_screen.dart';
import 'package:feriasjeri_app/widgets/bar_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isAdmin = false.obs;
  var modalHeight = 0.75.obs;
  var voucherListOffset = (-20).obs;

  Future<void> checkAdminStatus() async {
    final adminStatus = await checkAdmin();
    isAdmin.value = adminStatus;
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    modalHeight.value -= details.primaryDelta! / Get.mediaQuery.size.height;
    modalHeight.value = modalHeight.value.clamp(0.4, 1);
    voucherListOffset.value = modalHeight.value > 0.75 ? 0 : -20;
  }

  void onVerticalDragEnd(DragEndDetails details) {
    if (modalHeight.value > 0.75) {
      modalHeight.value = 1;
      voucherListOffset.value = 0;
    } else {
      modalHeight.value = 0.75;
      voucherListOffset.value = -20;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const LoginScreen());
  }

  void openSlidingModal() {
    showBarModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return const CreateVoucherScreen();
      },
    );
  }
}
