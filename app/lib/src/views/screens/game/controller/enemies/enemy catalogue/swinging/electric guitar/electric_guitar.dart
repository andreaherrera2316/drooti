import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/controller/enemies/artboard%20direction%20/artboard_direction.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/swinging/swinging_enemy.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class ElectricGuitar extends SwingingEnemy {
  ElectricGuitar({
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
    _positionArtboard();
  }

  double motorDamage = 4;

  IGameActions actions;

  @override
  ArtboardDirection artboardDirection;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    var guitar = RectangleHitbox(
      size: Vector2(size.x * 0.86, size.y * 0.35),
      anchor: const Anchor(-0.07, -0.45),
    )..collisionType = CollisionType.passive;
    add(guitar);
    var handle = RectangleHitbox(
      size: Vector2(size.x * 0.24, size.y * 0.38),
      anchor: const Anchor(-1.6, -1.3),
    )..collisionType = CollisionType.passive;
    add(handle);
  }

  @override
  void damage() {
    actions.damageMotor(motorDamage);
  }

  _positionArtboard() {
    if (startLeft) {
      angle = 1.57;
    } else {
      angle = 4.71;
    }
  }
}
