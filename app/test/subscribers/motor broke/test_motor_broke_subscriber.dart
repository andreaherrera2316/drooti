import 'package:app/src/core/entities/drone/motor/motor%20broke%20notifier/motor_broke.subscriber.dart';

class TestMotorBrokeSubscriber implements MotorBrokeSubscriber {
  bool motorBroke = false;
  @override
  onMotorBroke() {
    motorBroke = true;
  }
}
