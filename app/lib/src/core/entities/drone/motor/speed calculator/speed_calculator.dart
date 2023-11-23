import 'package:app/helper/validate_percent.dart';
import 'package:app/src/core/entities/drone/motor/speed%20calculator/ispeed_calculator.dart';
import 'package:app/src/core/entities/drone/motor/speed/speed.dart';

class SpeedCalculator implements ISpeedCalculator {
  SpeedCalculator(
      {required double health,
      required Speed maxSpeed,
      double affectedPercent = 20})
      : _health = health,
        _maxSpeed = maxSpeed,
        _percentAffectedByHealth = affectedPercent {
    percentAffectedByHealth = _percentAffectedByHealth;
    health = _health;
  }

  double _percentAffectedByHealth;

  double _health;

  Speed _maxSpeed;

  set percentAffectedByHealth(double percent) =>
      _percentAffectedByHealth = ValidatePercent().getPercent(percent);

  @override
  set health(double health) => _health = ValidatePercent().getPercent(health);

  @override
  set maxSpeed(Speed speed) => _maxSpeed = speed;

  @override
  Speed get maxSpeedAfterHealth => Speed(metersPerSec: _metersAfterDecrease());

  double _metersAfterDecrease() {
    var affected = _maxSpeed.metersPerSec * _percentAffectedByHealth / 100;
    var healthDecrease = 100 - _health;
    var amountToDecrease = affected * healthDecrease / 100;
    return _maxSpeed.metersPerSec - amountToDecrease;
  }
}
