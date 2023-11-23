import 'package:app/src/core/entities/game/drone/idrone_actions.dart';

class TestDroneActions implements IDroneActions {
  bool damagedBattery = false;
  bool damagedMotor = false;
  bool decreasedCharge = false;
  bool increasedChargeByPercent = false;
  bool repairedBattery = false;
  bool repairedMotor = false;
  bool flight = false;
  bool stoppedFlight = false;

  @override
  void damageBattery([double amount = 1]) {
    damagedBattery = true;
  }

  @override
  void damageMotor([double amount = 1]) {
    damagedMotor = true;
  }

  @override
  void decreaseCharge(double amps) {
    decreasedCharge = true;
  }

  @override
  void increaseChargeByPercent(double percent) {
    increasedChargeByPercent = true;
  }

  @override
  void repairBattery([double amount = 1]) {
    repairedBattery = true;
  }

  @override
  void repairMotor([double amount = 1]) {
    repairedMotor = true;
  }

  @override
  void fly() {
    flight = true;
  }

  @override
  void stopFlying() {
    stoppedFlight = true;
  }
}
