import 'package:flutter/material.dart';

import '../../../../../../../../helper/round_decimal_places.dart';

class BatteryPercentageDisplay extends StatelessWidget {
  const BatteryPercentageDisplay(this.percentage, {this.style, super.key});
  final double percentage;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${RoundDecimalPlaces().decimalPlaces(percentage, 1)}%',
      style: style,
    );
  }
}
