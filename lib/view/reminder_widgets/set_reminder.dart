import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:todo/controller/reminder_controller.dart';

class SetReminder extends StatelessWidget {
  const SetReminder({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PlatformElevatedButton(
        child: const Text("Set Reminder"),
        onPressed: () {
          onPressed();
          Get.find<ReminderController>().time = null;
          Get.back();
        },
        padding: const EdgeInsets.symmetric(horizontal: 60),
      ),
    );
  }
}
