import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:feriasjeri_app/data/repositories/voucher_repository.dart';
import 'package:feriasjeri_app/data/models/voucher.dart';

class VoucherFormProvider with ChangeNotifier {
  TextEditingController tourController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController boardingController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController adultController = TextEditingController();
  TextEditingController childController = TextEditingController();
  TextEditingController partialValueController = TextEditingController();
  TextEditingController boardingValueController = TextEditingController();
  TextEditingController totalValueController = TextEditingController();
  TextEditingController obsController = TextEditingController();

  late DateTime startDate;
  late DateTime endDate;

  final VoucherRepository voucherRepository = VoucherRepository();

  bool isLoading = false;

  String? tourError,
      nameError,
      phoneError,
      boardingError,
      timeError,
      adultError,
      partialValueError;

  void initForm() {
    startDate = DateTime.now();
    endDate = startDate.add(const Duration(days: 2));

    partialValueController.addListener(calculateTotalValue);
    boardingValueController.addListener(calculateTotalValue);
  }

  void setStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
  }

  void setTime(String time) {
    timeController.text = time;
    notifyListeners();
  }

  void calculateTotalValue() {
    final partialValue = double.tryParse(partialValueController.text) ?? 0.0;
    final boardingValue = double.tryParse(boardingValueController.text) ?? 0.0;
    final totalValue = partialValue + boardingValue;
    totalValueController.text = totalValue.toStringAsFixed(2);
    notifyListeners();
  }

  void validateFields() {
    tourError = null;
    nameError = null;
    phoneError = null;
    boardingError = null;
    timeError = null;
    adultError = null;
    partialValueError = null;

    if (tourController.text.isEmpty) {
      tourError = 'Campo obrigatório';
    }
    if (nameController.text.isEmpty) {
      nameError = 'Campo obrigatório';
    }
    if (phoneController.text.isEmpty) {
      phoneError = 'Campo obrigatório';
    }
    if (boardingController.text.isEmpty) {
      boardingError = 'Campo obrigatório';
    }
    if (timeController.text.isEmpty) {
      timeError = 'Campo obrigatório';
    }
    if (adultController.text.isEmpty) {
      adultError = 'Campo obrigatório';
    }
    if (partialValueController.text.isEmpty) {
      partialValueError = 'Campo obrigatório';
    }

    if (int.tryParse(adultController.text) == null) {
      adultError = 'Insira um número válido';
    }
    if (double.tryParse(partialValueController.text) == null) {
      partialValueError = 'Insira um valor válido';
    }

    notifyListeners();
  }

  Future<void> saveVoucher(BuildContext context) async {
    validateFields();

    if (tourError != null ||
        nameError != null ||
        phoneError != null ||
        boardingError != null ||
        timeError != null ||
        adultError != null ||
        partialValueError != null) {
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      final voucher = Voucher(
        tour: tourController.text,
        startDate: Timestamp.fromDate(startDate),
        endDate: Timestamp.fromDate(endDate),
        name: nameController.text,
        phone: phoneController.text,
        boarding: boardingController.text,
        time: timeController.text,
        adult: int.parse(adultController.text),
        child:
            childController.text.isEmpty ? 0 : int.parse(childController.text),
        partialValue: double.parse(partialValueController.text),
        boardingValue: boardingValueController.text.isEmpty
            ? 0.0
            : double.parse(boardingValueController.text),
        totalValue: double.parse(totalValueController.text),
        obs: obsController.text.isEmpty ? "" : obsController.text,
      );

      await voucherRepository.saveVoucher(voucher);
      await Future.delayed(const Duration(seconds: 2));
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      resetForm();
    } catch (e) {
      debugPrint('Erro ao salvar voucher: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void resetForm() {
    tourController.clear();
    nameController.clear();
    phoneController.clear();
    boardingController.clear();
    timeController.clear();
    adultController.clear();
    childController.clear();
    partialValueController.clear();
    boardingValueController.clear();
    totalValueController.clear();
    obsController.clear();
  }
}
