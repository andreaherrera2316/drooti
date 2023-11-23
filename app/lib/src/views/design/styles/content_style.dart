import 'package:flutter/material.dart';

class ContentStyle extends TextStyle {
  const ContentStyle(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      List<Shadow>? shadows})
      : super(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: "Unbound",
          shadows: shadows,
        );
}
