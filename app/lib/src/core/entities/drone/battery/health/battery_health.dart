import 'package:app/helper/validate_percent.dart';
import 'package:app/src/core/entities/drone/battery/health/battery%20dies%20notifier/battery_died_subscriber.dart';
import 'package:app/src/core/entities/drone/battery/health/ibattery_health.dart';

class BatteryHealth implements IBatteryHealth {
  BatteryHealth({
    double? initialCapacity,
  }) : _batteryCapacity = ValidatePercent().getPercent(initialCapacity ?? 100);

  double _batteryCapacity;
  @override
  List<BatteryDiedSubscriber> diedSubs = [];

  @override
  double get batteryCapacity => _batteryCapacity;

  set _setBatteryCapacity(double capacity) =>
      _batteryCapacity = ValidatePercent().getPercent(capacity);

  @override
  void adjustHealth([double amount = 1]) {
    _setBatteryCapacity = _batteryCapacity + amount;
    if (_batteryCapacity == 0) {
      batteryDied();
    }
  }

  @override
  void addDiedSub(BatteryDiedSubscriber sub) {
    diedSubs.add(sub);
    bool batteryIsDead = _batteryCapacity == 0;
    if (batteryIsDead) {
      sub.onBatteryDeath();
    }
  }

  @override
  void batteryDied() {
    for (var sub in diedSubs) {
      sub.onBatteryDeath();
    }
  }

  @override
  void removeDiedSub(BatteryDiedSubscriber sub) {
    diedSubs.remove(sub);
  }

  @override
  void reset() {
    _setBatteryCapacity = 100;
  }
}
