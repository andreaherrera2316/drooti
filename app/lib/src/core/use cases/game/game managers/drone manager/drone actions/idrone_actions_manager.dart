import 'package:app/helper/percentage_in_amount.dart';
import 'package:app/src/core/entities/drone/idrone.dart';
import 'package:app/src/core/entities/game/drone/idrone_actions.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/igame_manager.dart';

abstract class IDroneActionsManager implements IDroneActions, IGameManager {
  IDroneActionsManager({
    required this.drone,
  });
  IDrone drone;

  @override
  void fly() {
    drone.fly();
  }

  @override
  void stopFlying() {
    drone.stopFlying();
  }

  @override
  void damageBattery([double amount = 1]) {
    amount = amount.abs() * -1;
    drone.adjustBatteryHealth(amount);
  }

  @override
  void repairBattery([double amount = 1]) {
    amount = amount.abs();
    drone.adjustBatteryHealth(amount);
  }

  @override
  void damageMotor([double amount = 1]) {
    amount = amount.abs() * -1;
    drone.adjustMotorHealth(amount);
  }

  @override
  void repairMotor([double amount = 1]) {
    amount = amount.abs();
    drone.adjustMotorHealth(amount);
  }

  @override
  void increaseChargeByPercent(double percent) {
    var amps = PercentageInAmount()
        .getAmount(percent: percent, totalAmount: drone.battery.amps);
    drone.battery.increaseCharge(amps);
  }

  @override
  void decreaseCharge(double amps) {
    drone.battery.decreaseCharge(amps);
  }
}
