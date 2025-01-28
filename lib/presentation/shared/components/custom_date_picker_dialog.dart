import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'animated_screen.dart';

class CustomDatePickerDialog extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;

  const CustomDatePickerDialog({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  List<DateTime?> selectedDates = [];

  @override
  void initState() {
    super.initState();
    selectedDates = [widget.startDate, widget.endDate];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScreen(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.range,
                firstDate: DateTime.now(),
                animateToDisplayedMonthDate: true,
              ),
              value: selectedDates,
              onValueChanged: (dates) {
                setState(() {
                  selectedDates = dates;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(selectedDates),
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
