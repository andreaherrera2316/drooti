import 'package:app/src/core/use%20cases/sprites/enemy/ienemy.dart';

abstract class IEnemyFactory {
  Future<IEnemy> createEnemy();
}
