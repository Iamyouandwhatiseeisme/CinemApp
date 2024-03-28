import 'package:flutter/material.dart';

class StarIcon extends StatelessWidget {
  final bool isFilled;

  const StarIcon({super.key, required this.isFilled});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isFilled ? Icons.star : Icons.star_border,

      color: Colors.red,
      size: 12.0, // Adjust the size as needed
    );
  }
}
