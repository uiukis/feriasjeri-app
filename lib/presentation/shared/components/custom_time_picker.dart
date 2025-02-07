import 'package:feriasjeri_app/presentation/shared/components/animated_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTimePicker extends StatelessWidget {
  final Rx<TimeOfDay> selectedTime;

  const CustomTimePicker({
    super.key,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 26.0, height: 1.5);

    void updateTime(int hour, int minute) {
      selectedTime.value = TimeOfDay(hour: hour, minute: minute);
    }

    return AnimatedScreen(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: textStyle.fontSize! * textStyle.height!,
                          scrollController: FixedExtentScrollController(
                            initialItem: selectedTime.value.hour,
                          ),
                          onSelectedItemChanged: (index) {
                            updateTime(index, selectedTime.value.minute);
                          },
                          children: List.generate(24, (index) {
                            return Text(
                              "$index".padLeft(2, '0'),
                              style: textStyle,
                            );
                          }),
                        ),
                      ),
                      const Text(":", style: textStyle),
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: textStyle.fontSize! * textStyle.height!,
                          scrollController: FixedExtentScrollController(
                            initialItem: selectedTime.value.minute,
                          ),
                          onSelectedItemChanged: (index) {
                            updateTime(selectedTime.value.hour, index);
                          },
                          children: List.generate(60, (index) {
                            return Text(
                              "$index".padLeft(2, '0'),
                              style: textStyle,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            TextButton(
              onPressed: () {
                Get.back(result: selectedTime.value);
              },
              child: const Text("Selecionar Horário"),
            ),
          ],
        ),
      ),
    );
  }
}
