import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.blueGrey,
  fontFamily: 'Telegraf',
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      onPrimary: Colors.lightBlue,
      surface: Colors.blueGrey,
      primary: Color.fromARGB(255, 231, 204, 204),
      secondary: Colors.grey),
);
