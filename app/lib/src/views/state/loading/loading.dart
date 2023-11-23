import 'package:app/src/views/design/palette.dart';
import 'package:flutter/material.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    var p = Palette();
    return Scaffold(
        body: SizedBox(
      child: Center(
          child: SpinKitDancingSquare(size: s.height * 0.125, color: p.logo)),
    ));
  }
}
