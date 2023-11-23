import 'package:app/src/core/use%20cases/game/game%20managers/difficulty%20manager/difficulty_manager.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../entities/game/difficulty/test_difficulty.dart';

DifficultyManager get gameDifficultyManager =>
    DifficultyManager.seconds(increaseEverySeconds: 1);

void main() {
  test("game manager keep track of the difficulties to manage", () {
    var diff1 = TestDifficulty();
    var manager = gameDifficultyManager;
    manager.manageDifficulty(diff1);

    bool addedDifficulties = manager.difficulties.contains(diff1);
    expect(addedDifficulties, true);
  });

  test("game manager keep can remove difficulties to manage", () {
    var diff1 = TestDifficulty();
    var manager = gameDifficultyManager;
    manager.manageDifficulty(diff1);
    bool addedDifficulty = manager.difficulties.contains(diff1);
    expect(addedDifficulty, true);
    manager.removeDifficulty(diff1);
    bool removedDifficulty = !manager.difficulties.contains(diff1);
    expect(removedDifficulty, true);
  });

  test("game manager increases difficulty every x seconds", () async {
    var diff1 = TestDifficulty();
    var manager = gameDifficultyManager;
    manager.manageDifficulty(diff1);
    manager.start();

    await Future.delayed(const Duration(seconds: 1), () {
      expect(diff1.difficulty, 2);
    });
  });

  test("game manager restarts difficulty", () async {
    var diff1 = TestDifficulty();
    var manager = gameDifficultyManager;
    manager.manageDifficulty(diff1);
    manager.start();

    await Future.delayed(const Duration(seconds: 2, milliseconds: 100), () {
      expect(diff1.difficulty, 3);
      manager.restart();
      expect(diff1.difficulty, 1);
    });
  });

  test("game manager doesn't increase difficulty while paused", () async {
    var diff1 = TestDifficulty();
    var manager = gameDifficultyManager;
    var secs2 = const Duration(seconds: 2, milliseconds: 100);
    manager.manageDifficulty(diff1);
    manager.start();

    await Future.delayed(secs2, () async {
      expect(diff1.difficulty, 3);
      manager.pause();
      await Future.delayed(secs2, () {
        expect(diff1.difficulty, 3);
      });
    });
  });

  test("game manager increases difficulty after it has been paused and resumes",
      () async {
    var diff1 = TestDifficulty();
    var manager = gameDifficultyManager;
    var secs2 = const Duration(seconds: 2, milliseconds: 100);
    manager.manageDifficulty(diff1);
    manager.start();

    await Future.delayed(secs2, () async {
      expect(diff1.difficulty, 3);
      manager.pause();
      await Future.delayed(secs2, () async {
        expect(diff1.difficulty, 3);
        manager.resume();
        await Future.delayed(secs2, () {
          expect(diff1.difficulty, 5);
        });
      });
    });
  });

  test("stops increasing difficulties when game ends", () async {
    var diff1 = TestDifficulty();
    var manager = gameDifficultyManager;
    var secs2 = const Duration(seconds: 2, milliseconds: 100);
    manager.manageDifficulty(diff1);
    manager.start();

    await Future.delayed(secs2, () async {
      manager.end();
      expect(diff1.difficulty, 3);
      await Future.delayed(secs2, () async {
        expect(diff1.difficulty, 3);
      });
    });
  });

  test(
      "stops increasing difficulties when game ends and does not continue when resume is called",
      () async {
    var diff1 = TestDifficulty();
    var manager = gameDifficultyManager;
    var secs2 = const Duration(seconds: 2, milliseconds: 100);
    manager.manageDifficulty(diff1);
    manager.start();

    await Future.delayed(secs2, () async {
      manager.end();
      expect(diff1.difficulty, 3);
      manager.resume();
      await Future.delayed(secs2, () async {
        expect(diff1.difficulty, 3);
      });
    });
  });
}



// test("game manager keep track of the difficulties to manage", () {
//     var diff1 = DifficultyTest();
//     var diff2 = DifficultyTest(2);
//     gameDifficultyManager.manageDifficulty(diff1);
//     gameDifficultyManager.manageDifficulty(diff2);
//     bool addedDifficulties =
//         gameDifficultyManager.difficulties.contains(diff1) &&
//             gameDifficultyManager.difficulties.contains(diff2);
//     expect(addedDifficulties, true);
//   });
