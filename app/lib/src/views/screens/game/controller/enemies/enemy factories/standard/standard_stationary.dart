import 'dart:math';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/factory/ienemy_factory.dart';
import 'package:app/src/views/screens/game/controller/enemies/iflame_enemy.dart';
import 'package:app/src/views/screens/game/controller/enemies/load_flame_enemy.dart';
import 'package:flame/game.dart';

class StandardStationary implements IEnemyFactory {
  StandardStationary({
    required this.actions,
    required this.game,
  }) : _topToBottom = true {
    enemies.addAll([
      _electricGuitar,
      _umbrella,
      _saw,
      _punch,
      _yoyo,
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

  Future<IFlameEnemy> _electricGuitar() {
    return LoadFlameEnemy().electricGuitar(_topToBottom, actions, game);
  }

  Future<IFlameEnemy> _umbrella() {
    return LoadFlameEnemy().umbrella(_topToBottom, actions, game);
  }

  Future<IFlameEnemy> _saw() {
    return LoadFlameEnemy().saw(_topToBottom, actions, game);
  }

  Future<IFlameEnemy> _punch() {
    return LoadFlameEnemy().punch(_topToBottom, actions, game);
  }

  Future<IFlameEnemy> _yoyo() {
    return LoadFlameEnemy().yoyo(_topToBottom, actions, game);
  }

  // Future<IFlameEnemy> _hairDryer() async {
  //   return LoadFlameEnemy().hairDryer(
  // }
}
