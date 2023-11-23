import 'package:app/src/core/entities/drone/battery/health/battery%20dies%20notifier/battery_died_subscriber.dart';
import 'package:app/src/core/entities/drone/battery/health/ibattery_health.dart';
import 'package:app/src/core/entities/drone/battery/power/out%20of%20power%20notifier/out_of_power_subscriber.dart';
import 'package:app/src/core/entities/drone/battery/power/state/battery_power_state.dart';
import 'package:app/src/core/entities/drone/battery/temperature/battery_temperature.dart';
import 'package:app/src/core/entities/drone/battery/temperature/calculator/itemperature_calculator.dart';
import 'package:app/src/core/entities/drone/battery/ibattery.dart';
import 'package:app/src/core/entities/drone/battery/power/ibattery_power.dart';
import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_subscriber.dart';
import 'package:app/src/core/entities/drone/battery/temperature/ibattery_temperature.dart';
import 'package:app/src/core/entities/drone/battery/resistance/temperature_resistance.dart';
import 'package:app/src/core/entities/game/weather/temperature%20updates/iweather_temperature_notifier.dart';
import 'package:app/src/core/entities/drone/flight%20controller/fly%20notifier/fly_notifier.dart';
import 'temperature/calculator/calc recieve updates/update_calc_flight.dart';
import 'temperature/calculator/calc recieve updates/update_calc_weather.dart';

class Battery implements IBattery {
  Battery({
    required this.resistance,
    required IBatteryHealth batteryHealth,
    required IBatteryPower batteryPower,
    required ITemperatureCalc temperatureCalculator,
  })  : _batteryHealth = batteryHealth,
        _batteryPower = batteryPower,
        _powerState = BatteryPowerState(power: batteryPower),
        _batteryTemperature = BatteryTemperature(
            resistance: resistance, calculator: temperatureCalculator) {
    _setUp();
  }

  @override
  TemperatureResistance resistance;

  final IBatteryHealth _batteryHealth;
  final IBatteryPower _batteryPower;
  final IBatteryTemperature _batteryTemperature;
  final BatteryPowerState _powerState;

  UpdateCalcFlight? _updateCalcFlight;
  UpdateCalcWeather? _updateCalcWeather;

  @override
  double get powerPercentage => _batteryPower.batteryPercentage;

  @override
  double get health => _batteryHealth.batteryCapacity;

  @override
  bool get fullyCharged => _powerState.fullyCharged;

  @override
  int get temperatureF => _batteryTemperature.temperature.temperatureF;
  @override
  double get amps => _batteryPower.ampsCapacity;

  @override
  double get ampsRemaining => _batteryPower.ampsRemaining;

  @override
  void decreaseCharge(double amps) {
    _batteryPower.decreaseCharge(amps);
  }

  @override
  void increaseCharge(double amps) {
    _batteryPower.increaseCharge(amps);
  }

  @override
  void adjustHealth([double amount = 1]) {
    _batteryHealth.adjustHealth(amount);
  }

  @override
  void recieveFlyUpdates(FlyNotifier fly) {
    fly.addFlySub(_updateCalcFlight!);
  }

  @override
  void recieveWeatherUpdates(IWeatherTemperatureNotifier weather) {
    weather.addWeatherSub(_updateCalcWeather!);
  }

  @override
  void stopFlyUpdates(FlyNotifier fly) {
    fly.removeFlySub(_updateCalcFlight!);
  }

  @override
  void stopWeatherUpdates(IWeatherTemperatureNotifier weather) {
    weather.removeWeatherSub(_updateCalcWeather!);
  }

  @override
  void reset() {
    _batteryHealth.reset();
    _batteryPower.reset();
  }

  @override
  void subscribeToBatteryDied(BatteryDiedSubscriber sub) =>
      _batteryHealth.addDiedSub(sub);

  @override
  void subscribeToExtremeTemps(ExtremeTemperatureSubscriber sub) =>
      _batteryTemperature.addExtremeSub(sub);

  @override
  void subscribeToOutOfPower(OutOfPowerSubscriber sub) =>
      _batteryPower.addPowerSub(sub);

  @override
  void unsubscribeToBatteryDied(BatteryDiedSubscriber sub) =>
      _batteryHealth.removeDiedSub(sub);

  @override
  void unsubscribeToExtremeTemps(ExtremeTemperatureSubscriber sub) =>
      _batteryTemperature.removeExtremeSub(sub);

  @override
  void unsubscribeToOutOfPower(OutOfPowerSubscriber sub) =>
      _batteryPower.removePowerSub(sub);

  void _setUp() {
    _updateCalcFlight =
        UpdateCalcFlight(calculator: _batteryTemperature.calculator);
    _updateCalcWeather =
        UpdateCalcWeather(calculator: _batteryTemperature.calculator);
    _batteryPower.ampsCapacity =
        _ampsReduceHealth(_batteryPower.ampsCapacity, _batteryHealth);
  }

  static double _ampsReduceHealth(double amps, IBatteryHealth health) {
    double multiplier = health.batteryCapacity / 100;
    double remaining = multiplier * amps;
    if (remaining > 0) {
      return remaining;
    }
    return 0;
  }
}
