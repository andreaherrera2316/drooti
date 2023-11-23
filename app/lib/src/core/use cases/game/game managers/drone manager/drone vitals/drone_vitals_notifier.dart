import 'package:app/src/core/entities/drone/idrone.dart';
import 'package:app/src/core/entities/game/weather/temperature%20updates/weather_temperature_subscriber.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20notifier/idrone_vitals_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20subscriber/idrone_vitals_subscriber.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone_main_vitals_notifier.dart';

class DroneVitalsNotifier extends DroneMainVitalsNotifier
    implements IDroneVitalsNotifier, WeatherTemperatureSubscriber {
  DroneVitalsNotifier();

  IDrone? _drone;
  @override
  List<IDroneVitalsSubscriber> vitalsSubs = [];
  @override
  set drone(IDrone drone) {
    super.drone = drone;
    _drone = drone;
  }

  @override
  void addVitalsSub(IDroneVitalsSubscriber sub) {
    vitalsSubs.add(sub);
    mainSubs.add(sub);
    _sendUpdatesToNewSub(sub);
  }

  @override
  void removeVitalsSub(IDroneVitalsSubscriber sub) {
    mainSubs.remove(sub);
    vitalsSubs.remove(sub);
  }

  @override
  void batteryAmpsCapacityUpdate() {
    for (var sub in vitalsSubs) {
      sub.batteryAmpsCapacityUpdate(_drone?.battery.amps ?? 0);
    }
  }

  @override
  void batteryAmpsRemaningUpdate() {
    for (var sub in vitalsSubs) {
      sub.batteryAmpsRemaningUpdate(_drone?.battery.ampsRemaining ?? 0);
    }
  }

  @override
  void batteryTemperatureUpdate() {
    for (var sub in vitalsSubs) {
      sub.onBatteryTemperatureUpdate(_drone?.battery.temperatureF ?? 0);
    }
  }

  @override
  void maxSpeedUpdate() {
    for (var sub in vitalsSubs) {
      sub.onMaxSpeedUpdate(_drone?.motor.maxSpeed.metersPerSec ?? 0);
    }
  }

  @override
  void onWeatherUpdate(Temperature temperature) {
    batteryTemperatureUpdate();
  }

  void _sendUpdatesToNewSub(IDroneVitalsSubscriber sub) {
    sub.batteryAmpsCapacityUpdate(_drone?.battery.amps ?? 0);
    sub.batteryAmpsRemaningUpdate(_drone?.battery.ampsRemaining ?? 0);
    sub.onBatteryTemperatureUpdate(_drone?.battery.temperatureF ?? 0);
    sub.onMaxSpeedUpdate(_drone?.motor.maxSpeed.metersPerSec ?? 0);
  }
}
