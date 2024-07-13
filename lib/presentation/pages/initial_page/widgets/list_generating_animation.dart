import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ListGeneratingAnimation extends StatelessWidget {
  const ListGeneratingAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: LinearProgressIndicator(),
            ),
            AnimatedTextKit(
              displayFullTextOnTap: true,
              repeatForever: true,
              animatedTexts: [
                TyperAnimatedText('Please wait while we generate your list...',
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
