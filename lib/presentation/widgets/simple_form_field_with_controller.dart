import 'package:flutter/material.dart';

class SimpleFormFieldWithController extends StatelessWidget {
  final String hintText;
  const SimpleFormFieldWithController({
    super.key,
    required this.hintText,
    required this.movieLengthController,
  });

  final TextEditingController movieLengthController;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.longPress,
      message: hintText,
      child: TextFormField(
        controller: movieLengthController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: hintText),
      ),
    );
  }
}
