import 'dart:math';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/factory/ienemy_factory.dart';
import 'package:app/src/views/screens/game/controller/enemies/iflame_enemy.dart';
import 'package:app/src/views/screens/game/controller/enemies/load_flame_enemy.dart';
import 'package:flame/game.dart';

class StandardTopToBottom implements IEnemyFactory {
  StandardTopToBottom({
    required this.actions,
    required this.game,
  }) : _topToBottom = true {
    enemies.addAll([
      _log,
      _piano,
      _pinata,
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

  Future<IFlameEnemy> _log() {
    return LoadFlameEnemy().log(_topToBottom, actions, game);
  }

  Future<IFlameEnemy> _piano() {
    return LoadFlameEnemy().piano(_topToBottom, actions, game);
  }

  Future<IFlameEnemy> _pinata() {
    return LoadFlameEnemy().pinata(_topToBottom, actions, game);
  }
}
