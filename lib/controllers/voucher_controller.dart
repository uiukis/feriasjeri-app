import 'package:feriasjeri_app/utils/check_admin.dart';
import 'package:get/get.dart';
import 'package:feriasjeri_app/models/voucher.dart';
import 'package:feriasjeri_app/services/voucher_service.dart';

class VoucherController extends GetxController {
  var vouchers = <Voucher>[].obs;
  var isAdmin = false.obs;

  final VoucherService voucherService = VoucherService();

  Future<void> checkIfAdmin() async {
    final adminStatus = await checkAdmin();
    isAdmin.value = adminStatus;
  }

  // void loadVouchers() {
  //   voucherService.fetchVouchers(isAdmin.value).listen((fetchedVouchers) {
  //     vouchers.assignAll(fetchedVouchers);
  //   });
  // }
}
