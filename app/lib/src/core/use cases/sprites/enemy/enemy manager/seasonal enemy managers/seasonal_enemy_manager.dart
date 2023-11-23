import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/generator/iseasonal_generator.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/enemy%20manager/ienemy_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/imeter_limits_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/seasons%20notifier/seasons_notifier.dart';
import 'package:app/src/core/use%20cases/sprites/isprite_displayer.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20factories/standard/standard_enemies.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20factories/summer/summer_enemies.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20factories/winter/winter_enemies.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/generator/seasonal%20enemy%20generator/standard_enemies_generator.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/generator/seasonal%20enemy%20generator/summer_enemies_generator.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/generator/seasonal%20enemy%20generator/winter_enemies_generator.dart';
import 'package:flame/game.dart';

class SeasonalEnemyManager implements IEnemyManager {
  SeasonalEnemyManager({
    required IGameActions gameActions,
    required FlameGame game,
    required this.seasonsNotifier,
    required IMeterLimitsNotifier limitsNotifier,
    ISpriteDisplayer? displayer,
  }) {
    _setUpEnemyManagers(gameActions, game, displayer, limitsNotifier);
  }

  List<ISeasonalGenerator> generators = [];
  SeasonsNotifier seasonsNotifier;

  @override
  void start() {
    _subscribeGenerators();
  }

  @override
  void end() {
    _unsubscribeGenerators();
  }

  @override
  void pause() {
    for (var generator in generators) {
      generator.pause();
    }
  }

  @override
  void resume() {
    for (var generator in generators) {
      generator.start();
    }
  }

  @override
  void restart() {
    for (var generator in generators) {
      generator.reset();
    }
  }

  void _setUpEnemyManagers(IGameActions gameActions, FlameGame game,
      ISpriteDisplayer? displayer, IMeterLimitsNotifier limitsNotifier) {
    var stationary = StandardEnemies.stationary(gameActions, game);
    var topToBottom = StandardEnemies.topToBottom(gameActions, game);
    var sideToSide = StandardEnemies.sideToSide(gameActions, game);
    generators.addAll([
      StandardEnemiesManager(
        stationary: stationary,
        topToBottom: topToBottom,
        sideToSide: sideToSide,
        limitsNotifier: limitsNotifier,
        displayer: displayer,
      ),
      WinterEnemiesManager(
        sideToSide: WinterEnemies(actions: gameActions, game: game),
        limitsNotifier: limitsNotifier,
        displayer: displayer,
      ),
      SummerEnemiesManager(
        sideToSide: SummerEnemies(actions: gameActions, game: game),
        limitsNotifier: limitsNotifier,
        displayer: displayer,
      )
    ]);
  }

  void _subscribeGenerators() {
    for (var generator in generators) {
      seasonsNotifier.addSeasonSub(generator);
    }
  }

  void _unsubscribeGenerators() {
    for (var generator in generators) {
      seasonsNotifier.removeSeasonSub(generator);
    }
  }
}
