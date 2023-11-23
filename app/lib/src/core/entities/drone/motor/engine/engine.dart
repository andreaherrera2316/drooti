import 'package:app/helper/validate_percent.dart';
import 'package:app/src/core/entities/drone/motor/engine/iengine.dart';

class Engine implements IEngine {
  Engine({double health = 100}) : _health = health {
    setHealth = health;
  }

  double _health;

  set setHealth(double health) =>
      _health = ValidatePercent().getPercent(health);

  @override
  double get health => _health;

  @override
  adjustHealth([double amount = 1]) {
    setHealth = _health + amount;
  }
}
