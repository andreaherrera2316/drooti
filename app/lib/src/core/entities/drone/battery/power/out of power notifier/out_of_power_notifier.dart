import 'package:app/src/core/entities/drone/battery/power/out%20of%20power%20notifier/out_of_power_subscriber.dart';

abstract class OutOfPowerNotifier {
  List<OutOfPowerSubscriber> powerSubs = [];
  outOfPower();
  addPowerSub(OutOfPowerSubscriber sub);
  removePowerSub(OutOfPowerSubscriber sub);
}
