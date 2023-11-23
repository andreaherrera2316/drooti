import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app/src/views/design/palette.dart';
import 'package:app/src/views/design/styles/logo_style.dart';
import 'package:flutter/material.dart';

class LoadingGame extends StatelessWidget {
  const LoadingGame({super.key});

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    var fontSize = s.height * 0.07;

    var text = WavyAnimatedText("DROOTI",
        textStyle:
            LogoStyle(fontSize: fontSize, color: Palette().sterlingSilver));
    return Scaffold(
        body: SizedBox(
      child: Center(
          child: AnimatedTextKit(
        animatedTexts: [text],
        isRepeatingAnimation: true,
        repeatForever: true,
      )),
    ));
  }
}
