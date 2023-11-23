import 'package:app/src/core/entities/game/difficulty/idifficulty.dart';

abstract class IPowerUpGenerator with IDifficulty {
  void generatePowerUp();
  void reset();
  void start();
  void pause();
}
