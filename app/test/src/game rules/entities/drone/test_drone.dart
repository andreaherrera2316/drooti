import 'package:app/src/core/entities/drone/drone%20data/battery_data.dart';
import 'package:app/src/core/entities/drone/drone%20data/drone_data.dart';
import 'package:app/src/core/entities/drone/drone%20data/drone_system_data.dart';
import 'package:app/src/core/entities/drone/drone%20data/motor_data.dart';
import 'package:app/src/core/entities/drone/factory/drone_factory.dart';
import 'package:app/src/core/entities/drone/idrone.dart';

class TestDrone {
  TestDrone() : _drone = DroneFactory().createDrone(_droneData);
  static final _droneData = DroneData(
      batteryData: BatteryData(maxTemp: 122, minTemp: 39, amps: 1200),
      motorData: MotorData(maxSpeedMetersPerSec: 16, consumptionPerSec: 10),
      systemData: DroneSystemData(consumptionPerSec: 5));

  final IDrone _drone;
  IDrone get drone => _drone;
}
