import 'package:app/src/core/entities/drone/battery/power/ibattery_power.dart';
import 'package:app/src/core/entities/drone/battery/power/state/ibattery_power_state.dart';

class BatteryPowerState implements IBatteryPowerState {
  BatteryPowerState({required this.power});

  @override
  IBatteryPower power;
  @override
  bool get fullyCharged => power.batteryPercentage == 100;

  @override
  bool get isOutOfPower => power.batteryPercentage.round() == 0;
}
