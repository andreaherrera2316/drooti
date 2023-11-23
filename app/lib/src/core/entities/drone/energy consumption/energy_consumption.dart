import 'package:app/src/core/entities/drone/energy%20consumption/ienergy_consumption.dart';

class EnergyConsumption implements IEnergyConsumption {
  EnergyConsumption({required this.ampsConsumedPerSec});
  @override
  double ampsConsumedPerSec;
}
