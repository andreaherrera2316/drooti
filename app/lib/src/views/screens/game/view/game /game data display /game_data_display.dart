import 'dart:async';

import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/battery%20/battery_amps_display.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/battery%20/battery_health_display.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/battery%20/battery_percentage_display.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/battery%20/battery_temperature_display.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/game%20conditions/game_temperature_display.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/motor/max_speed_display.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/game%20conditions/meters_travelled_display.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/motor/motor_health_display.dart';
import 'package:app/src/views/screens/game/view%20model/game_view_model.dart';
import 'package:app/src/views/screens/game/view%20model/notifier/igame_view_model_notifier.dart';
import 'package:app/src/views/screens/game/view%20model/notifier/igame_view_model_subscriber.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/seasons%20display/seasons_display.dart';
import 'package:app/src/views/design/styles/glowing_style.dart';
import 'package:app/src/views/design/styles/logo_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'seasons display/season alert notifier/iseason_alert_notifier.dart';

class GameDataDisplay extends StatefulWidget {
  GameDataDisplay(
      {required this.viewModel,
      required this.notifier,
      required this.seasonAlertNotifier,
      super.key});
  GameViewModel viewModel;
  IGameViewModelNotifier notifier;
  ISeasonAlertNotifier seasonAlertNotifier;

  @override
  State<GameDataDisplay> createState() => _GameDataDisplayState();
}

class _GameDataDisplayState extends State<GameDataDisplay>
    implements IGameViewModelSubscriber {
  bool _lightUp = false;
  GameViewModel? _previousModel;
  @override
  onViewmodelUpdate(GameViewModel model) {
    if (_previousModel == null) {
      _previousModel = model;
      return;
    } else {
      _previousModel = widget.viewModel;
      _lightUp = true;
      Timer(const Duration(seconds: 1), () {
        setState(() => _lightUp = false);
      });
    }
    setState(() => widget.viewModel = model);
  }

  @override
  void initState() {
    super.initState();
    widget.notifier.addModelSub(this);
  }

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    var l = AppLocalizations.of(context)!;

    var s20 = const SizedBox(width: 20, height: 20);

    var titleStyle = LogoStyle(
      fontSize: 14.5,
      color: Colors.white,
    );

    var batteryText = Text(
      l.battery,
      style: titleStyle,
    );

    var batteryAmps = BatteryAmpsDisplay(
        amps: widget.viewModel.batteryAmps,
        ampsRemaining: widget.viewModel.remainingBatteryAmps,
        style: _getStyle(
            widget.viewModel.remainingBatteryAmps,
            _previousModel?.remainingBatteryAmps ??
                widget.viewModel.remainingBatteryAmps));

    var batteryHealth = BatteryHealthDisplay(widget.viewModel.batteryHealth,
        style: _getStyle(widget.viewModel.batteryHealth,
            _previousModel?.batteryHealth ?? widget.viewModel.batteryHealth));
    var batteryPercentage = BatteryPercentageDisplay(
        widget.viewModel.batteryPercent,
        style: _getStyle(widget.viewModel.batteryPercent,
            _previousModel?.batteryPercent ?? widget.viewModel.batteryPercent));
    var batteryTemperature = BatteryTemperatureDisplay(
        widget.viewModel.batteryTemperatureF,
        style: _getStyle(
            widget.viewModel.batteryTemperatureF,
            _previousModel?.batteryTemperatureF ??
                widget.viewModel.batteryTemperatureF));

    var battery = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        batteryText,
        batteryPercentage,
        batteryHealth,
        batteryAmps,
        batteryTemperature,
      ],
    );

    var motorText = Text(l.motor, style: titleStyle);

    var maxSpeed = MaxSpeedDisplay(widget.viewModel.maxMetersPerSec,
        style: _getStyle(
            widget.viewModel.maxMetersPerSec,
            _previousModel?.maxMetersPerSec ??
                widget.viewModel.maxMetersPerSec));
    var motorHealth = MotorHealthDisplay(widget.viewModel.motorHealth,
        style: _getStyle(widget.viewModel.motorHealth,
            _previousModel?.motorHealth ?? widget.viewModel.motorHealth));

    var motor = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        motorText,
        maxSpeed,
        motorHealth,
      ],
    );

    var weatherText = Text(l.weather, style: titleStyle);
    var gameTemperature = GameTemperatureDisplay(
        widget.viewModel.gameTemperatureF,
        style: _getStyle(
            widget.viewModel.gameTemperatureF,
            _previousModel?.gameTemperatureF ??
                widget.viewModel.gameTemperatureF));

    var weather = Column(
      children: [weatherText, gameTemperature],
    );

    var metersText = Text(l.meters, style: titleStyle);
    var metersTravelled = MetersTravelled(
      widget.viewModel.metersTravelled,
      style: _getStyle(0, 0),
    );

    var meters = Column(
      children: [metersText, metersTravelled],
    );

    var gameStats = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        weather,
        s20,
        meters,
      ],
    );

    var droneStats = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        battery,
        s20,
        motor,
      ],
    );

    var stats = SizedBox(
      height: s.height * 0.5,
      width: s.width,
      child: Row(
        children: [droneStats, const Spacer(), gameStats],
      ),
    );

    var seasonAlerts =
        SeasonsDisplay(seasonAlertNotifier: widget.seasonAlertNotifier);

    //okay so how do we light up certain parts of the code
    //basically we need to check
    //whether the value has changed from the previous value
    //and if so
    //light up for a second
    //and then light down

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
          height: s.height,
          width: s.width,
          child: Column(
            children: [stats, const Spacer(), seasonAlerts],
          )),
    );
  }

  TextStyle _getStyle(dynamic current, dynamic previous) {
    bool valChanged = current != previous;
    if (_lightUp && valChanged) {
      Color glow;
      bool valIncreased = current > previous;
      if (valIncreased) {
        glow = Colors.greenAccent[400]!;
      } else {
        glow = Colors.redAccent[400]!;
      }
      return GlowingStyle(
        fontSize: 13.5,
        color: Colors.white,
        glow: glow,
      );
    }

    return LogoStyle(
      fontSize: 13.5,
      color: Colors.white,
    );
  }
}
