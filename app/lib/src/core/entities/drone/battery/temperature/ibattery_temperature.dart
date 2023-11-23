import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_notifier.dart';
import 'package:app/src/core/entities/drone/battery/resistance/temperature_resistance.dart';
import 'package:app/src/core/entities/drone/battery/temperature/calculator/itemperature_calculator.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';

abstract class IBatteryTemperature implements ExtremeTemperatureNotifier {
  IBatteryTemperature({
    required this.resistance,
    required this.calculator,
  });

  TemperatureResistance resistance;
  ITemperatureCalc calculator;

  Temperature get temperature;
  set setTemperature(Temperature temperature);
}
