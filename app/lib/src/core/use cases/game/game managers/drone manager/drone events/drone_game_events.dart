import 'dart:async';

import 'package:app/helper/amount_in_percentage.dart';
import 'package:app/src/core/entities/drone/battery/health/battery%20dies%20notifier/battery_died_subscriber.dart';
import 'package:app/src/core/entities/drone/battery/power/out%20of%20power%20notifier/out_of_power_subscriber.dart';
import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_subscriber.dart';
import 'package:app/src/core/entities/drone/idrone.dart';
import 'package:app/src/core/entities/drone/motor/motor%20broke%20notifier/motor_broke.subscriber.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20events/boundaries/input_drone_updates.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20events/boundaries/output_drone_updates.dart';

class DroneGameEvents
    implements
        MotorBrokeSubscriber,
        BatteryDiedSubscriber,
        OutOfPowerSubscriber,
        ExtremeTemperatureSubscriber,
        InputDroneUpdates {
  DroneGameEvents({
    required this.output,
    required this.minTempResitance,
    required this.maxTempResitance,
    this.onDroneDied,
  });
  @override
  OutputDroneUpdates output;
  int minTempResitance;
  int maxTempResitance;
  void Function()? onDroneDied;

  bool freezing = false;
  bool overheating = false;

  @override
  void subscribeToDrone(IDrone drone) {
    drone.motor.addMotorSub(this);
    drone.battery.subscribeToBatteryDied(this);
    drone.battery.subscribeToOutOfPower(this);
    drone.battery.subscribeToExtremeTemps(this);
  }

  @override
  void onBatteryDeath() {
    output.droneBatteryDied();
    onDroneDied!();
  }

  @override
  void onMotorBroke() {
    output.droneMotorBroke();
    onDroneDied!();
  }

  @override
  void onOutOfPower() {
    output.droneOutOfPower();
    onDroneDied!();
  }

  @override
  void onOverheatStopped(Temperature batteryTemp) {
    overheating = false;

    output.overheatStopped();
  }

  @override
  void onExtremeColdStopped(Temperature batteryTemp) {
    freezing = false;
    output.extremeColdStopped();
  }

  @override
  void onOverheat(Temperature batteryTemp, int aboveByDeegresF) {
    overheating = true;
    bool tooHot = _ifTooHotExplodeDrone(aboveByDeegresF);

    if (!tooHot) {
      output.overheat(aboveByDeegresF);
      _ifHotTooLongExplodeDrone();
    }
  }

  @override
  void onExtremeCold(Temperature batteryTemp, int belowByDegreesF) {
    freezing = true;
    bool tooCold = _ifTooColdFreezeDrone(belowByDegreesF);

    if (!tooCold) {
      output.extremeCold(belowByDegreesF);
      _ifColdTooLongFreezeDrone();
    }
  }

  @override
  void unsubscribeToDrone(IDrone drone) {
    drone.motor.removeMotorSub(this);
    drone.battery.unsubscribeToBatteryDied(this);
    drone.battery.unsubscribeToOutOfPower(this);
    drone.battery.unsubscribeToExtremeTemps(this);
  }

  void _freezeDrone() {
    output.droneFroze();
    onDroneDied!();
  }

  void _explodeDrone() {
    output.droneExploded();
    onDroneDied!();
  }

  int get _resistanceMinMaxAverage =>
      (minTempResitance + maxTempResitance / 2).round();

  bool _ifTooColdFreezeDrone(int belowByDeegresF) {
    double percentageBelowMin = AmountInPercentage()
        .getPercent(amount: belowByDeegresF, total: _resistanceMinMaxAverage)
      ..abs();

    bool tooCold = percentageBelowMin >= 10;
    if (tooCold) {
      _freezeDrone();
      return true;
    }
    return false;
  }

  void _ifColdTooLongFreezeDrone() {
    Timer(const Duration(seconds: 10), () {
      if (freezing) {
        _freezeDrone();
      }
    });
  }

  bool _ifTooHotExplodeDrone(int aboveByDeegresF) {
    double percentageAboveMax = AmountInPercentage()
        .getPercent(amount: aboveByDeegresF, total: _resistanceMinMaxAverage);

    bool tooHot = percentageAboveMax >= 10;
    if (tooHot) {
      _explodeDrone();
      return true;
    }
    return false;
  }

  void _ifHotTooLongExplodeDrone() {
    Timer(const Duration(seconds: 10), () {
      if (overheating) {
        _explodeDrone();
      }
    });
  }
}
