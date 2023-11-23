import 'package:app/src/core/entities/drone/battery/resistance/temperature_resistance.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Temperature resistance max can't be smaller than min", () {
    var resistance =
        TemperatureResistance(minTemperature: 59, maxTemperature: 58);
    expect(resistance.maxTemperature > resistance.minTemperature, true);
  });

  test("Temperature resistance max can't be the same as min", () {
    var resistance =
        TemperatureResistance(minTemperature: 59, maxTemperature: 59);
    expect(resistance.maxTemperature > resistance.minTemperature, true);
  });
}
