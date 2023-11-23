import 'package:app/src/core/entities/drone/drone%20data/drone_data.dart';
import 'package:app/src/core/entities/drone/factory/drone_factory.dart';
import 'package:app/src/core/entities/game/weather/temperature%20updates/iweather_temperature_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20actions/drone_actions_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20notifier/idrone_vitals_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20events/boundaries/output_drone_updates.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20events/drone_game_events.dart';

class DroneManager extends DroneActionsManager {
  DroneManager({
    required this.droneData,
    required this.weatherNotifier,
    required int gameTempInDegreesF,
    required OutputDroneUpdates sendUpdates,
    IDroneVitalsNotifier? notifier,
  }) : super(
          drone: DroneFactory().createDrone(droneData)
            ..addWeatherUpdates(weatherNotifier),
          gameTempInDegreesF: gameTempInDegreesF,
          notifier: notifier,
        ) {
    _setUpUpdates(sendUpdates);
  }

  DroneData droneData;
  IWeatherTemperatureNotifier weatherNotifier;

  late DroneGameEvents _droneGameEvents;

  @override
  void end() {
    super.end();
    drone.removeWeatherUpdates(weatherNotifier);
    _droneGameEvents.unsubscribeToDrone(drone);
  }

  void _setUpUpdates(OutputDroneUpdates output) {
    _droneGameEvents = DroneGameEvents(
        output: output,
        minTempResitance: drone.battery.resistance.minTemperature,
        maxTempResitance: drone.battery.resistance.maxTemperature,
        onDroneDied: end);
    _droneGameEvents.subscribeToDrone(drone);
  }
}
