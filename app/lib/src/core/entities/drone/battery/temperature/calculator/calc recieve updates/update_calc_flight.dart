import 'package:app/src/core/entities/drone/battery/temperature/calculator/itemperature_calculator.dart';
import 'package:app/src/core/entities/drone/flight%20controller/fly%20notifier/fly_subscriber.dart';

class UpdateCalcFlight implements FlySubscriber {
  UpdateCalcFlight({
    required this.calculator,
  });

  ITemperatureCalc calculator;
  bool _isFlying = false;

  @override
  void onFlyUpdate(bool isFlying) {
    _isFlying = isFlying;
    calculator.isFlying = _isFlying;
  }
}
