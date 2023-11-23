import 'package:app/helper/round_decimal_places.dart';
import 'package:flutter/material.dart';

class MetersTravelled extends StatelessWidget {
  const MetersTravelled(this.meters, {this.style, super.key});
  final double meters;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text("${RoundDecimalPlaces().decimalPlaces(meters, 1)}",
        style: style);
  }
}
