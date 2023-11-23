import 'package:app/src/core/entities/game/difficulty/validation/validate_difficulty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("difficulty can't be set lower than 1", () {
    var difficulty = ValidateDifficulty().getValidDifficulty(0);
    expect(difficulty, 1);
  });
  test("difficulty can't be set higher than 10", () {
    var difficulty = ValidateDifficulty().getValidDifficulty(11);
    expect(difficulty, 10);
  });
}
