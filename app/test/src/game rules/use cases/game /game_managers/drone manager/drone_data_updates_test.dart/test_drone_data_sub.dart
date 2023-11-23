import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20subscriber/idrone_vitals_subscriber.dart';

class TestDroneDataSub implements IDroneVitalsSubscriber {
  double batteryAmps = 0;
  double batteryAmpsRemaining = 0;
  double batteryHealth = 0;
  double batteryPercent = 0;
  int batteryTemperature = 0;
  double maxSpeed = 0;
  double motorHealth = 0;

  @override
  void batteryAmpsCapacityUpdate(double amps) {
    batteryAmps = amps;
  }

  @override
  void batteryAmpsRemaningUpdate(double amps) {
    batteryAmpsRemaining = amps;
  }

  @override
  void onBatteryHealthUpdate(double health) {
    batteryHealth = health;
  }

  @override
  void onBatteryPercentUpdate(double batteryPercent) {
    this.batteryPercent = batteryPercent;
  }

  @override
  void onBatteryTemperatureUpdate(int temperatureF) {
    batteryTemperature = temperatureF;
  }

  @override
  void onMaxSpeedUpdate(double maxMetersPerS) {
    maxSpeed = maxMetersPerS;
  }

  @override
  void onMotorHealthUpdate(double health) {
    motorHealth = health;
  }
}
