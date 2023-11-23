import 'dart:async';

import 'package:app/resources/commands/ongoing_command.dart';
import 'package:app/src/core/entities/drone/energy%20consumption/ienergy_consumption.dart';
import 'package:app/src/core/entities/game/drone/idrone_actions.dart';

class DecreaseSystemConsumption implements OngoingCommand {
  DecreaseSystemConsumption({
    required this.systemConsumption,
    required this.droneActions,
    this.seconds = 1,
  });

  IEnergyConsumption systemConsumption;
  int seconds;
  bool _cancel = false;
  IDroneActions droneActions;

  @override
  void execute() {
    _cancel = false;
    Timer.periodic(const Duration(seconds: 1), ((timer) {
      if (_cancel) {
        timer.cancel();
      }

      droneActions.decreaseCharge(systemConsumption.ampsConsumedPerSec);
    }));
  }

  @override
  void cancel() {
    _cancel = true;
  }
}
