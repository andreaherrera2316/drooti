import 'package:app/src/core/entities/drone/battery/temperature/calculator/regular_calculator.dart';
import 'package:app/src/core/entities/drone/battery/temperature/calculator/calc%20recieve%20updates/update_calc_weather.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Calculator connection gets updated whenever there's an updates", () {
    var calculator = RegularCalculator();
    var calcConnection = UpdateCalcWeather(calculator: calculator);

    var temperature = Temperature(100);
    calcConnection.onWeatherUpdate(temperature);
    bool weatherWasSet =
        calculator.weather.temperatureF == temperature.temperatureF;
    expect(weatherWasSet, true);

    temperature.adjustTemperature(20);
    calcConnection.onWeatherUpdate(temperature);
    bool weatherWasUpdated =
        calculator.weather.temperatureF == temperature.temperatureF;
    expect(weatherWasUpdated, true);
  });
}
