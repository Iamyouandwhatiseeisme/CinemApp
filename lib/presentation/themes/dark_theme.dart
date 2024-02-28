import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff363636),
    fontFamily: 'Telegraf',
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
        surface: Color(0xff363636),
        background: Color(0xff121212),
        primary: Color.fromARGB(255, 231, 204, 204),
        secondary: Color(0xff8685E7)));
