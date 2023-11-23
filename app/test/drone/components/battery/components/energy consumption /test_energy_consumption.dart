import 'package:app/src/core/entities/drone/energy%20consumption/ienergy_consumption.dart';

class TestEnergyConsumption implements IEnergyConsumption {
  TestEnergyConsumption({
    required double ampsConsumedPerMinute,
  }) : ampsConsumedPerMin = ampsConsumedPerMinute;

  double ampsConsumedPerMin;

  @override
  double get ampsConsumedPerSec => ampsConsumedPerMin;
}
