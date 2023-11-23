import 'package:app/src/core/entities/drone/energy%20consumption/ienergy_consumption.dart';
import 'package:app/src/core/entities/drone/battery/ibattery.dart';
import 'package:app/src/core/entities/drone/motor/imotor.dart';
import 'package:app/src/core/entities/game/weather/temperature%20updates/iweather_temperature_notifier.dart';
import 'flight controller/iflight_controller.dart';

abstract class IDrone {
  IDrone({
    required this.systemConsumption,
    required this.battery,
    required this.flight,
    required this.motor,
  });

  IEnergyConsumption systemConsumption;
  IBattery battery;
  IFlightController flight;
  IMotor motor;

  void adjustMotorHealth(double amount);
  void adjustBatteryHealth(double amount);

  void increaseCharge(double amps);
  void decreaseCharge(double amps);

  void fly() {
    flight.fly();
  }

  void stopFlying() {
    flight.stopFlying();
  }

  void addWeatherUpdates(IWeatherTemperatureNotifier weather);
  void removeWeatherUpdates(IWeatherTemperatureNotifier weather);

  void reset() {
    flight.stopFlying();
    battery.reset();
    motor.reset();
  }
}
