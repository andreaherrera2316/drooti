import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaxSpeedDisplay extends StatelessWidget {
  const MaxSpeedDisplay(this.speed, {this.style, super.key});
  final double speed;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    var l = AppLocalizations.of(context)!;

    return Text("${l.speed} $speed m/s", style: style);
  }
}


//TODO: update the game to have meters per seconds instead 
//of per minute 