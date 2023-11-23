import '../../../../game/weather/temperature.dart';
import '../../resistance/temperature_resistance.dart';

mixin ExtremeTemperatureTracker {
  bool checkOverheat(
      TemperatureResistance resistance, Temperature temperature) {
    int maxTemperature = resistance.maxTemperature;
    if (temperature.temperatureF > maxTemperature) {
      return true;
    }

    return false;
  }

  int getMaxTemperatureExceededBy(
      TemperatureResistance resistance, Temperature temperature) {
    int exceededMaxBy = temperature.temperatureF - resistance.maxTemperature;
    if (exceededMaxBy > 0) {
      return exceededMaxBy;
    }
    return 0;
  }

  bool checkExtremeCold(
      TemperatureResistance resistance, Temperature temperature) {
    int minTemperature = resistance.minTemperature;
    if (temperature.temperatureF < minTemperature) {
      return true;
    }

    return false;
  }

  int getMinTemperatureBelowBy(
      TemperatureResistance resistance, Temperature temperature) {
    int belowMinBy = resistance.minTemperature - temperature.temperatureF;
    if (belowMinBy > 0) {
      return belowMinBy;
    }
    return 0;
  }

  bool checkOverheatStopped(Temperature previous, Temperature current,
      TemperatureResistance resistance) {
    bool hadOverheat = checkOverheat(resistance, previous);
    bool notHotAnymore = !checkOverheat(resistance, current);
    if (hadOverheat && notHotAnymore) {
      return true;
    }
    return false;
  }

  bool checkExtremeColdStopped(Temperature previous, Temperature current,
      TemperatureResistance resistance) {
    bool wasExtremelyCold = checkExtremeCold(resistance, previous);
    bool notColdAnymore = !checkExtremeCold(resistance, current);
    if (wasExtremelyCold && notColdAnymore) {
      return true;
    }
    return false;
  }
}
