import 'package:app/src/core/entities/drone/battery/power/out%20of%20power%20notifier/out_of_power_notifier.dart';

abstract class IBatteryPower implements OutOfPowerNotifier {
  IBatteryPower({
    required this.ampsCapacity,
  });
  double ampsCapacity;

  double get batteryPercentage;
  double get ampsRemaining;

  void increaseCharge(double amps);
  void decreaseCharge(double amps);
  void reset();
}
