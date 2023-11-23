import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/src/views/design/styles/logo_style.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    var fontSize = s.height * 0.07;

    var errorText =
        ScaleAnimatedText("Error", textStyle: LogoStyle(fontSize: fontSize));

    var instructionsText = TypewriterAnimatedText("intl.onInitError",
        textStyle: LogoStyle(fontSize: fontSize, fontWeight: FontWeight.w400));

    return Scaffold(
        body: SizedBox(
      child: Center(
          child: Column(
        children: [
          AnimatedTextKit(
            animatedTexts: [errorText],
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
          AnimatedTextKit(
            animatedTexts: [instructionsText],
            isRepeatingAnimation: true,
            repeatForever: true,
          )
        ],
      )),
    ));
  }
}
