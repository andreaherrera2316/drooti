import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/side%20to%20side/baseball/throw_baseball.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/side%20to%20side/side_to_side_enemy.dart';
import 'package:flame/collisions.dart';

class Baseball extends SideToSideEnemy {
  Baseball({
    required super.game,
    required super.artboard,
    super.pixelsPerMilli = 10,
    super.topToBottom = true,
    required this.actions,
    required double height,
    required double width,
  }) : _throwAnimation = ThrowBaseball(artboard: artboard) {
    size.x = width;
    size.y = height;
  }

  double motorDamage = 2;

  IGameActions actions;
  final ThrowBaseball _throwAnimation;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    var hit = CircleHitbox()..collisionType = CollisionType.passive;
    add(hit);
  }

  @override
  void addToGame() {
    super.addToGame();
    _addThrowAnimation();
  }

  @override
  void damage() {
    actions.damageMotor(motorDamage);
  }

  void _addThrowAnimation() {
    artboard.addController(_throwAnimation);
  }
}
