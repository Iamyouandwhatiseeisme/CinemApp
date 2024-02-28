import 'package:cinemapp/data/data.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CustomDropDownMenu<T extends Enum> extends StatelessWidget {
  final List<T> options;
  final T initialSelection;

  const CustomDropDownMenu({
    super.key,
    required this.options,
    required this.initialSelection,
  });

  @override
  Widget build(BuildContext context) {
    final StringManager stringManager = sl.get<StringManager>();

    return DropdownMenu<T>(
      initialSelection: initialSelection,
      dropdownMenuEntries: options.map<DropdownMenuEntry<T>>(
        (T option) {
          return DropdownMenuEntry<T>(
            value: option,
            label: stringManager.toCaiptalize(option.name),
          );
        },
      ).toList(),
    );
  }
}
