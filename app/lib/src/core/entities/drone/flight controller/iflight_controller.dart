import 'package:app/src/core/entities/drone/flight%20controller/fly%20notifier/fly_notifier.dart';

abstract class IFlightController implements FlyNotifier {
  bool get isFlying;
  fly();
  stopFlying();
}
