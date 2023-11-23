import 'package:app/src/core/entities/drone/flight%20controller/fly%20notifier/fly_subscriber.dart';

class TestFlySubscriber implements FlySubscriber {
  bool flying = false;
  @override
  void onFlyUpdate(bool isFlying) {
    flying = isFlying;
  }
}
