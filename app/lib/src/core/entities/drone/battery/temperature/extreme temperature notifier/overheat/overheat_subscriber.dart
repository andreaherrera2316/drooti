import '../../../../../game/weather/temperature.dart';

abstract class OverheatSubscriber {
  onOverheat(Temperature batteryTemp, int exceededByDegreesF);
  onOverheatStopped(Temperature batteryTemp);
}
