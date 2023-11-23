import 'package:app/src/core/entities/drone/battery/power/ibattery_power.dart';

abstract class IBatteryPowerState {
  IBatteryPowerState({required this.power});
  IBatteryPower power;
  bool get isOutOfPower;
  bool get fullyCharged;
}
