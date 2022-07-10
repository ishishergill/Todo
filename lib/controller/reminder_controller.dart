import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo/model/todo.dart';

class ReminderController extends GetxController {
  late FlutterLocalNotificationsPlugin flutterNotification;
  TimeOfDay? time;
  Todo? selectedTodo;
  @override
  void onInit() {
    super.onInit();
    var androidInitilize = const AndroidInitializationSettings('app_icon');
    var iOSinitilize = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initilizationsSettings =
        InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    flutterNotification = FlutterLocalNotificationsPlugin();
    flutterNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future notificationSelected(String? payload) async {
    //on select notification
  }
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {}
  // display a dialog with the notification details, tap ok to go to another page

  scheduleNotification(
      DateTime scheduleDate, DateTimeComponents dateTimeComponents) async {
    final notificationDateTime = DateTime(scheduleDate.year, scheduleDate.month,
        scheduleDate.day, time!.hour, time!.minute);
    Random random = Random();

    final id = random.nextInt(59999999);
    tz.initializeTimeZones();
    await flutterNotification.zonedSchedule(
        id,
        selectedTodo!.title,
        null,
        tz.TZDateTime.from(notificationDateTime, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        matchDateTimeComponents: dateTimeComponents,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  schedulePeriodicNotification(int numberOfDays) async {
    Random random = Random();
    final id = random.nextInt(59999999);
    await flutterNotification.periodicallyShow(
      id,
      selectedTodo!.title,
      null,
      RepeatInterval.daily,
      const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description')),
    );
  }
}
