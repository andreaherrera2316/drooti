import 'package:app/src/core/entities/drone/motor/motor%20broke%20notifier/motor_broke.subscriber.dart';

abstract class MotorBrokeNotifier {
  List<MotorBrokeSubscriber> motorSubs = [];
  void addMotorSub(MotorBrokeSubscriber sub);
  void removeMotorSub(MotorBrokeSubscriber sub);
  void motorBroke();
}
