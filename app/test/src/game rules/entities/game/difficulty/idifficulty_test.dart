import 'package:flutter_test/flutter_test.dart';

import 'test_difficulty.dart';

void main() {
  test("increase difficulty works", () {
    var difficulty = TestDifficulty();
    expect(difficulty.difficulty, 1);
    difficulty.increaseDifficulty();
    expect(difficulty.difficulty, 2);
  });

  test("reset difficulty works", () {
    var difficulty = TestDifficulty();
    expect(difficulty.difficulty, 1);
    difficulty.increaseDifficulty();
    expect(difficulty.difficulty, 2);
    difficulty.resetDifficulty();
    expect(difficulty.difficulty, 1);
  });

  test("difficulty can't be increased above 10", () {
    var difficulty = TestDifficulty();
    expect(difficulty.difficulty, 1);
    for (var i = 0; i < 10; i++) {
      difficulty.increaseDifficulty();
    }
    expect(difficulty.difficulty, 10);
    difficulty.difficulty = 20;
    expect(difficulty.difficulty, 10);
  });

  test("difficulty can be set", () {
    var difficulty = TestDifficulty();
    expect(difficulty.difficulty, 1);
    difficulty.difficulty = 10;
    expect(difficulty.difficulty, 10);
  });

  test("difficulty can't be set higher than 10", () {
    var difficulty = TestDifficulty();
    expect(difficulty.difficulty, 1);
    difficulty.difficulty = 30;
    expect(difficulty.difficulty, 10);
  });
}
