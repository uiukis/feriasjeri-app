import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feriasjeri_app/presentation/shared/components/animated_screen.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_date_picker.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_time_picker.dart';
import 'package:feriasjeri_app/presentation/shared/components/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:feriasjeri_app/data/models/voucher.dart';
import 'package:feriasjeri_app/data/repositories/voucher_repository.dart';
import 'package:intl/intl.dart';

class CreateVoucherController extends GetxController {
  final pageController = PageController();
  final currentStep = 0.obs;

  final tourController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final boardingController = TextEditingController();
  final timeController = TextEditingController();
  final adultController = TextEditingController();
  final childController = TextEditingController();
  final partialValueController = TextEditingController();
  final boardingValueController = TextEditingController();
  final obsController = TextEditingController();

  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().add(const Duration(days: 2)).obs;
  Rx<TimeOfDay> initialTime = TimeOfDay.now().obs;

  final RxString tour = '-'.obs;
  final RxString name = '-'.obs;
  final RxString phone = '-'.obs;
  final RxString boarding = '-'.obs;

  final RxInt adult = 0.obs;
  final RxInt child = 0.obs;

  final RxDouble totalValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    tourController.addListener(() => tour.value = tourController.text);
    nameController.addListener(() => name.value = nameController.text);
    phoneController.addListener(() => phone.value = phoneController.text);
    boardingController
        .addListener(() => boarding.value = boardingController.text);

    adultController.addListener(
        () => adult.value = int.tryParse(adultController.text) ?? 0);
    childController.addListener(
        () => child.value = int.tryParse(childController.text) ?? 0);

    partialValueController.addListener(updateTotalValue);
    boardingValueController.addListener(updateTotalValue);
  }

  void nextStep() {
    if (currentStep.value < 3) {
      currentStep.value++;
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void openDatePicker() async {
    try {
      final selectedDates = await showFloatingModalBottomSheet<List<DateTime>>(
        context: Get.context!,
        builder: (context) {
          return CustomDatePicker(
            startDate: startDate.value,
            endDate: endDate.value,
          );
        },
        slideDirection: const Offset(0, -1),
      );

      if (selectedDates.isNotEmpty) {
        startDate.value = selectedDates[0];

        if (selectedDates.length > 1) {
          endDate.value = selectedDates[1];
        } else {
          endDate.value = startDate.value.add(const Duration(days: 2));
        }
        nextStep();
      }
    } catch (e) {
      return;
    }
  }

  void openTimePicker() async {
    try {
      final selectedTime = await showFloatingModalBottomSheet<TimeOfDay>(
        context: Get.context!,
        builder: (context) {
          return AnimatedScreen(
            child: CustomTimePicker(
              selectedTime: initialTime,
            ),
          );
        },
        slideDirection: const Offset(0, -1),
      );

      initialTime.value = selectedTime;

      timeController.text = selectedTime.format(Get.context!);
    } catch (e) {
      return;
    }
  }

  void updateTotalValue() {
    final double partialValue = double.parse(partialValueController.text);
    final double boardingValue = double.parse(boardingValueController.text);
    totalValue.value = partialValue + boardingValue;
  }

  String get formattedStartDate {
    return DateFormat('dd/MM/yyyy').format(startDate.value);
  }

  String get formattedEndDate {
    return DateFormat('dd/MM/yyyy').format(endDate.value);
  }

  String get formattedTime {
    return '${initialTime.value.hour.toString().padLeft(2, '0')}:${initialTime.value.minute.toString().padLeft(2, '0')}';
  }

  String? validateCurrentStep() {
    switch (currentStep.value) {
      case 0:
        if (tourController.text.isEmpty) {
          return "Informe o nome do passeio";
        }
        if (formattedStartDate.isEmpty || formattedEndDate.isEmpty) {
          return "Selecione uma data válida";
        }
        break;
      case 1:
        if (nameController.text.isEmpty) {
          return "Informe o nome do cliente";
        }
        if (phoneController.text.isEmpty) {
          return "Informe o telefone";
        }
        if (adultController.text.isEmpty ||
            int.tryParse(adultController.text) == null) {
          return "Informe o número de adultos corretamente";
        }
        break;
      case 2:
        if (boardingController.text.isEmpty) {
          return "Informe o local de embarque";
        }
        if (timeController.text.isEmpty) {
          return "Selecione o horário de embarque";
        }
        break;
    }
    return null;
  }

  String? validateFields() {
    if (tourController.text.isEmpty) {
      return 'O campo "Nome do Passeio" é obrigatório.';
    }

    if (nameController.text.isEmpty) {
      return 'O campo "Nome do Cliente" é obrigatório.';
    }

    if (phoneController.text.isEmpty) {
      return 'O campo "Telefone" é obrigatório.';
    }

    if (boardingController.text.isEmpty) {
      return 'O campo "Local de Embarque" é obrigatório.';
    }

    if (timeController.text.isEmpty) {
      return 'O campo "Horário" é obrigatório.';
    }

    if (adultController.text.isEmpty ||
        int.tryParse(adultController.text) == null) {
      return 'O campo "Adultos" deve conter um número válido.';
    }

    if (partialValueController.text.isEmpty ||
        double.tryParse(partialValueController.text) == null) {
      return 'O campo "Valor Parcial" deve conter um valor válido.';
    }

    if (boardingValueController.text.isNotEmpty &&
        double.tryParse(boardingValueController.text) == null) {
      return 'O campo "Valor do Embarque" deve conter um valor válido.';
    }

    return null;
  }

  void saveVoucher() async {
    try {
      final validationError = validateFields();
      if (validationError != null) {
        Get.snackbar(
          'Erro',
          validationError,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final voucher = Voucher(
        tour: tourController.text,
        startDate: Timestamp.fromDate(startDate.value),
        endDate: Timestamp.fromDate(endDate.value),
        name: nameController.text,
        phone: phoneController.text,
        boarding: boardingController.text,
        time: timeController.text,
        adult: int.tryParse(adultController.text) ?? 0,
        child: int.tryParse(childController.text) ?? 0,
        partialValue: double.tryParse(partialValueController.text) ?? 0.0,
        boardingValue: double.tryParse(boardingValueController.text) ?? 0.0,
        totalValue: totalValue.value,
        obs: obsController.text.isEmpty ? "" : obsController.text,
      );

      await VoucherRepository().saveVoucher(voucher);

      Get.snackbar(
        'Sucesso',
        'Voucher criado com sucesso!',
        snackPosition: SnackPosition.BOTTOM,
      );

      Navigator.pop(Get.context!);
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Ocorreu um erro ao salvar o voucher. Por favor, tente novamente.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
