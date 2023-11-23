import 'dart:math';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/factory/ienemy_factory.dart';
import 'package:app/src/views/screens/game/controller/enemies/iflame_enemy.dart';
import 'package:app/src/views/screens/game/controller/enemies/load_flame_enemy.dart';
import 'package:flame/game.dart';

class WinterEnemies implements IEnemyFactory {
  WinterEnemies({
    required this.actions,
    required this.game,
  }) : _topToBottom = true {
    enemies.addAll([
      _snowball,
      _redFirework,
      _blueFirework,
      _greenFirework,
      _yellowFirework,
    ]);
  }

  IGameActions actions;
  FlameGame game;
  final bool _topToBottom;
  final List<Future<IFlameEnemy> Function()> enemies = [];

  @override
  Future<IFlameEnemy> createEnemy() async {
    Future<IFlameEnemy> Function() randomEnemy =
        enemies[Random().nextInt(enemies.length)];
    return await randomEnemy();
  }

  Future<IFlameEnemy> _snowball() {
    return LoadFlameEnemy().snowball(_topToBottom, actions, game);
  }

  Future<IFlameEnemy> _redFirework() {
    return LoadFlameEnemy().redFirework(_topToBottom, actions, game);
  }

  Future<IFlameEnemy> _blueFirework() {
    return LoadFlameEnemy().blueFirework(_topToBottom, actions, game);
  }

  Future<IFlameEnemy> _greenFirework() {
    return LoadFlameEnemy().greenFirework(_topToBottom, actions, game);
  }

  Future<IFlameEnemy> _yellowFirework() {
    return LoadFlameEnemy().yellowFirework(_topToBottom, actions, game);
  }
}
