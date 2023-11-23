import 'package:app/src/core/entities/drone/battery/temperature/calculator/itemperature_calculator.dart';
import 'package:app/src/core/entities/game/weather/temperature%20updates/weather_temperature_subscriber.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';

class UpdateCalcWeather implements WeatherTemperatureSubscriber {
  UpdateCalcWeather({
    required this.calculator,
  });

  ITemperatureCalc calculator;
  Temperature _weatherTemperature = Temperature.zero;

  @override
  void onWeatherUpdate(Temperature weather) {
    _weatherTemperature = weather;
    calculator.weather = _weatherTemperature;
  }
}
