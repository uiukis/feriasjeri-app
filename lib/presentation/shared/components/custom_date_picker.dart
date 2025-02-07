import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:get/get.dart';
import 'animated_screen.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final ValueNotifier<List<DateTime?>> selectedDates;

  CustomDatePicker({
    super.key,
    required this.startDate,
    required this.endDate,
  }) : selectedDates = ValueNotifier<List<DateTime?>>([startDate, endDate]);

  @override
  Widget build(BuildContext context) {
    return AnimatedScreen(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<List<DateTime?>>(
              valueListenable: selectedDates,
              builder: (context, dates, _) {
                return CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.range,
                    firstDate: DateTime.now(),
                    animateToDisplayedMonthDate: true,
                  ),
                  value: dates,
                  onValueChanged: (newDates) {
                    selectedDates.value = newDates;
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: Get.back,
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Get.back(result: selectedDates.value),
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
