import 'package:app/src/core/entities/drone/battery/temperature/battery_temperature_notifier_manager.dart';
import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_subscriber.dart';
import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_tracker.dart';
import 'package:app/src/core/entities/drone/battery/temperature/ibattery_temperature.dart';
import 'package:app/src/core/entities/drone/battery/resistance/temperature_resistance.dart';
import 'package:app/src/core/entities/drone/battery/temperature/calculator/itemperature_calculator.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';

class BatteryTemperature
    with ExtremeTemperatureTracker
    implements IBatteryTemperature {
  BatteryTemperature({
    required this.resistance,
    required this.calculator,
  })  : _temperature = calculator.getTemperatureAfterIncrease(),
        _manager = BatteryTemperatureNotifierManager(
            temperature: calculator.getTemperatureAfterIncrease(),
            resistance: resistance) {
    calculator.sendUpdatesTo(this);
  }

  final BatteryTemperatureNotifierManager _manager;

  Temperature _temperature;
  @override
  ITemperatureCalc calculator;
  @override
  TemperatureResistance resistance;

  @override
  Temperature get temperature => _temperature;

  @override
  List<ExtremeTemperatureSubscriber> get extremeSubs => _manager.extremeSubs;
  @override
  set extremeSubs(List<ExtremeTemperatureSubscriber> extremeSubs) {
    _manager.extremeSubs = extremeSubs;
  }

  @override
  set setTemperature(Temperature temperature) {
    _manager.checkPreviousExtremeTemp(_temperature, temperature);
    _temperature = temperature;
    _manager.temperature = _temperature;
    _manager.checkForExtremeTemperature();
  }

  @override
  void addExtremeSub(ExtremeTemperatureSubscriber sub) {
    _manager.addExtremeSub(sub);
  }

  @override
  void notifyOverheat() {
    _manager.notifyOverheat();
  }

  @override
  void onExtremeColdStopped() {
    _manager.onExtremeColdStopped();
  }

  @override
  void onOverheatStopped() {
    _manager.onOverheatStopped();
  }

  @override
  void notifyExtremeCold() {
    _manager.notifyExtremeCold();
  }

  @override
  void removeExtremeSub(ExtremeTemperatureSubscriber sub) {
    _manager.removeExtremeSub(sub);
  }
}
