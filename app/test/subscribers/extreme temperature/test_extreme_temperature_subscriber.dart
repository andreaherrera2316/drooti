import 'package:app/src/core/entities/drone/battery/temperature/extreme%20temperature%20notifier/extreme_temperature_subscriber.dart';
import 'package:app/src/core/entities/game/weather/temperature.dart';

class TestExtremeTemperatureSubscriber implements ExtremeTemperatureSubscriber {
  bool overheat = false;
  bool extremeCold = false;
  Temperature temperature = Temperature.zero;
  int belowBy = 0;
  int aboveBy = 0;

  @override
  onExtremeCold(Temperature batteryTemp, int belowByDegreesF) {
    extremeCold = true;
    temperature = batteryTemp;
    belowBy = belowByDegreesF;
  }

  @override
  onOverheat(Temperature batteryTemp, int exceededByDegreesF) {
    overheat = true;
    temperature = batteryTemp;
    aboveBy = exceededByDegreesF;
  }

  @override
  onExtremeColdStopped(Temperature batteryTemp) {
    extremeCold = false;
    temperature = batteryTemp;
    belowBy = 0;
  }

  @override
  onOverheatStopped(Temperature batteryTemp) {
    overheat = false;
    temperature = batteryTemp;
    aboveBy = 0;
  }
}
