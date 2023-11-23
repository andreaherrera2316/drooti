import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20events/drone_game_events.dart';

import 'output_drone_updates_mock.dart';

class DroneGameEventsMock extends DroneGameEvents {
  bool onDroneDiedCalled = false;

  DroneGameEventsMock({
    required OutputDroneUpdatesMock output,
    required int minTempResitance,
    required int maxTempResitance,
  }) : super(
            output: output,
            minTempResitance: minTempResitance,
            maxTempResitance: maxTempResitance);

  @override
  void Function()? get onDroneDied => () {
        onDroneDiedCalled = true;
      };
}
