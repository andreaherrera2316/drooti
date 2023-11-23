import 'package:app/src/views/design/palette.dart';
import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String text;
  final double titleSize;

  const AppTitle({
    super.key,
    required this.text,
    this.titleSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    var p = Palette();

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.07),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          shadows: kElevationToShadow[3],
          color: p.chromeSilver,
          fontFamily: "BlackHan",
          fontSize: titleSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
