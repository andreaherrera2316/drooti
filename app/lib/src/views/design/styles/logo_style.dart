import 'package:flutter/material.dart';

import '../palette.dart';

class LogoStyle extends TextStyle {
  LogoStyle(
      {Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      List<Shadow>? shadows})
      : super(
          color: color ?? Palette().logo,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: "BlackHan",
          shadows: shadows,
        );
}
