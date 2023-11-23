import 'package:app/src/core/entities/drone/battery/factory/battery_factory.dart';
import 'package:app/src/core/entities/drone/drone%20data/drone_data.dart';
import 'package:app/src/core/entities/drone/factory/idrone_factory.dart';
import 'package:app/src/core/entities/drone/energy%20consumption/energy_consumption.dart';
import 'package:app/src/core/entities/drone/flight%20controller/flight_controller.dart';
import 'package:app/src/core/entities/drone/motor/motor.dart';
import 'package:app/src/core/entities/drone/motor/speed/speed.dart';
import 'package:app/src/core/entities/drone/drone.dart';
import 'package:app/src/core/entities/drone/idrone.dart';

class DroneFactory extends IDroneFactory {
  @override
  IDrone createDrone(DroneData data) {
    var systemConsumption =
        EnergyConsumption(ampsConsumedPerSec: data.systemConsumptionPerSec);
    var motorConsumption =
        EnergyConsumption(ampsConsumedPerSec: data.motorConsumptionPerSec);
    var maxSpeed = Speed(metersPerSec: data.maxSpeedMetersPerSec);
    var motor = Motor(consumption: motorConsumption, maxSpeed: maxSpeed);
    var flight = FlightController();
    var battery = RegularBatteryFactory().createBattery(
        data.batteryMinTemp, data.batteryMaxTemp, data.batteryAmps);

    return Drone(
        systemConsumption: systemConsumption,
        battery: battery,
        flight: flight,
        motor: motor);
  }
}
