import '../../../../../game/weather/temperature.dart';

abstract class ExtremeColdSubscriber {
  onExtremeCold(Temperature batteryTemp, int belowByDegreesF);

  onExtremeColdStopped(Temperature batteryTemp);
}
