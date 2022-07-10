import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:todo/controller/reminder_controller.dart';
import 'package:todo/view/reminder_widgets/set_reminder.dart';

class OnWeeklyOnceWidget extends StatefulWidget {
  const OnWeeklyOnceWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OnWeeklyOnceWidget> createState() => _OnWeeklyOnceWidgetState();
}

class _OnWeeklyOnceWidgetState extends State<OnWeeklyOnceWidget> {
  bool isSelected = false;
  List<String> days = ["Mon", "Tue", "Wed", "Thr", "Fri", "Sat", "Sun"];
  List<bool> selectedDay = List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedDay[index] = !selectedDay[index];
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color:
                              selectedDay[index] ? Colors.blue : Colors.white),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Text(days[index])),
                );
              })),
          const SizedBox(
            height: 30,
          ),
          SetReminder(onPressed: () {
            List<DateTime> selectedDates = getDates();
            for (var element in selectedDates) {
              Get.find<ReminderController>().scheduleNotification(
                  element, DateTimeComponents.dayOfWeekAndTime);
            }
          })
        ],
      ),
    );
  }

  List<DateTime> getDates() {
    List<DateTime> dates = [];
    List<String> s = [];
    Map<int, DateTime> mapOfDates = {};
    List<DateTime> nextSevenDays = [];

    var today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      nextSevenDays.add(today.add(Duration(days: i)));
    }

    for (int e = 0; e < 7; e++) {
      if (selectedDay[e]) {
        s.add(days[e]);
      }
    }

    for (var e in nextSevenDays) {
      mapOfDates[e.weekday] = e;
    }

    for (var t in s) {
      switch (t) {
        case "Mon":
          dates.add(mapOfDates[1]!);
          break;
        case "Tue":
          dates.add(mapOfDates[2]!);
          break;
        case "Wed":
          dates.add(mapOfDates[3]!);
          break;
        case "Thr":
          dates.add(mapOfDates[4]!);
          break;
        case "Fri":
          dates.add(mapOfDates[5]!);
          break;
        case "Sat":
          dates.add(mapOfDates[6]!);
          break;
        case "Sun":
          dates.add(mapOfDates[7]!);
          break;
      }
    }
    return dates;
  }
}
