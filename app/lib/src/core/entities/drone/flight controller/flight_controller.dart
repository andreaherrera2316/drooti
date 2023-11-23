import 'package:app/src/core/entities/drone/flight%20controller/fly%20notifier/fly_subscriber.dart';
import 'package:app/src/core/entities/drone/flight%20controller/iflight_controller.dart';

class FlightController implements IFlightController {
  bool _isFlying = false;
  @override
  List<FlySubscriber> flySubs = [];

  @override
  bool get isFlying => _isFlying;

  @override
  fly() {
    if (!_isFlying) {
      _isFlying = true;
      flyUpdate();
    }
  }

  @override
  void flyUpdate() {
    for (var sub in flySubs) {
      sub.onFlyUpdate(_isFlying);
    }
  }

  @override
  stopFlying() {
    if (_isFlying) {
      _isFlying = false;
      flyUpdate();
    }
  }

  @override
  void addFlySub(FlySubscriber sub) {
    flySubs.add(sub);
    sub.onFlyUpdate(_isFlying);
  }

  @override
  void removeFlySub(FlySubscriber sub) {
    flySubs.remove(sub);
  }
}
