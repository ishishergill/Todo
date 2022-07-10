import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:todo/controller/reminder_controller.dart';
import 'package:todo/view/reminder_widgets/set_reminder.dart';
import 'package:get/get.dart';

class OnSelectedDateWidget extends StatefulWidget {
  const OnSelectedDateWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OnSelectedDateWidget> createState() => _OnSelectedDateWidgetState();
}

class _OnSelectedDateWidgetState extends State<OnSelectedDateWidget> {
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: PlatformElevatedButton(
            child: Text(date == null
                ? "Select Date"
                : DateFormat.yMMMMd('en_US').format(date!)),
            onPressed: () async {
              final chosenDate = await showPlatformDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.utc(1990),
                  lastDate: DateTime.utc(2040));

              if (chosenDate != null) {
                setState(() {
                  date = chosenDate;
                });
              }
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SetReminder(
          onPressed: () {
            if (date != null) {
              Get.find<ReminderController>()
                  .scheduleNotification(date!, DateTimeComponents.dateAndTime);
            }
          },
        ),
      ],
    );
  }
}
