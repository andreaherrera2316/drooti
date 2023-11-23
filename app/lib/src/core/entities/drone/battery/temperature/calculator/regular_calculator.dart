import 'package:app/src/core/entities/drone/battery/temperature/calculator/data/increase_percentages.dart';
import 'package:app/src/core/entities/drone/battery/temperature/ibattery_temperature.dart';

import '../../../../game/weather/temperature.dart';
import 'itemperature_calculator.dart';

class RegularCalculator implements ITemperatureCalc {
  RegularCalculator({
    bool isFlying = false,
    Temperature? weatherTemperature,
  })  : percentages = IncreasePercentages(fly: 3, battery: 2, connected: 2),
        _isFlying = isFlying,
        _weather = weatherTemperature ?? Temperature.zero;

  @override
  IncreasePercentages percentages;

  bool _isFlying;
  Temperature _weather;

  IBatteryTemperature? _batteryTemperature;

  @override
  Temperature get weather => _weather;
  @override
  bool get isFlying => _isFlying;

  @override
  set isFlying(bool isFlying) {
    _isFlying = isFlying;
    sendUpdate();
  }

  @override
  set weather(Temperature temperature) {
    _weather = temperature;
    sendUpdate();
  }

  @override
  void sendUpdate() {
    if (_batteryTemperature != null) {
      _batteryTemperature!.setTemperature = getTemperatureAfterIncrease();
    }
  }

  @override
  void sendUpdatesTo(IBatteryTemperature notify) {
    _batteryTemperature = notify;
  }

  @override
  Temperature getTemperatureAfterIncrease() {
    int increase = _getBatteryIncrease() + _getFlyingIncrease();
    return Temperature(increase + weather.temperatureF);
  }

  int _getBatteryIncrease() {
    return _getIncrease(percentages.battery);
  }

  int _getFlyingIncrease() {
    if (isFlying) {
      return _getIncrease(percentages.fly);
    }
    return 0;
  }

  int _getIncrease(int percentage) {
    double percentageMultiplier = percentage / 100;
    int value = weather.temperatureF.abs();
    int degreeMultiplier = value > 30 ? value : 30;
    return (degreeMultiplier * percentageMultiplier).ceil();
  }
}
