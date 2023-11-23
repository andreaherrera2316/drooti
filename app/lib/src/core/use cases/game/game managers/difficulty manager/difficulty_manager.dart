import 'dart:async';

import 'package:app/src/core/entities/game/difficulty/idifficulty.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/difficulty%20manager/idifficulty_manager.dart';

class DifficultyManager extends IDifficultyManager {
  DifficultyManager(
      {this.increaseDifficultyEvery = const Duration(seconds: 20)});
  DifficultyManager.seconds({int increaseEverySeconds = 20})
      : increaseDifficultyEvery = Duration(seconds: increaseEverySeconds);
  Duration increaseDifficultyEvery;

  List<IDifficulty> difficulties = [];

  bool _pause = false;
  bool _cancel = false;

  @override
  void manageDifficulty(IDifficulty difficulty) {
    difficulties.add(difficulty);
  }

  @override
  void removeDifficulty(IDifficulty difficulty) {
    difficulties.remove(difficulty);
  }

  @override
  void start() {
    _cancel = false;
    _pause = false;
    _increaseDifficultyPeriodically();
  }

  @override
  void end() {
    _cancel = true;
  }

  @override
  void pause() {
    _pause = true;
  }

  @override
  void restart() {
    _cancel = true;
    for (var difficulty in difficulties) {
      difficulty.resetDifficulty();
    }
  }

  @override
  void resume() {
    _pause = false;
  }

  _increaseDifficultyPeriodically() {
    Timer.periodic(increaseDifficultyEvery, (timer) {
      if (_cancel) {
        timer.cancel();
      }

      if (!_pause) {
        _increaseDifficulties();
      }
    });
  }

  _increaseDifficulties() {
    if (!_cancel) {
      for (var difficulty in difficulties) {
        difficulty.increaseDifficulty();
      }
    }
  }
}
