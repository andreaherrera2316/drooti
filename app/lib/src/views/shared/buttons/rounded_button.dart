import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {required this.title,
      this.icon,
      this.buttonColor,
      required this.onPressed,
      this.borderRadius = 25,
      super.key});

  final String title;
  final IconData? icon;
  final double borderRadius;
  final Color? buttonColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w400,
    );

    var text = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(title, style: style),
    );

    var buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)))),
      backgroundColor: MaterialStateProperty.all(buttonColor),
    );

    if (icon == null) {
      return ElevatedButton(
          onPressed: onPressed, style: buttonStyle, child: text);
    } else {
      return ElevatedButton.icon(
          icon: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Icon(icon, size: 30),
          ),
          onPressed: onPressed,
          style: buttonStyle,
          label: text);
    }
  }
}
