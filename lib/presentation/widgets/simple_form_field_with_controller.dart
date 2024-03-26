import 'package:flutter/material.dart';

class SimpleFormFieldWithController extends StatefulWidget {
  final String hintText;
  const SimpleFormFieldWithController({
    super.key,
    required this.hintText,
    required this.textController,
  });

  final TextEditingController textController;

  @override
  State<SimpleFormFieldWithController> createState() =>
      _SimpleFormFieldWithControllerState();
}

class _SimpleFormFieldWithControllerState
    extends State<SimpleFormFieldWithController> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          hintText: widget.hintText),
    );
  }
}
