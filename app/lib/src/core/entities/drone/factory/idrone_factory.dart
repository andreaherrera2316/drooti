import 'package:app/src/core/entities/drone/drone%20data/drone_data.dart';
import 'package:app/src/core/entities/drone/idrone.dart';

abstract class IDroneFactory {
  IDrone createDrone(DroneData data);
}
