import 'package:cinemapp/data/data.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CustomDropDownMenu extends StatelessWidget {
  final List<String> options;
  final String initialSelection;

  const CustomDropDownMenu({
    super.key,
    required this.options,
    required this.initialSelection,
  });

  @override
  Widget build(BuildContext context) {
    final StringManager stringManager = sl.get<StringManager>();

    return DropdownMenu<String>(
      initialSelection: initialSelection,
      dropdownMenuEntries: options.map<DropdownMenuEntry<String>>(
        (String option) {
          return DropdownMenuEntry<String>(
            value: option,
            label: stringManager.toCaiptalize(option),
          );
        },
      ).toList(),
    );
  }
}
