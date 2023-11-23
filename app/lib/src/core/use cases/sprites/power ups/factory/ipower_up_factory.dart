import 'package:app/src/core/use%20cases/sprites/power%20ups/ipower_up.dart';

abstract class IPowerUpFactory {
  Future<IPowerUp> createPowerUp();
}
