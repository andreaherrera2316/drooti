import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/side%20to%20side/side_to_side_enemy.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/side%20to%20side/snowball/disintegrate_snowball.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/side%20to%20side/snowball/throw_snowball.dart';
import 'package:flame/collisions.dart';

class Snowball extends SideToSideEnemy {
  Snowball({
    required super.game,
    required super.artboard,
    super.pixelsPerMilli = 10,
    super.topToBottom = true,
    required this.actions,
    required double height,
    required double width,
  }) : _throwAnimation = ThrowSnowball(artboard: artboard) {
    size.x = width;
    size.y = height;
  }

  double motorDamage = 1;
  int affectByDegrees = -3;

  IGameActions actions;
  final ThrowSnowball _throwAnimation;

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
    _animateOnCollision();
    actions.damageMotor(motorDamage);
    actions.adjustWeather(affectByDegrees);
  }

  void _addThrowAnimation() {
    artboard.addController(_throwAnimation);
  }

  void _animateOnCollision() {
    _removeThrowAnimation();
    _runDisintegrateAnimation();
  }

  void _removeThrowAnimation() {
    artboard.removeController(_throwAnimation);
  }

  void _runDisintegrateAnimation() {
    var animation = DisintegrateSnowball(artboard: artboard);
    animation.onDeactivated = () {
      removeFromGame();
    };
    artboard.addController(animation);
  }
}
