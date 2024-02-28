import 'package:flutter/material.dart';

class StringManager {
  String toCaiptalize(String name) {
    String capitalized =
        '${name.characters.first.toUpperCase()}${name.substring(1)}';
    return capitalized;
  }
}
