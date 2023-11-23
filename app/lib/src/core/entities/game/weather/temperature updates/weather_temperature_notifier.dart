import 'package:app/src/core/entities/game/weather/temperature%20updates/iweather_temperature_notifier.dart';
import 'package:app/src/core/entities/game/weather/temperature%20updates/weather_temperature_subscriber.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';

class WeatherTemperatureNotifier implements IWeatherTemperatureNotifier {
  @override
  List<WeatherTemperatureSubscriber> weatherSubs = [];

  @override
  void addWeatherSub(WeatherTemperatureSubscriber sub) {
    weatherSubs.add(sub);
  }

  @override
  void removeWeatherSub(WeatherTemperatureSubscriber sub) {
    weatherSubs.remove(sub);
  }

  @override
  void weatherUpdate(Temperature temperature) {
    // Notify all the weather subscribers about the weather update event.
    for (var sub in weatherSubs) {
      sub.onWeatherUpdate(temperature);
    }
  }
}
