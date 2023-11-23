import 'package:app/src/core/entities/drone/battery/ibattery.dart';

abstract class IBatteryFactory {
  IBattery createBattery(int minTemperature, int maxTemperature, double amps);
}
