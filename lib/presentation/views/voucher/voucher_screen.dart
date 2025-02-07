import 'package:feriasjeri_app/presentation/controllers/voucher_controller.dart';
import 'package:flutter/material.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_icon_button.dart';
import 'package:feriasjeri_app/presentation/views/voucher/widgets/voucher_widget.dart';
import 'package:feriasjeri_app/data/models/voucher.dart';
import 'package:get/get.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Voucher voucher = Get.arguments as Voucher;

    final VoucherController voucherController = Get.put(VoucherController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              icon: Icons.arrow_back,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text(
              'Voucher',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Obx(() {
                  return voucherController.isLoading.value
                      ? const CircularProgressIndicator()
                      : CustomIconButton(
                          icon: Icons.share,
                          onPressed: () {
                            voucherController
                                .generateAndDownloadVoucherPdf(voucher);
                          },
                        );
                }),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 75),
              Expanded(
                child: VoucherWidget(voucher: voucher),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Obx(() {
                  return voucherController.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton.icon(
                          onPressed: () {
                            voucherController
                                .generateAndDownloadVoucherPdf(voucher);
                          },
                          icon: const Icon(Icons.download),
                          label: const Text("Download"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(
                              double.infinity,
                              48,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
