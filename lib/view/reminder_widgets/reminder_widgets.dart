import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:todo/controller/reminder_controller.dart';
import 'package:todo/utils/enums/dropdown_value.dart';
import 'package:todo/view/reminder_widgets/on_selected_date_widget.dart';

import 'on_monthly_once.dart';
import 'on_number_of_days_once_widget.dart';
import 'on_weekly_once.dart';

buildSubReminderWidget(var selectedItem, BuildContext context) {
  switch (selectedItem) {
    case Reminder.onSelectedDate:
      return const OnSelectedDateWidget();
    case Reminder.onWeeklyOnce:
      return OnWeeklyOnceWidget();
    case Reminder.onMonthlyOnce:
      return OnMonthlyOnce();
    case Reminder.ofNumberOfDaysOnce:
      return OnNumberOfDaysOnceWidget();
    default:
      Container();
  }
}
