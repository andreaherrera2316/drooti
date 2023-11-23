import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton(
      {required this.title,
      required this.gradient,
      this.icon,
      required this.onPressed,
      this.borderRadius = 0,
      this.elevation,
      this.textColor,
      super.key});

  const GradientButton.rounded(
      {required this.title,
      required this.gradient,
      this.icon,
      required this.onPressed,
      this.borderRadius = 25,
      this.elevation,
      this.textColor,
      super.key});

  final Color? textColor;
  final List<Shadow>? elevation;
  final String title;
  final Gradient gradient;
  final IconData? icon;
  final double borderRadius;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var roundedBorder = BorderRadius.all(Radius.circular(borderRadius));
    BorderRadius.all(
      Radius.circular(borderRadius),
    );
    var decoration = BoxDecoration(
      gradient: gradient,
      borderRadius: roundedBorder,
    );

    var style = TextStyle(
      fontFamily: "Unbound",
      shadows: elevation,
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: textColor,
    );

    var text = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(title, style: style),
    );

    var buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: roundedBorder)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
    );

    if (icon == null) {
      return DecoratedBox(
        decoration: decoration,
        child:
            FilledButton(onPressed: onPressed, style: buttonStyle, child: text),
      );
    } else {
      return DecoratedBox(
        decoration: decoration,
        child: FilledButton.icon(
            icon: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Icon(icon, size: 30),
            ),
            onPressed: onPressed,
            style: buttonStyle,
            label: text),
      );
    }
  }
}
