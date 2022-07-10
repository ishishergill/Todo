import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Style {
  static TextStyle appHeading =
      const TextStyle(fontSize: 25, fontWeight: FontWeight.w600);

  static TextStyle heading =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  static final materialThemeData = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(color: Colors.blue.shade600),
      primaryColor: Colors.blue,
      secondaryHeaderColor: Colors.blue,
      canvasColor: Colors.blue,
      backgroundColor: Colors.red,
      textTheme:
          const TextTheme().copyWith(bodyText1: const TextTheme().bodyText2),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(secondary: Colors.blue));

  static const cupertinoTheme = CupertinoThemeData(
      primaryColor: Colors.blue,
      barBackgroundColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white);
}
