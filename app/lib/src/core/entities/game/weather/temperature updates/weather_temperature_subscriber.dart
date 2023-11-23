import 'package:app/src/core/entities/game/weather/temperature.dart';

abstract class WeatherTemperatureSubscriber {
  void onWeatherUpdate(Temperature temperature);
}
