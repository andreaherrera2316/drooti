import 'package:app/src/core/entities/drone/idrone.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20notifier/idrone_main_vitals_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20subscriber/idrone_main_vitals_subscriber.dart';

class DroneMainVitalsNotifier implements IDroneMainVitalsNotifier {
  IDrone? _drone;

  @override
  set drone(IDrone drone) {
    _drone = drone;
  }

  @override
  List<IDroneMainVitalsSubscriber> mainSubs = [];

  @override
  void motorHealthUpdate() {
    for (var sub in mainSubs) {
      sub.onMotorHealthUpdate(_drone?.motor.health ?? 0);
    }
  }

  @override
  void batteryHealthUpdate() {
    for (var sub in mainSubs) {
      sub.onBatteryHealthUpdate(_drone?.battery.health ?? 0);
    }
  }

  @override
  void batteryPercentUpdate() {
    for (var sub in mainSubs) {
      sub.onBatteryPercentUpdate(_drone?.battery.powerPercentage ?? 0);
    }
  }

  @override
  void addMainVitalsSub(IDroneMainVitalsSubscriber sub) {
    mainSubs.add(sub);
    _sendUpdatesToNewSub(sub);
  }

  @override
  void removeMainVitalsSub(IDroneMainVitalsSubscriber sub) {
    mainSubs.remove(sub);
  }

  void _sendUpdatesToNewSub(IDroneMainVitalsSubscriber sub) {
    sub.onBatteryHealthUpdate(_drone?.battery.health ?? 0);
    sub.onBatteryPercentUpdate(_drone?.battery.powerPercentage ?? 0);
    sub.onMotorHealthUpdate(_drone?.motor.health ?? 0);
  }
}
