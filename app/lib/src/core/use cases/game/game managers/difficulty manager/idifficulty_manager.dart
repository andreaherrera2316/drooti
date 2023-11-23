import 'package:app/src/core/entities/game/difficulty/idifficulty.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/igame_manager.dart';

abstract class IDifficultyManager implements IGameManager {
  void manageDifficulty(IDifficulty difficulty);
  void removeDifficulty(IDifficulty difficulty);
  void manageAllDifficulties(List<IDifficulty> difficulties) {
    for (var difficulty in difficulties) {
      manageDifficulty(difficulty);
    }
  }
}
