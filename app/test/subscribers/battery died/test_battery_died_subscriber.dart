import 'package:app/src/core/entities/drone/battery/health/battery%20dies%20notifier/battery_died_subscriber.dart';

class TestBatteryDiedSubscriber implements BatteryDiedSubscriber {
  bool batteryDied = false;

  @override
  onBatteryDeath() {
    batteryDied = true;
  }
}
