import 'package:app/src/core/entities/drone/idrone.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20events/boundaries/output_drone_updates.dart';

abstract class InputDroneUpdates {
  InputDroneUpdates({required this.output});
  OutputDroneUpdates output;
  void subscribeToDrone(IDrone drone);
  void unsubscribeToDrone(IDrone drone);
}
