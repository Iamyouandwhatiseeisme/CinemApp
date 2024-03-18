import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 248, 232, 186),
    brightness: Brightness.light,
    appBarTheme:
        const AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
    colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 246, 239, 217), secondary: Colors.grey));
