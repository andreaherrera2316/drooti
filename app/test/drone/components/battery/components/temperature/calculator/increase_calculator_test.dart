import 'package:app/src/core/entities/drone/battery/temperature/calculator/regular_calculator.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Battery temperature should be higher than weather", () {
    var weather = Temperature(100);
    var calculator = RegularCalculator(weatherTemperature: weather);

    bool increasesWhenTurnedOn =
        calculator.getTemperatureAfterIncrease().temperatureF >
            weather.temperatureF;
    expect(increasesWhenTurnedOn, true);
  });

  test("Battery temperature increases if the drone is flying and turned on",
      () {
    var weather = Temperature(100);
    var calculator = RegularCalculator(weatherTemperature: weather);
    int whenTurnedOn = calculator.getTemperatureAfterIncrease().temperatureF;

    calculator.isFlying = true;
    int whenFlying = calculator.getTemperatureAfterIncrease().temperatureF;

    expect(whenFlying > whenTurnedOn, true);
  });

  test("Battery temperature increases if the temperature is 0", () {
    var weather = Temperature.zero;
    var calculator = RegularCalculator(weatherTemperature: weather);
    bool increased = calculator.getTemperatureAfterIncrease().temperatureF >
        weather.temperatureF;
    expect(increased, true);
  });

  test("Battery temperature increases if the temperature is negative", () {
    var weather = Temperature(-10);
    var calculator = RegularCalculator(weatherTemperature: weather);
    bool increased = calculator.getTemperatureAfterIncrease().temperatureF >
        weather.temperatureF;
    expect(increased, true);
  });
}
