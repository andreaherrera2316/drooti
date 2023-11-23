import 'package:app/src/core/entities/drone/battery/power/out%20of%20power%20notifier/out_of_power_subscriber.dart';

class TestOutOfPowerSubscriber implements OutOfPowerSubscriber {
  bool outOfPower = false;

  @override
  onOutOfPower() {
    outOfPower = true;
  }
}
