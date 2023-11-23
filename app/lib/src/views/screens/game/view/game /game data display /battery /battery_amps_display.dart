import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BatteryAmpsDisplay extends StatelessWidget {
  const BatteryAmpsDisplay(
      {required this.ampsRemaining, required this.amps, this.style, super.key});
  final double amps;
  final double ampsRemaining;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;
    return Text('$ampsRemaining A ${l.ofText} $amps A', style: style);
  }
}
