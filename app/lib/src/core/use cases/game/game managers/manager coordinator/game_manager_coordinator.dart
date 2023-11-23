import 'package:app/src/core/use%20cases/game/game%20managers/igame_manager.dart';

class GameManagerCoordinator implements IGameManager {
  List<IGameManager> gameManagers = [];
  @override
  void end() {
    for (var manager in gameManagers) {
      manager.end();
    }
  }

  @override
  void pause() {
    for (var manager in gameManagers) {
      manager.pause();
    }
  }

  @override
  void restart() {
    for (var manager in gameManagers) {
      manager.restart();
    }
  }

  @override
  void resume() {
    for (var manager in gameManagers) {
      manager.resume();
    }
  }

  @override
  void start() {
    for (var manager in gameManagers) {
      manager.start();
    }
  }

  void addAllManagers(List<IGameManager> managers) {
    gameManagers.addAll(managers);
  }

  void addManager(IGameManager manager) {
    gameManagers.add(manager);
  }

  void removeManager(IGameManager manager) {
    gameManagers.remove(manager);
  }
}
