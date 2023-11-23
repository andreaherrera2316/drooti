import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/factory/ienemy_factory.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20factories/standard/standard_side_to_side.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20factories/standard/standard_stationary.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20factories/standard/standard_top_to_bottom.dart';
import 'package:flame/game.dart';

abstract class StandardEnemies {
  static IEnemyFactory stationary(IGameActions actions, FlameGame game) =>
      StandardStationary(
        actions: actions,
        game: game,
      );

  static IEnemyFactory sideToSide(IGameActions actions, FlameGame game) =>
      StandardSideToSide(
        actions: actions,
        game: game,
      );

  static IEnemyFactory topToBottom(IGameActions actions, FlameGame game) =>
      StandardTopToBottom(
        actions: actions,
        game: game,
      );
}
