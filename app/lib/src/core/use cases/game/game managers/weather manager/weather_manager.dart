import 'package:app/src/core/entities/game/weather/temperature%20updates/iweather_temperature_notifier.dart';
import 'package:app/src/core/entities/game/weather/temperature%20updates/weather_temperature_notifier.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/weather%20manager/iweather_manager.dart';

class WeatherManager extends WeatherTemperatureNotifier
    implements IWeatherManager, IWeatherTemperatureNotifier {
  WeatherManager(int tempInDegreesF)
      : temperature = Temperature(tempInDegreesF);

  Temperature temperature;

  @override
  void setTemperature(int newTemperature) {
    temperature.setTemperature(newTemperature);
    weatherUpdate(temperature);
  }

  @override
  void adjustTemperature(int amount) {
    temperature.adjustTemperature(amount);
    weatherUpdate(temperature);
  }
}
