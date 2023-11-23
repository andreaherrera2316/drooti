import 'package:app/src/core/entities/game/difficulty/idifficulty.dart';

abstract class IEnemyGenerator with IDifficulty {
  void generateEnemy();
  void reset();
  void start();
  void pause();
}
