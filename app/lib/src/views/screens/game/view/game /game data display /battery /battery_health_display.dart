import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BatteryHealthDisplay extends StatelessWidget {
  const BatteryHealthDisplay(this.health, {this.style, super.key});
  final double health;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;

    return Text("${l.health} $health", style: style);
  }
}
