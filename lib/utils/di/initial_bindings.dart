import 'package:get/get.dart';
import 'package:todo/controller/reminder_controller.dart';
import 'package:todo/controller/todo_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TodoController());
    Get.put(ReminderController());
  }
}
