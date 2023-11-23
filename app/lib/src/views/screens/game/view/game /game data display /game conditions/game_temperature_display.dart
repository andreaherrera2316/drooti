import 'package:flutter/material.dart';

class GameTemperatureDisplay extends StatelessWidget {
  const GameTemperatureDisplay(this.temperature, {this.style, super.key});
  final int temperature;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text("$temperature °F", style: style);
  }
}
