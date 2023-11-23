import 'package:app/src/core/entities/game/weather/temperature.dart';

import 'weather_temperature_subscriber.dart';

abstract class IWeatherTemperatureNotifier {
  List<WeatherTemperatureSubscriber> weatherSubs = [];

  void weatherUpdate(Temperature temperature);
  void addWeatherSub(WeatherTemperatureSubscriber sub);
  void removeWeatherSub(WeatherTemperatureSubscriber sub);
}
