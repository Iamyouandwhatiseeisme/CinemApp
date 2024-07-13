import 'package:cinemapp/bloc/cubit/remote_data_base_cubit.dart';
import 'package:cinemapp/bloc/cubit/remote_data_base_messanger_cubit.dart';
import 'package:cinemapp/data/data.dart';
import 'package:cinemapp/data/get_it_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'presentation/presentation.dart';
import 'presentation/themes/themes.dart';

final sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RemoteDataBaseInitiate(),
        ),
        BlocProvider(
          create: (context) => RemoteDataBaseMessangerCubit(),
        ),
      ],
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (BuildContext context) => ThemeProvider(),
        child: Builder(builder: (context) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'CinemAPP',
              theme:
                  context.watch<ThemeProvider>().currentTheme == AppTheme.dark
                      ? lightTheme
                      : darkTheme,
              routes: sl.get<NavigatorClient>().routes);
        }),
      ),
    );
  }
}
