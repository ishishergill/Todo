import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controller/reminder_controller.dart';
import 'package:todo/view/reminder_widgets/set_reminder.dart';

class OnNumberOfDaysOnceWidget extends StatelessWidget {
  OnNumberOfDaysOnceWidget({
    Key? key,
  }) : super(key: key);

  int numberOfDays = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlatformTextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (value.trim().isNotEmpty) {
              numberOfDays = int.parse(value);
            }
          },
          cupertino: (_, __) => CupertinoTextFormFieldData(
              decoration: BoxDecoration(color: Colors.white)),
        ),
        const SizedBox(
          height: 30,
        ),
        SetReminder(onPressed: () {
          List<DateTime> selectedDates = getDates();
          for (var element in selectedDates) {
            Get.find<ReminderController>()
                .scheduleNotification(element, DateTimeComponents.dateAndTime);
          }
        })
      ],
    );
  }

  List<DateTime> getDates() {
    List<DateTime> dates = [];
    DateTime onDate = DateTime.now().add(Duration(days: numberOfDays));

    dates.add(onDate);
    return dates;
  }
}
