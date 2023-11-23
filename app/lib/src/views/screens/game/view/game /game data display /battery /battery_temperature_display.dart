import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BatteryTemperatureDisplay extends StatelessWidget {
  const BatteryTemperatureDisplay(this.temperature, {this.style, super.key});
  final int temperature;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    return Text("${l.temperature} $temperature °F", style: style);
  }
}
