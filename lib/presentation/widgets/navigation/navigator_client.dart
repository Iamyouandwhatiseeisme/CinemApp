import 'package:cinemapp/presentation/pages/posters_screen/posters_screen.dart';
import 'package:cinemapp/presentation/presentation.dart';
import 'package:flutter/material.dart';

class NavigatorClient {
  static const String initialPage = '/';
  static const String chatScreen = 'chat_screen';
  static const String postersScreen = 'posters_screen';

  final Map<String, WidgetBuilder> routes = {
    initialPage: (context) => const InitialPage(),
    chatScreen: (context) => const ChatScreen(),
    postersScreen: (context) => const PostersScreen()
  };
}
