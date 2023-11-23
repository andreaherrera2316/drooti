import 'package:app/src/core/entities/drone/battery/power/ibattery_power.dart';
import 'package:app/src/core/entities/drone/battery/power/out%20of%20power%20notifier/out_of_power_subscriber.dart';

import '../../../../../../helper/percentage_in_amount.dart';
import '../../../../../../helper/val_within_limit.dart';

class BatteryPower implements IBatteryPower {
  BatteryPower({
    required double amps,
    double? ampsRemaining,
  })  : _ampsCapacity = amps,
        _ampsRemaining = ampsRemaining ?? amps;

  double _ampsCapacity;
  double _ampsRemaining;

  @override
  double get ampsRemaining => _ampsRemaining;

  @override
  double get ampsCapacity => _ampsCapacity;
  @override
  set ampsCapacity(double amps) {
    var newCapacity = ValWithinLimit().getValue(value: amps, min: 0);
    _ampsRemaining = PercentageInAmount()
        .getAmount(percent: batteryPercentage, totalAmount: newCapacity);
    _ampsCapacity = newCapacity;
  }

  @override
  double get batteryPercentage {
    double percentage = _ampsRemaining / _ampsCapacity * 100;
    double downToOneDecimalPlace = double.parse(percentage.toStringAsFixed(1));
    return downToOneDecimalPlace;
  }

  @override
  void decreaseCharge(double decrease) {
    decrease = decrease.abs();
    bool isGreaterThanZero = (_ampsRemaining - decrease) > 0;
    if (isGreaterThanZero) {
      _ampsRemaining -= decrease;
      return;
    }

    _ampsRemaining = 0;

    if (_outOfPower) {
      outOfPower();
    }
  }

  @override
  void increaseCharge(double increase) {
    increase = increase.abs();
    bool canIncrease = (_ampsRemaining + increase) < _ampsCapacity;
    if (canIncrease) {
      _ampsRemaining += increase;
      return;
    }

    _ampsRemaining = _ampsCapacity;
  }

  @override
  List<OutOfPowerSubscriber> powerSubs = [];

  @override
  outOfPower() {
    for (var sub in powerSubs) {
      sub.onOutOfPower();
    }
  }

  @override
  addPowerSub(OutOfPowerSubscriber sub) {
    powerSubs.add(sub);
    if (_outOfPower) {
      sub.onOutOfPower();
    }
  }

  @override
  removePowerSub(OutOfPowerSubscriber sub) {
    powerSubs.remove(sub);
  }

  bool get _outOfPower => ampsRemaining == 0;

  @override
  void reset() {
    _ampsRemaining = _ampsCapacity;
  }
}
