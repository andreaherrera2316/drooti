import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20notifier/idrone_main_vitals_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20subscriber/idrone_vitals_subscriber.dart';

abstract class IDroneVitalsNotifier implements IDroneMainVitalsNotifier {
  List<IDroneVitalsSubscriber> vitalsSubs = [];
  void addVitalsSub(IDroneVitalsSubscriber sub);
  void removeVitalsSub(IDroneVitalsSubscriber sub);
  void batteryAmpsRemaningUpdate();
  void batteryAmpsCapacityUpdate();
  void batteryTemperatureUpdate();
  void maxSpeedUpdate();
}
