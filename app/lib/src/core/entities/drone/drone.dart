import 'package:app/src/core/entities/drone/idrone.dart';
import 'package:app/src/core/entities/game/weather/temperature%20updates/iweather_temperature_notifier.dart';

class Drone extends IDrone {
  Drone({
    required super.systemConsumption,
    required super.battery,
    required super.flight,
    required super.motor,
  });

  @override
  void addWeatherUpdates(IWeatherTemperatureNotifier weather) {
    battery.recieveWeatherUpdates(weather);
    battery.recieveFlyUpdates(flight);
  }

  @override
  void removeWeatherUpdates(IWeatherTemperatureNotifier weather) {
    battery.stopWeatherUpdates(weather);
    battery.stopFlyUpdates(flight);
  }

  //todo: okay how will this affect the drone
  //i think it will be fine
  // void _setUp() {
  //   battery.recieveFlyUpdates(flight);
  // }

  @override
  void adjustMotorHealth(double amount) {
    motor.adjustHealth(amount);
  }

  @override
  void adjustBatteryHealth(double amount) {
    battery.adjustHealth(amount);
  }

  @override
  void decreaseCharge(double amps) {
    battery.increaseCharge(amps);
  }

  @override
  void increaseCharge(double amps) {
    battery.decreaseCharge(amps);
  }
}
