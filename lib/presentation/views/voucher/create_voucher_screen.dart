import 'package:feriasjeri_app/data/repositories/providers/voucher_form_provider.dart';
import 'package:feriasjeri_app/presentation/shared/components/animated_screen.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_clickable_tile.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_date_picker.dart';
import 'package:feriasjeri_app/presentation/shared/components/custom_input_field.dart';
import 'package:feriasjeri_app/presentation/shared/components/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateVoucherScreen extends StatefulWidget {
  const CreateVoucherScreen({super.key});

  @override
  State<CreateVoucherScreen> createState() => _CreateVoucherScreenState();
}

class _CreateVoucherScreenState extends State<CreateVoucherScreen> {
  TimeOfDay initialTime = TimeOfDay.now();

  void _showCalendarModal(BuildContext context) async {
    try {
      final formProvider =
          Provider.of<VoucherFormProvider>(context, listen: false);

      final selectedDates = await showFloatingModalBottomSheet<List<DateTime?>>(
        context: context,
        builder: (BuildContext context) {
          return CustomDatePicker(
            startDate: formProvider.startDate,
            endDate: formProvider.endDate,
          );
        },
        slideDirection: const Offset(0, -1),
      );

      if (selectedDates.isNotEmpty) {
        formProvider.setStartDate(selectedDates[0]!);
        formProvider.setEndDate(selectedDates[1]!);
      }
    } catch (e) {
      debugPrint('Erro ao exibir o modal: $e');
    }
  }

  void _showSelectTime(BuildContext context) async {
    try {
      final formProvider =
          Provider.of<VoucherFormProvider>(context, listen: false);

      final selectedTime = await showFloatingModalBottomSheet<TimeOfDay>(
        context: context,
        builder: (BuildContext context) {
          return AnimatedScreen(
            child: Wrap(
              alignment: WrapAlignment.end,
              children: [
                TimePickerDialog(
                  initialTime: initialTime,
                ),
              ],
            ),
          );
        },
        slideDirection: const Offset(0, -1),
        backgroundColor: Colors.transparent,
      );

      if (mounted) {
        // ignore: use_build_context_synchronously
        final formattedTime = selectedTime.format(context);
        formProvider.setTime(formattedTime);
      }
    } catch (e) {
      debugPrint('Erro ao selecionar o horário: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final voucherProvider = VoucherFormProvider();
        voucherProvider.initForm();
        return voucherProvider;
      },
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Consumer<VoucherFormProvider>(
            builder: (context, formProvider, child) {
              String formattedStartDate =
                  DateFormat('dd/MM/yyyy').format(formProvider.startDate);
              String formattedEndDate =
                  DateFormat('dd/MM/yyyy').format(formProvider.endDate);

              String formattedTime =
                  '${initialTime.hour.toString().padLeft(2, '0')}:${initialTime.minute.toString().padLeft(2, '0')}';

              return Scaffold(
                body: AnimatedScreen(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            ListTile(
                              title: CustomInputField(
                                controller: formProvider.tourController,
                                label: 'Passeio',
                                prefixIcon: Icons.explore,
                                // errorText: formProvider.tourError,
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CustomClickableTile(
                                      onTap: () => _showCalendarModal(context),
                                      prefixIcon: Icons.calendar_today,
                                      text:
                                          '$formattedStartDate - $formattedEndDate',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: CustomClickableTile(
                                      onTap: () => _showSelectTime(context),
                                      prefixIcon: Icons.access_time,
                                      text: formattedTime,
                                      // errorText: formProvider.timeError,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: CustomInputField(
                                controller: formProvider.nameController,
                                label: 'Nome',
                                prefixIcon: Icons.person,
                                // errorText: formProvider.nameError,
                              ),
                            ),
                            ListTile(
                              title: CustomInputField(
                                controller: formProvider.phoneController,
                                label: 'Telefone',
                                keyboardType: TextInputType.phone,
                                prefixIcon: Icons.phone,
                                // errorText: formProvider.phoneError,
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CustomInputField(
                                      controller:
                                          formProvider.boardingController,
                                      label: 'Embarque',
                                      prefixIcon: Icons.place,
                                      // errorText: formProvider.boardingError,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: CustomInputField(
                                      controller: formProvider.adultController,
                                      label: 'Adultos',
                                      prefixIcon: Icons.group,
                                      keyboardType: TextInputType.number,
                                      // errorText: formProvider.adultError,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: CustomInputField(
                                      controller: formProvider.childController,
                                      label: 'Crianças',
                                      prefixIcon: Icons.child_care,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: CustomInputField(
                                      controller:
                                          formProvider.partialValueController,
                                      label: 'Valor Pago',
                                      prefixIcon: Icons.attach_money,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                      // errorText: formProvider.partialValueError,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('+'),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: CustomInputField(
                                      controller:
                                          formProvider.boardingValueController,
                                      label: 'Valor Embarque',
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: CustomInputField(
                                controller: formProvider.obsController,
                                label: 'Observação',
                                prefixIcon: Icons.notes,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () async {
                    formProvider.isLoading
                        ? null
                        : await formProvider.saveVoucher(context);
                  },
                  label: formProvider.isLoading
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(),
                        )
                      : const Text("Salvar"),
                  icon: formProvider.isLoading ? null : const Icon(Icons.done),
                ),
              );
            },
          )),
    );
  }
}
