import 'package:cinemapp/presentation/presentation.dart';
import 'package:flutter/material.dart';

class NavigatorClient {
  static const String initialPage = '/';
  static const String chatScreen = 'chat_screen';

  final Map<String, WidgetBuilder> routes = {
    initialPage: (context) => const InitialPage(),
    chatScreen: (context) => const ChatScreen()
  };
}
