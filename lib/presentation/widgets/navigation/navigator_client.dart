import 'package:cinemapp/presentation/presentation.dart';
import 'package:flutter/material.dart';

class NavigatorClient {
  static const String initialPage = '/';

  final Map<String, WidgetBuilder> routes = {
    initialPage: (context) => const InitialPage()
  };
}
