import 'dart:async';

import 'package:app/resources/commands/ongoing_command.dart';
import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_subscriber.dart';
import 'package:app/src/core/entities/game/drone/idrone_actions.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';

class OnExtremeTempReduceCapacity
    implements OngoingCommand, ExtremeTemperatureSubscriber {
  OnExtremeTempReduceCapacity({required this.droneActions, this.onExtremeTemp});

  IDroneActions droneActions;
  bool _overheat = false;
  bool _extremeCold = false;
  bool _cancel = false;
  void Function()? onExtremeTemp;

  @override
  void execute() {
    _cancel = false;
    Timer.periodic(const Duration(seconds: 1), ((timer) {
      if (_cancel) {
        timer.cancel();
      }
      if (_overheat || _extremeCold) {
        droneActions.damageBattery(-0.5);
        onExtremeTemp!();
      }
    }));
  }

  @override
  void cancel() {
    _cancel = true;
  }

  @override
  onExtremeCold(Temperature batteryTemp, int belowByDegreesF) {
    _extremeCold = true;
    execute();
  }

  @override
  onOverheat(Temperature batteryTemp, int exceededByDegreesF) {
    _overheat = true;
    execute();
  }

  @override
  onExtremeColdStopped(Temperature batteryTemp) {
    _extremeCold = false;
    cancel();
  }

  @override
  onOverheatStopped(Temperature batteryTemp) {
    _overheat = false;
    cancel();
  }
}
