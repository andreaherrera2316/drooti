import 'package:app/src/core/entities/drone/battery/battery.dart';
import 'package:app/src/core/entities/drone/battery/health/battery_health.dart';
import 'package:app/src/core/entities/drone/battery/power/battery_power.dart';
import 'package:app/src/core/entities/drone/battery/resistance/temperature_resistance.dart';
import 'package:app/src/core/entities/drone/battery/temperature/calculator/regular_calculator.dart';
import 'package:app/src/core/entities/drone/battery/factory/ibattery_factory.dart';
import 'package:app/src/core/entities/drone/battery/ibattery.dart';

class RegularBatteryFactory implements IBatteryFactory {
  @override
  IBattery createBattery(
    int minTemperature,
    int maxTemperature,
    double amps, {
    double? health,
    double? ampsRemaining,
  }) {
    var resistance = TemperatureResistance(
        minTemperature: minTemperature, maxTemperature: maxTemperature);
    var batteryHealth = BatteryHealth(initialCapacity: health);
    var batteryPower = BatteryPower(amps: amps, ampsRemaining: ampsRemaining);
    var regularCalculator = RegularCalculator();
    return Battery(
        batteryHealth: batteryHealth,
        batteryPower: batteryPower,
        resistance: resistance,
        temperatureCalculator: regularCalculator);
  }
}
