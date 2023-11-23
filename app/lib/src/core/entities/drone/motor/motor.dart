import 'package:app/src/core/entities/drone/energy%20consumption/ienergy_consumption.dart';
import 'package:app/src/core/entities/drone/motor/engine/engine.dart';
import 'package:app/src/core/entities/drone/motor/imotor.dart';
import 'package:app/src/core/entities/drone/motor/motor%20broke%20notifier/motor_broke.subscriber.dart';
import 'package:app/src/core/entities/drone/motor/speed%20calculator/ispeed_calculator.dart';
import 'package:app/src/core/entities/drone/motor/speed%20calculator/speed_calculator.dart';
import 'package:app/src/core/entities/drone/motor/speed/speed.dart';

import 'engine/iengine.dart';

class Motor implements IMotor {
  Motor({
    required this.consumption,
    required Speed maxSpeed,
    double motorHealth = 100,
  })  : engine = Engine(health: motorHealth),
        calculator = SpeedCalculator(health: motorHealth, maxSpeed: maxSpeed);

  IEngine engine;
  ISpeedCalculator calculator;
  @override
  IEnergyConsumption consumption;
  @override
  List<MotorBrokeSubscriber> motorSubs = [];

  set maxSpeed(Speed speed) {
    calculator.maxSpeed = speed;
  }

  @override
  Speed get maxSpeed => calculator.maxSpeedAfterHealth;

  @override
  double get health => engine.health;

  @override
  adjustHealth([double amount = 1]) {
    engine.adjustHealth(amount);
    if (_motorBroke) {
      motorBroke();
    }
  }

  @override
  void reset() {
    calculator.health = 100;
    engine.adjustHealth(100);
  }

  @override
  void addMotorSub(MotorBrokeSubscriber sub) {
    motorSubs.add(sub);
    if (_motorBroke) {
      sub.onMotorBroke();
    }
  }

  @override
  void removeMotorSub(MotorBrokeSubscriber sub) {
    motorSubs.remove(sub);
  }

  @override
  void motorBroke() {
    for (var sub in motorSubs) {
      sub.onMotorBroke();
    }
  }

  bool get _motorBroke => health == 0;
}
