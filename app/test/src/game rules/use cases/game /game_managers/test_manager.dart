import 'package:app/src/core/use%20cases/game/game%20managers/igame_manager.dart';

class TestManager implements IGameManager {
  bool started = false;
  bool paused = false;
  bool resumed = false;
  bool restarted = false;
  bool ended = false;

  @override
  void end() {
    ended = true;
  }

  @override
  void pause() {
    paused = true;
  }

  @override
  void restart() {
    restarted = true;
  }

  @override
  void resume() {
    resumed = true;
  }

  @override
  void start() {
    started = true;
  }
}
