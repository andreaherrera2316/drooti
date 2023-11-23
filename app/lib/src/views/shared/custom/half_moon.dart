import 'package:flutter/material.dart';

class HalfMoon extends StatelessWidget {
  const HalfMoon(
      {required this.color,
      required this.height,
      required this.width,
      super.key})
      : gradient = null;

  const HalfMoon.gradient(
      {required this.gradient,
      required this.height,
      required this.width,
      super.key})
      : color = Colors.black;

  final Color color;
  final Gradient? gradient;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (gradient != null) {
      return ClipPath(
          clipper: HalfMoonPath(),
          child: Container(
            decoration: BoxDecoration(gradient: gradient),
            height: height,
            width: width,
          ));
    }

    return ClipPath(
        clipper: HalfMoonPath(),
        child: Container(
          color: color,
          height: height,
          width: width,
        ));
  }
}

class HalfMoonPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var h = size.height;
    var w = size.width;
    var path = Path()
      ..lineTo(0, h * 0.7)
      ..quadraticBezierTo(w * 0.5, h * 1.1, w, h * 0.7)
      ..lineTo(w, 0)
      ..lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
