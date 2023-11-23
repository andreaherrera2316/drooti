import 'package:app/src/views/design/palette.dart';
import 'package:flutter/material.dart';
import 'package:app/src/views/design/styles/content_style.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class GameButton extends StatelessWidget {
  const GameButton(
      {required this.text,
      required this.onPressed,
      this.colors = const [],
      this.height = 50,
      this.width = 180,
      this.fontSize = 19,
      super.key});
  final String text;
  final double height;
  final double width;
  final double fontSize;
  final void Function() onPressed;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPress: onPressed,
      animatedOn: AnimatedOn.onHover,
      height: height,
      width: width,
      text: text,
      isReverse: true,
      borderRadius: 20,
      transitionType: TransitionType.LEFT_TOP_ROUNDER,
      selectedTextColor: Colors.black,
      textStyle: ContentStyle(fontSize: fontSize),
      boxShadow: kElevationToShadow[2]!,
      backgroundColor: Colors.grey[200]!,
      selectedGradientColor: LinearGradient(
        colors: colors.isNotEmpty ? colors : Palette().fireColors,
      ),
    );
  }
}
