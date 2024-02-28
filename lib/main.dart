import 'package:cinemapp/data/data.dart';
import 'package:cinemapp/data/get_it_methods.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'presentation/presentation.dart';
import 'presentation/themes/themes.dart';

final sl = GetIt.instance;

void main() {
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (BuildContext context) => ThemeProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: context.watch<ThemeProvider>().currentTheme == AppTheme.dark
                ? lightTheme
                : darkTheme,
            routes: sl.get<NavigatorClient>().routes);
      }),
    );
  }
}
