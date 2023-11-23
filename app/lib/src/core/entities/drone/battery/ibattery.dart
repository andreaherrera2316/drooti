import 'package:app/src/core/entities/drone/battery/health/battery%20dies%20notifier/battery_died_subscriber.dart';
import 'package:app/src/core/entities/drone/battery/resistance/temperature_resistance.dart';
import 'package:app/src/core/entities/drone/flight%20controller/fly%20notifier/fly_notifier.dart';
import 'package:app/src/core/entities/game/weather/temperature%20updates/iweather_temperature_notifier.dart';
import 'package:app/src/core/entities/drone/battery/power/out%20of%20power%20notifier/out_of_power_subscriber.dart';
import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_subscriber.dart';

abstract class IBattery {
  IBattery({
    required this.resistance,
  });

  TemperatureResistance resistance;

  bool get fullyCharged;
  double get powerPercentage;
  double get health;
  double get amps;
  double get ampsRemaining;
  int get temperatureF;
  void reset();
  void increaseCharge(double amps);
  void decreaseCharge(double amps);
  void adjustHealth(double amount);

  void recieveFlyUpdates(FlyNotifier fly);
  void recieveWeatherUpdates(IWeatherTemperatureNotifier weather);
  void subscribeToBatteryDied(BatteryDiedSubscriber sub);
  void subscribeToExtremeTemps(ExtremeTemperatureSubscriber sub);
  void subscribeToOutOfPower(OutOfPowerSubscriber sub);

  void stopFlyUpdates(FlyNotifier fly);
  void stopWeatherUpdates(IWeatherTemperatureNotifier weather);
  void unsubscribeToBatteryDied(BatteryDiedSubscriber sub);
  void unsubscribeToExtremeTemps(ExtremeTemperatureSubscriber sub);
  void unsubscribeToOutOfPower(OutOfPowerSubscriber sub);
}
