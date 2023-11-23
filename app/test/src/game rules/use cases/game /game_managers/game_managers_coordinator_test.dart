import 'package:app/src/core/use%20cases/game/game%20managers/manager%20coordinator/game_manager_coordinator.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_manager.dart';

void main() {
  test('you can add a manager', () {
    var coordinator = GameManagerCoordinator();
    var manager = TestManager();
    coordinator.addManager(manager);
    expect(coordinator.gameManagers.contains(manager), true);
  });

  test('you can remove a manager', () {
    var coordinator = GameManagerCoordinator();
    var manager = TestManager();
    coordinator.addManager(manager);
    expect(coordinator.gameManagers.contains(manager), true);
    coordinator.removeManager(manager);
    expect(coordinator.gameManagers.contains(manager), false);
  });

  test('you can add multiple managers', () {
    var coordinator = GameManagerCoordinator();
    List<TestManager> managers = [TestManager(), TestManager(), TestManager()];
    coordinator.addAllManagers(managers);
    for (var manager in managers) {
      expect(coordinator.gameManagers.contains(manager), true);
    }
  });

  test('all managers start when the coordinator starts', () {
    var coordinator = GameManagerCoordinator();
    List<TestManager> managers = [TestManager(), TestManager(), TestManager()];
    coordinator.addAllManagers(managers);
    coordinator.start();
    for (var manager in managers) {
      expect(manager.started, true);
    }
  });

  test('all managers pause when the coordinator starts', () {
    var coordinator = GameManagerCoordinator();
    List<TestManager> managers = [TestManager(), TestManager(), TestManager()];
    coordinator.addAllManagers(managers);
    coordinator.pause();
    for (var manager in managers) {
      expect(manager.paused, true);
    }
  });

  test('all managers resume when the coordinator starts', () {
    var coordinator = GameManagerCoordinator();
    List<TestManager> managers = [TestManager(), TestManager(), TestManager()];
    coordinator.addAllManagers(managers);
    coordinator.resume();
    for (var manager in managers) {
      expect(manager.resumed, true);
    }
  });

  test('all managers restart when the coordinator starts', () {
    var coordinator = GameManagerCoordinator();
    List<TestManager> managers = [TestManager(), TestManager(), TestManager()];
    coordinator.addAllManagers(managers);
    coordinator.restart();
    for (var manager in managers) {
      expect(manager.restarted, true);
    }
  });

  test('all managers end when the coordinator starts', () {
    var coordinator = GameManagerCoordinator();
    List<TestManager> managers = [TestManager(), TestManager(), TestManager()];
    coordinator.addAllManagers(managers);
    coordinator.end();
    for (var manager in managers) {
      expect(manager.ended, true);
    }
  });
}
