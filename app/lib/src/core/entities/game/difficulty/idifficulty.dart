import 'package:app/src/core/entities/game/difficulty/validation/validate_difficulty.dart';

mixin IDifficulty {
  int _difficulty = 1;
  int get difficulty => _difficulty;

  set difficulty(int newDifficulty) {
    _difficulty = ValidateDifficulty().getValidDifficulty(newDifficulty);
  }

  void increaseDifficulty() {
    int newDifficulty = difficulty + 1;
    difficulty = ValidateDifficulty().getValidDifficulty(newDifficulty);
  }

  void resetDifficulty() {
    difficulty = 1;
  }
}
