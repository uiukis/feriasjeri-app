import 'package:feriasjeri_app/core/utils/mask_utils.dart';
import 'package:feriasjeri_app/presentation/controllers/create_voucher_controller.dart';
import 'package:feriasjeri_app/presentation/shared/components/animated_screen.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_clickable_tile.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateVoucherScreen extends StatelessWidget {
  final controller = Get.put(CreateVoucherController());

  CreateVoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedScreen(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) =>
                      controller.currentStep.value = index,
                  children: [
                    buildStep1(context),
                    buildStep2(context),
                    buildStep3(context),
                    buildStep4(context),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => AnimatedOpacity(
                        opacity: controller.currentStep.value == 0 ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: FloatingActionButton(
                          heroTag: controller.currentStep.value,
                          onPressed: controller.previousStep,
                          child: const Icon(Icons.arrow_back),
                        ),
                      )),
                  Obx(
                    () => FloatingActionButton(
                      onPressed: () {
                        final error = controller.validateCurrentStep();
                        if (error != null) {
                          Get.snackbar("Atenção", error,
                              snackPosition: SnackPosition.BOTTOM);
                          return;
                        }

                        if (controller.currentStep.value == 3) {
                          controller.saveVoucher();
                        } else {
                          controller.nextStep();
                        }
                      },
                      child: controller.currentStep.value == 3
                          ? const Icon(Icons.check)
                          : const Icon(Icons.arrow_forward),
                    ),
                  )
                ],
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      final isActive = controller.currentStep.value == index;
                      return AnimatedContainer(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isActive ? 40 : 20,
                        height: 10,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: isActive ? Colors.grey : Colors.grey.shade300,
                        ),
                      );
                    }),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStep1(BuildContext context) {
    return stepWidget(
      Icons.explore,
      'Vamos começar!',
      'Informe os detalhes do passeio e selecione a data de início e data de conclusão.',
      [
        CustomInputField(
          controller: controller.tourController,
          label: 'Nome do Passeio',
        ),
        const SizedBox(height: 16),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: CustomClickableTile(
                  onTap: controller.openDatePicker,
                  text: controller.formattedStartDate,
                ),
              ),
              const SizedBox(width: 8),
              const Text('-'),
              const SizedBox(width: 8),
              Expanded(
                child: CustomClickableTile(
                  onTap: controller.openDatePicker,
                  text: controller.formattedEndDate,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildStep2(BuildContext context) {
    return stepWidget(
      Icons.person,
      'Quem vai viajar?',
      'Informe os dados do cliente e o número de adultos e crianças.',
      [
        CustomInputField(
          controller: controller.nameController,
          label: 'Nome do Cliente',
          // onSubmitted: (_) => controller.nextStep(),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        CustomInputField(
          controller: controller.phoneController,
          label: 'Telefone',
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomInputField(
                controller: controller.adultController,
                label: 'Adultos',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomInputField(
                controller: controller.childController,
                label: 'Crianças',
                keyboardType: TextInputType.number,
                onSubmitted: (_) => controller.nextStep(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStep3(BuildContext context) {
    return stepWidget(
      Icons.directions_bus,
      'Detalhes do Embarque',
      'Informe o local e horário de embarque, além dos valores.',
      [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: CustomInputField(
                controller: controller.boardingController,
                label: 'Local de Embarque',
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(width: 16),
            Obx(
              () => Expanded(
                child: CustomClickableTile(
                  onTap: controller.openTimePicker,
                  text: controller.formattedTime,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomInputField(
                controller: controller.partialValueController,
                label: 'Valor Parcial',
                inputFormatters: [MaskUtils.moneyMask],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(width: 8),
            const Text('+'),
            const SizedBox(width: 8),
            Expanded(
              child: CustomInputField(
                controller: controller.boardingValueController,
                label: 'Valor do Embarque',
                inputFormatters: [MaskUtils.moneyMask],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        CustomInputField(
          controller: controller.obsController,
          label: 'Observação',
          maxLines: 3,
          onSubmitted: (_) => controller.nextStep(),
        ),
      ],
    );
  }

  Widget buildStep4(BuildContext context) {
    return stepWidget(
      Icons.check_circle,
      'Revisão Final',
      'Confira todas as informações antes de salvar o voucher.',
      [
        Obx(() => buildSummaryTile('Nome do Passeio', controller.tour.value)),
        Obx(() => buildSummaryTile('Período',
            '${controller.formattedStartDate} - ${controller.formattedEndDate}')),
        Obx(() => buildSummaryTile('Cliente', controller.name.value)),
        Obx(() => buildSummaryTile('Telefone', controller.phone.value)),
        Obx(() => buildSummaryTile('Passageiros',
            '${controller.adult.value} adultos, ${controller.child.value} crianças')),
        Obx(() => buildSummaryTile('Embarque',
            '${controller.boarding.value} às ${controller.formattedTime}')),
        Obx(() => buildSummaryTile('Valor Total',
            'R\$ ${controller.totalValue.value.toStringAsFixed(2)}')),
      ],
    );
  }

  Widget stepWidget(
    IconData icon,
    String title,
    String description,
    List<Widget> children,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 75),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget buildSummaryTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}
