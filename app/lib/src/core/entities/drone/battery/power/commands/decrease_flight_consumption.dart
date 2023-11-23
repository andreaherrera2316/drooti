import 'dart:async';

import 'package:app/resources/commands/ongoing_command.dart';
import 'package:app/src/core/entities/drone/energy%20consumption/ienergy_consumption.dart';
import 'package:app/src/core/entities/drone/flight%20controller/fly%20notifier/fly_subscriber.dart';
import 'package:app/src/core/entities/game/drone/idrone_actions.dart';

class DecreaseFlightConsumption implements OngoingCommand, FlySubscriber {
  DecreaseFlightConsumption({
    required this.flightConsumption,
    required this.droneActions,
    this.seconds = 1,
  });

  IEnergyConsumption flightConsumption;
  IDroneActions droneActions;
  int seconds;

  bool _isFlying = false;
  bool _cancel = false;

  @override
  void execute() {
    _cancel = false;
    Timer.periodic(Duration(seconds: seconds), ((timer) {
      if (_cancel) {
        timer.cancel();
      }
      if (_isFlying) {
        droneActions.decreaseCharge(flightConsumption.ampsConsumedPerSec);
      }
    }));
  }

  @override
  void cancel() {
    _cancel = true;
  }

  @override
  void onFlyUpdate(bool isFlying) {
    _isFlying = isFlying;
    if (isFlying) {
      execute();
    }
  }
}
