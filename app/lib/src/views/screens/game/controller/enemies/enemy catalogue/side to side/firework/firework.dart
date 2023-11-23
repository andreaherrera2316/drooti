import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/side%20to%20side/firework/explode_firework.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/side%20to%20side/side_to_side_enemy.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Firework extends SideToSideEnemy {
  Firework({
    required super.game,
    required super.artboard,
    super.pixelsPerMilli = 10,
    super.topToBottom = true,
    required this.actions,
    required double height,
    required double width,
  }) {
    size.x = width;
    size.y = height;
  }

  double motorDamage = 2;
  int affectByDegrees = 5;

  IGameActions actions;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    var hit = RectangleHitbox(
      size: Vector2(size.x * 0.45, size.y * 0.75),
      anchor: const Anchor(-0.55, 0),
    )..collisionType = CollisionType.passive;
    add(hit);

    _positionArtboard();
  }

  @override
  void damage() {
    _animateOnCollision();
    actions.damageMotor(motorDamage);
    actions.adjustWeather(affectByDegrees);
  }

  @override
  bool get shouldFall => false;

  void _animateOnCollision() {
    _runDisintegrateAnimation();
  }

  void _runDisintegrateAnimation() {
    var animation = ExplodeFirework(artboard: artboard);
    animation.onDeactivated = () {
      removeFromGame();
    };
    artboard.addController(animation);
  }

  _positionArtboard() {
    if (startLeft) {
      angle = 1.57;
    } else {
      angle = 4.71;
    }
  }
}
