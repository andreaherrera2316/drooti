import 'package:app/src/core/entities/drone/battery/resistance/temperature_resistance.dart';
import 'package:app/src/core/entities/drone/battery/temperature/battery_temperature.dart';
import 'package:app/src/core/entities/drone/battery/temperature/calculator/regular_calculator.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../subscribers/extreme temperature/test_extreme_temperature_subscriber.dart';

void main() {
  test("Battery temperature is higher than weather/drone temperature ", () {
    var calculator = RegularCalculator();
    var resistance =
        TemperatureResistance(minTemperature: 59, maxTemperature: 122);
    var batteryTemperature =
        BatteryTemperature(calculator: calculator, resistance: resistance);

    Temperature weather = Temperature(100);
    calculator.weather = weather;

    bool greaterThanWeather =
        weather.temperatureF < batteryTemperature.temperature.temperatureF;

    expect(greaterThanWeather, true);
  });

  test("When battery temperature is set it checks for and notifies an overheat",
      () {
    var calculator = RegularCalculator();
    var resistance =
        TemperatureResistance(minTemperature: 59, maxTemperature: 122);
    var batteryTemperature =
        BatteryTemperature(calculator: calculator, resistance: resistance);

    var sub = TestExtremeTemperatureSubscriber();
    batteryTemperature.addExtremeSub(sub);
    batteryTemperature.setTemperature = Temperature(123);

    expect(sub.overheat, true);
  });

  test(
      "When battery temperature is set it checks for and notifies extreme cold",
      () {
    var calculator = RegularCalculator();
    var resistance =
        TemperatureResistance(minTemperature: 59, maxTemperature: 122);
    var batteryTemperature =
        BatteryTemperature(calculator: calculator, resistance: resistance);

    var sub = TestExtremeTemperatureSubscriber();
    batteryTemperature.addExtremeSub(sub);
    batteryTemperature.setTemperature = Temperature(58);

    expect(sub.extremeCold, true);
  });

  //
  test(
      "When battery temperature is set it notifies whenever overheat has stopped",
      () {
    var calculator = RegularCalculator();
    var resistance =
        TemperatureResistance(minTemperature: 59, maxTemperature: 122);
    var batteryTemperature =
        BatteryTemperature(calculator: calculator, resistance: resistance);

    var sub = TestExtremeTemperatureSubscriber();
    batteryTemperature.addExtremeSub(sub);

    batteryTemperature.setTemperature = Temperature(123);
    expect(sub.overheat, true);

    batteryTemperature.setTemperature = Temperature(100);
    expect(sub.overheat, false);
  });

  test(
      "When battery temperature is set it notifies whenever extreme cold has stopped",
      () {
    var calculator = RegularCalculator();
    var resistance =
        TemperatureResistance(minTemperature: 59, maxTemperature: 122);
    var batteryTemperature =
        BatteryTemperature(calculator: calculator, resistance: resistance);

    var sub = TestExtremeTemperatureSubscriber();
    batteryTemperature.addExtremeSub(sub);

    batteryTemperature.setTemperature = Temperature(58);
    expect(sub.extremeCold, true);

    batteryTemperature.setTemperature = Temperature(100);
    expect(sub.extremeCold, false);
  });

  test("Subscribers recieve updates as soon as they are added", () {
    var calculator = RegularCalculator();
    var resistance =
        TemperatureResistance(minTemperature: 59, maxTemperature: 122);
    var batteryTemperature =
        BatteryTemperature(calculator: calculator, resistance: resistance);

    batteryTemperature.setTemperature = Temperature(58);

    var sub = TestExtremeTemperatureSubscriber();
    batteryTemperature.addExtremeSub(sub);
    expect(sub.extremeCold, true);
  });

  test(
      "Subscribers recieve extreme cold stopped even if they were not subscribe when extreme cold happened",
      () {
    var calculator = RegularCalculator();
    var resistance =
        TemperatureResistance(minTemperature: 59, maxTemperature: 122);
    var batteryTemperature =
        BatteryTemperature(calculator: calculator, resistance: resistance);

    batteryTemperature.setTemperature = Temperature(58);

    var sub = TestExtremeTemperatureSubscriber();
    batteryTemperature.addExtremeSub(sub);
    expect(sub.extremeCold, true);
    batteryTemperature.setTemperature = Temperature(100);
    expect(sub.extremeCold, false);
  });

  test(
      "Subscribers recieve overheat stopped even if they were not subscribe when the overheat happened",
      () {
    var calculator = RegularCalculator();
    var resistance =
        TemperatureResistance(minTemperature: 59, maxTemperature: 122);
    var batteryTemperature =
        BatteryTemperature(calculator: calculator, resistance: resistance);

    batteryTemperature.setTemperature = Temperature(123);

    var sub = TestExtremeTemperatureSubscriber();
    batteryTemperature.addExtremeSub(sub);
    expect(sub.overheat, true);
    batteryTemperature.setTemperature = Temperature(100);
    expect(sub.overheat, false);
  });

  test("Subscribers removed stop recieving updates", () {
    var calculator = RegularCalculator();
    var resistance =
        TemperatureResistance(minTemperature: 59, maxTemperature: 122);
    var batteryTemperature =
        BatteryTemperature(calculator: calculator, resistance: resistance);

    batteryTemperature.setTemperature = Temperature(58);

    var sub = TestExtremeTemperatureSubscriber();
    batteryTemperature.addExtremeSub(sub);
    batteryTemperature.setTemperature = Temperature(58);
    expect(sub.extremeCold, true);

    batteryTemperature.setTemperature = Temperature(100);
    expect(sub.extremeCold, false);

    batteryTemperature.removeExtremeSub(sub);

    batteryTemperature.setTemperature = Temperature(123);
    expect(sub.overheat, false);
  });
}
