import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controller/reminder_controller.dart';
import 'package:todo/utils/pallet.dart';
import 'package:todo/view/reminder_widgets/set_reminder.dart';

class OnMonthlyOnce extends StatefulWidget {
  const OnMonthlyOnce({
    Key? key,
  }) : super(key: key);

  @override
  State<OnMonthlyOnce> createState() => _OnMonthlyOnceState();
}

class _OnMonthlyOnceState extends State<OnMonthlyOnce> {
  List<int> selectedDatesOfMonths = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: Get.height * 0.3,
            width: Get.width * 0.9,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 50,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 10),
                itemCount: 31,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      if (selectedDatesOfMonths.contains(index + 1)) {
                        selectedDatesOfMonths.remove(index + 1);
                      } else {
                        selectedDatesOfMonths.add(index + 1);
                      }
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text((index + 1).toString()),
                      decoration: BoxDecoration(
                          color: selectedDatesOfMonths.contains(index + 1)
                              ? Colors.blue
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  );
                })),
        const SizedBox(
          height: 30,
        ),
        SetReminder(onPressed: () {
          List<DateTime> selectedDates = getDates();
          for (var element in selectedDates) {
            Get.find<ReminderController>().scheduleNotification(
                element, DateTimeComponents.dayOfMonthAndTime);
          }
        })
      ],
    );
  }

  List<DateTime> getDates() {
    List<DateTime> dates = [];
    selectedDatesOfMonths.sort();

    for (var element in selectedDatesOfMonths) {
      DateTime now = DateTime.now();
      if (now.day <= element) {
        DateTime date = DateTime(now.year, now.month, element);
        dates.add(date);
      } else {
        DateTime date = DateTime(now.year, now.month + 1, element);
        dates.add(date);
      }
    }
    return dates;
  }
}
