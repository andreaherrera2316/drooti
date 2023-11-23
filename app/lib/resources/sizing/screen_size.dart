import 'package:flutter/material.dart';

abstract class ScreenSize {
  static const minScreenWidth = 300.0;
  static const minScreenHeight = 500.0;

  static Size getSize(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return fromSize(s);
  }

  static Size fromSize(Size size) {
    double width = size.width;
    double height = size.height;

    bool widthIsValid = width >= minScreenWidth;
    bool heightIsValid = height >= minScreenHeight;

    if (widthIsValid && heightIsValid) {
      return Size(width, height);
    } else if (widthIsValid) {
      return Size(width, minScreenHeight);
    } else if (heightIsValid) {
      return Size(minScreenWidth, height);
    }
    return const Size(minScreenWidth, minScreenHeight);
  }
}
