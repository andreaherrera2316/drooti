import 'package:flutter/material.dart';

class GlowingStyle extends TextStyle {
  GlowingStyle(
      {Color color = Colors.black,
      double? fontSize,
      FontWeight? fontWeight,
      glow,
      Offset offset = const Offset(0, 6)})
      : super(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: "BlackHan",
          shadows: [
            Shadow(
                blurRadius: fontSize ?? 16 * 0.55, color: glow, offset: offset),
            Shadow(
                blurRadius: fontSize ?? 16 * 0.75,
                color: glow.withOpacity(0.7),
                offset: offset),
            Shadow(
                blurRadius: fontSize ?? 16 * 1.2,
                color: glow.withOpacity(0.3),
                offset: offset),
          ],
        );
}
