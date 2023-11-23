import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';

class TestGameActions implements IGameActions {
  double batteryHealth = 100;
  double motorHealth = 100;
  double chargePercent = 100;
  int weather = 80;

  @override
  void damageBattery([double percent = 1]) {
    batteryHealth -= percent;
  }

  @override
  void damageMotor([double percent = 1]) {
    motorHealth -= percent;
  }

  @override
  void increaseChargeByPercent(double percent) {
    chargePercent += percent;
  }

  @override
  void repairBattery([double percent = 1]) {
    batteryHealth += percent;
  }

  @override
  void repairMotor([double percent = 1]) {
    motorHealth += percent;
  }

  @override
  void adjustWeather([int amount = 1]) {
    weather += amount;
  }

  reset() {
    batteryHealth = 100;
    motorHealth = 100;
    chargePercent = 100;
    weather = 80;
  }
}
