import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/utils/di/initial_bindings.dart';
import 'package:todo/utils/helper/notification_helper.dart';
import 'package:todo/utils/style.dart';
import 'package:todo/view/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      home: PlatformApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo',
        material: (_, __) => MaterialAppData(theme: Style.materialThemeData),
        cupertino: (_, __) => CupertinoAppData(theme: Style.cupertinoTheme),
        home: const HomePage(),
      ),
    );
  }
}
