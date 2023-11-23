import 'package:app/src/core/entities/drone/battery/health/battery%20dies%20notifier/battery_died_subscriber.dart';

abstract class BatteryDiedNotifier {
  List<BatteryDiedSubscriber> diedSubs = [];

  addDiedSub(BatteryDiedSubscriber sub);
  removeDiedSub(BatteryDiedSubscriber sub);
  batteryDied();
}
