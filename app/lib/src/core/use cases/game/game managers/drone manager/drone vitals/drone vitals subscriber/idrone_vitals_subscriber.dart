import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20subscriber/idrone_main_vitals_subscriber.dart';

abstract class IDroneVitalsSubscriber implements IDroneMainVitalsSubscriber {
  void batteryAmpsRemaningUpdate(double amps);
  void batteryAmpsCapacityUpdate(double amps);
  void onBatteryTemperatureUpdate(int temperatureF);
  void onMaxSpeedUpdate(double maxMetersPerS);
}
