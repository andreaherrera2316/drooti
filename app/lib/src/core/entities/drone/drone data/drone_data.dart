import 'package:app/src/core/entities/drone/drone%20data/battery_data.dart';
import 'package:app/src/core/entities/drone/drone%20data/drone_system_data.dart';
import 'package:app/src/core/entities/drone/drone%20data/motor_data.dart';

class DroneData {
  DroneData({
    required BatteryData batteryData,
    required MotorData motorData,
    required DroneSystemData systemData,
  })  : batteryAmps = batteryData.amps,
        batteryMaxTemp = batteryData.maxTemp,
        batteryMinTemp = batteryData.minTemp,
        motorConsumptionPerSec = motorData.consumptionPerSec,
        maxSpeedMetersPerSec = motorData.maxSpeedMetersPerSec,
        systemConsumptionPerSec = systemData.consumptionPerSec;

  int batteryMaxTemp;
  int batteryMinTemp;
  double batteryAmps;
  double systemConsumptionPerSec;
  double motorConsumptionPerSec;
  double maxSpeedMetersPerSec;
}
