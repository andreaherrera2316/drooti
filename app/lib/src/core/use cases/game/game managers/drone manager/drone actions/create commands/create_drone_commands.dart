import 'package:app/resources/commands/ongoing_command.dart';
import 'package:app/src/core/entities/drone/idrone.dart';
import 'package:app/src/core/entities/game/drone/idrone_actions.dart';

import '../../../../../../entities/drone/battery/health/commands/on_extreme_temp_reduce_capacity.dart';
import '../../../../../../entities/drone/battery/power/commands/decrease_flight_consumption.dart';
import '../../../../../../entities/drone/battery/power/commands/decrease_system_consumption.dart';

class CreateDroneCommands {
  CreateDroneCommands({
    required this.drone,
    required this.droneActions,
    this.executeEverySeconds = 1,
    this.onExtremeTemperature,
  });

  IDrone drone;
  IDroneActions droneActions;
  int executeEverySeconds;
  void Function()? onExtremeTemperature;

  List<OngoingCommand> get getCommands =>
      [_flightConsumption, _systemConsumption, _reduceCapacityOnExtremeTemps];

  OngoingCommand get _flightConsumption {
    var flightCommand = DecreaseFlightConsumption(
      seconds: executeEverySeconds,
      flightConsumption: drone.motor.consumption,
      droneActions: droneActions,
    );
    drone.flight.addFlySub(flightCommand);
    return flightCommand;
  }

  OngoingCommand get _systemConsumption => DecreaseSystemConsumption(
        seconds: executeEverySeconds,
        systemConsumption: drone.systemConsumption,
        droneActions: droneActions,
      );

  OngoingCommand get _reduceCapacityOnExtremeTemps {
    var extremeTempCommand = OnExtremeTempReduceCapacity(
        droneActions: droneActions, onExtremeTemp: onExtremeTemperature);

    drone.battery.subscribeToExtremeTemps(extremeTempCommand);

    return extremeTempCommand;
  }
}
