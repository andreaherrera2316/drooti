import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/controller/enemies/artboard%20direction%20/artboard_direction.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/swinging/swinging_enemy.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Umbrella extends SwingingEnemy {
  Umbrella({
    required super.game,
    required super.artboard,
    super.pixelsPerMilli = 2,
    super.topToBottom = true,
    required this.actions,
    required double height,
    required double width,
    super.swingDegrees = 90,
    this.artboardDirection = ArtboardDirection.rightToLeft,
  }) {
    size.x = width;
    size.y = height;
  }

  double motorDamage = 4;

  IGameActions actions;

  @override
  ArtboardDirection artboardDirection;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    _positionArtboard();
    var hit = RectangleHitbox(
      size: Vector2(size.x * 0.6, size.y * 0.8),
      anchor: const Anchor(-0.4, -0.1),
    )..collisionType = CollisionType.passive;
    add(hit);
  }

  @override
  void damage() {
    actions.damageMotor(motorDamage);
  }

  _positionArtboard() {
    if (startLeft && ArtboardDirection.rightToLeft == artboardDirection) {
      angle = 1.57;
    } else {
      angle = 4.71;
    }
  }
}
