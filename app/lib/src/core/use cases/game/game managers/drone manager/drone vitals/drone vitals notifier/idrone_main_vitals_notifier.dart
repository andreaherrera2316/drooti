import 'package:app/src/core/entities/drone/idrone.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20subscriber/idrone_main_vitals_subscriber.dart';

abstract class IDroneMainVitalsNotifier {
  List<IDroneMainVitalsSubscriber> mainSubs = [];
  set drone(IDrone drone);
  void addMainVitalsSub(IDroneMainVitalsSubscriber sub);
  void removeMainVitalsSub(IDroneMainVitalsSubscriber sub);
  void batteryPercentUpdate();
  void batteryHealthUpdate();
  void motorHealthUpdate();
}
