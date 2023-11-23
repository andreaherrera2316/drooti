import 'dart:async';

import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/seasons%20display/season%20alert%20notifier/iseason_alert_notifier.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/seasons%20display/season_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeasonsDisplay extends StatefulWidget {
  const SeasonsDisplay(
      {this.alertSecs = 2, required this.seasonAlertNotifier, super.key});
  final int alertSecs;
  final ISeasonAlertNotifier seasonAlertNotifier;

  @override
  State<SeasonsDisplay> createState() => _SeasonsDisplayState();
}

class _SeasonsDisplayState extends State<SeasonsDisplay>
    implements ISeasonAlertSubscriber {
  AppLocalizations? l;

  String _season = "";
  bool display = false;
  Color color = Colors.white;

  @override
  void initState() {
    super.initState();
    widget.seasonAlertNotifier.addAlertSub(this);
  }

  @override
  void dispose() {
    widget.seasonAlertNotifier.removeAlertSub(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    l = AppLocalizations.of(context)!;

    if (display) {
      return SeasonText(season: _season, glow: color);
    } else {
      return const SizedBox();
    }
  }

  @override
  void autumn() {
    color = Colors.orange;
    _season = l?.autumn ?? "autumn";
    _displaySeason();
  }

  @override
  void spring() {
    color = Colors.green;
    _season = l?.spring ?? "spring";
    _displaySeason();
  }

  @override
  void summer() {
    color = Colors.yellow;
    _season = l?.summer ?? "summer";
    _displaySeason();
  }

  @override
  void winter() {
    color = Colors.blue;
    _season = l?.winter ?? "winter";
    _displaySeason();
  }

  _displaySeason() {
    setState(() {
      display = true;

      Timer(Duration(seconds: widget.alertSecs), () {
        setState(() {
          display = false;
        });
      });
    });
  }
}
