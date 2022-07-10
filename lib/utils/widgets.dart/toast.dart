import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/utils/pallet.dart';

void toast(String message, [int delay = 0]) async {
  await Future.delayed(Duration(milliseconds: delay));
  Get.snackbar("", message,
      isDismissible: true,
      backgroundColor: Colors.black54,
      colorText: Pallet.white,
      titleText: const SizedBox(),
      icon: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.close,
            color: Pallet.white,
          )),
      messageText: Text(
        message,
        style: TextStyle(fontSize: 16),
      ),
      dismissDirection: DismissDirection.horizontal,
      margin: const EdgeInsets.all(16),
      animationDuration: const Duration(milliseconds: 600));
}
