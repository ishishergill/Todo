import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:todo/controller/reminder_controller.dart';
import 'package:todo/utils/enums/dropdown_value.dart';
import 'package:todo/utils/pallet.dart';
import 'package:todo/utils/style.dart';
import 'package:todo/utils/widgets.dart/dropdown.dart';
import 'package:todo/view/reminder_widgets/reminder_widgets.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  List<DropdownMenuItem> items = [
    const DropdownMenuItem(
      child: Text(
        "Reminder on a selected date",
        style: TextStyle(color: Colors.black),
      ),
      value: Reminder.onSelectedDate,
    ),
    const DropdownMenuItem(
      child: Text(
        "Reminder for weekly once",
        style: TextStyle(color: Colors.black),
      ),
      value: Reminder.onWeeklyOnce,
    ),
    const DropdownMenuItem(
      child: Text(
        "Reminder for monthly once",
        style: TextStyle(color: Colors.black),
      ),
      value: Reminder.onMonthlyOnce,
    ),
    const DropdownMenuItem(
      child: Text(
        "Reminder of number of days once",
        style: TextStyle(color: Colors.black),
      ),
      value: Reminder.ofNumberOfDaysOnce,
    ),
  ];

  Reminder? selectedItem;
  TimeOfDay? time;
  final reminderController = Get.find<ReminderController>();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> clearValues() async {
    time = null;
    reminderController.time = null;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return clearValues();
      },
      child: PlatformScaffold(
        backgroundColor: Pallet.background,
        appBar: PlatformAppBar(
          title: Text(
            "Reminder",
            style: Style.appHeading,
          ),
          cupertino: (_, __) => CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
          ),
        ),
        material: (_, __) => MaterialScaffoldData(),
        body: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: PlatformElevatedButton(
                        child: Text(reminderController.time != null
                            ? "${time!.hour} : ${time!.minute} "
                            : "Select Time"),
                        onPressed: () async {
                          final timePicked = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          setState(() {
                            time = timePicked;
                          });
                          reminderController.time = time;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    reminderController.time != null
                        ? CustomDropdownButton(
                            hint: "Select Reminder",
                            items: items,
                            selectedItem: selectedItem,
                            voidCallack: (value) {
                              setState(() {
                                selectedItem = value;
                              });
                            })
                        : Container(),
                    const SizedBox(
                      height: 30,
                    ),
                    selectedItem != null
                        ? buildSubReminderWidget(selectedItem, context)
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
