import 'package:app/src/views/design/styles/logo_style.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({this.size, this.color, this.shadows, super.key});
  final double? size;
  final Color? color;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Text("DROOTI",
        style: LogoStyle(fontSize: size, color: color, shadows: shadows));
  }
}
