import '../speed/speed.dart';

abstract class ISpeedCalculator {
  Speed get maxSpeedAfterHealth;
  set maxSpeed(Speed speed);
  set health(double health);
}
