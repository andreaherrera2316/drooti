import 'package:app/src/core/entities/drone/energy%20consumption/ienergy_consumption.dart';
import 'package:app/src/core/entities/drone/motor/motor%20broke%20notifier/motor_broke_notifier.dart';

import 'speed/speed.dart';

abstract class IMotor implements MotorBrokeNotifier {
  IMotor({
    required this.consumption,
  });
  IEnergyConsumption consumption;

  double get health;
  Speed get maxSpeed;

  void adjustHealth(double amount);
  void reset();
}
