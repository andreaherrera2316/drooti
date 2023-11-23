import 'package:app/src/views/design/styles/glowing_style.dart';
import 'package:flutter/material.dart';

class SeasonText extends StatelessWidget {
  const SeasonText({required this.season, required this.glow, super.key});
  final String season;
  final Color glow;

  @override
  Widget build(BuildContext context) {
    var style = GlowingStyle(
        fontSize: 33,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        glow: glow);

    return Text(season.toUpperCase(), style: style);
  }
}

//okay i think the season manager is repeating a season?
  //like it's spring
  //and then it's spring again
  //and then it does work well
  //but the very first move
