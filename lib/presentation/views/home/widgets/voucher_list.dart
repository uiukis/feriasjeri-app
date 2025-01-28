import 'package:feriasjeri_app/controllers/voucher_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:feriasjeri_app/data/models/voucher.dart';
import 'package:feriasjeri_app/presentation/shared/components/expandable_card.dart';
import 'package:feriasjeri_app/presentation/views/voucher/voucher_screen.dart';
import 'package:intl/intl.dart';

class VoucherList extends StatelessWidget {
  final ScrollController scrollController;

  const VoucherList({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final VoucherController controller = Get.put(VoucherController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.vouchers.isEmpty) {
        return const Center(child: Text('Nenhum voucher disponível.'));
      }

      if (controller.filteredVouchers.isEmpty) {
        return const Center(child: Text('Nenhum voucher encontrado.'));
      }

      return ListView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        itemCount: controller.filteredVouchers.length,
        itemBuilder: (context, index) {
          final voucher = controller.filteredVouchers[index];

          final animation = Tween<Offset>(
            begin: const Offset(-1.0, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: controller.animationControllers[index].value,
              curve: Curves.easeInOut,
            ),
          );

          return SlideTransition(
            position: animation,
            child: _VoucherCard(voucher: voucher),
          );
        },
      );
    });
  }
}

class _VoucherCard extends StatelessWidget {
  final Voucher voucher;

  const _VoucherCard({required this.voucher});

  double getOpenedHeight() {
    if (voucher.boardingValue == 0) {
      return 270;
    }
    return 300;
  }

  void navigateToVoucherScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VoucherScreen(voucher: voucher),
      ),
    );
  }

  Widget subtitleDisplay(IconData icon, String text) {
    return Row(
      children: [
        const Icon(
          Icons.date_range,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget contentDisplay(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final startDate =
        DateFormat('dd/MM/yyyy').format(voucher.startDate.toDate());
    final endDate = DateFormat('dd/MM/yyyy').format(voucher.endDate.toDate());

    return ExpandableCard(
      openedHeight: getOpenedHeight(),
      closedHeight: 100,
      title: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            voucher.tour.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              subtitleDisplay(
                Icons.date_range,
                '$startDate - $endDate',
              ),
              const SizedBox(width: 8),
              subtitleDisplay(
                Icons.access_time,
                voucher.time,
              ),
            ],
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  contentDisplay(
                    Icons.people,
                    'Adultos: ${voucher.adult} | Crianças: ${voucher.child ?? 0}',
                  ),
                  const SizedBox(height: 8),
                  contentDisplay(
                    Icons.money_off,
                    'Pago: R\$ ${voucher.partialValue.toStringAsFixed(2)}',
                  ),
                  SizedBox(
                    height: voucher.boardingValue != 0 ? 8 : 0,
                  ),
                  voucher.boardingValue != 0
                      ? contentDisplay(
                          Icons.attach_money,
                          'Pagar no embarque: R\$ ${voucher.boardingValue?.toStringAsFixed(2)} ',
                        )
                      : const SizedBox(),
                  const SizedBox(height: 8),
                  contentDisplay(
                    Icons.money,
                    'Valor Total: R\$ ${voucher.totalValue.toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: '${voucher.tour}_${voucher.startDate}_${voucher.endDate}',
            label: const Text(
              "Visualizar voucher",
            ),
            onPressed: () => navigateToVoucherScreen(context),
          )
        ],
      ),
    );
  }
}
