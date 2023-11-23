import 'package:app/src/core/entities/drone/battery/temperature/calculator/data/increase_percentages.dart';
import 'package:app/src/core/entities/drone/battery/temperature/ibattery_temperature.dart';

import '../../../../game/weather/temperature.dart';

abstract class ITemperatureCalc {
  ITemperatureCalc({
    required this.percentages,
  });
  IncreasePercentages percentages;

  bool get isFlying;
  Temperature get weather;

  set isFlying(bool isFlying);
  set weather(Temperature temperature);

  Temperature getTemperatureAfterIncrease();
  void sendUpdate();
  void sendUpdatesTo(IBatteryTemperature batteryTemperature);
}
