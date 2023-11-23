import 'package:app/src/core/entities/game/weather/temperature.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Increase Temperature by 1 works", () {
    int temperatureF = 100;
    var temperature = Temperature(temperatureF);
    temperature.adjustTemperature(1);
    expect(temperature.temperatureF, temperatureF + 1);
  });

  test("Decrease Temperature by 1 works", () {
    int temperatureF = 100;
    var temperature = Temperature(temperatureF);
    temperature.adjustTemperature(-1);
    expect(temperature.temperatureF, temperatureF - 1);
  });

  test("Temperature zero will always be the same instance", () {
    var zero1 = Temperature.zero;
    var zero2 = Temperature.zero;
    expect(zero1 == zero2, true);
  });
}
