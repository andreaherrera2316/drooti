import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/top%20to%20bottom/top_to_bottom_enemy.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Piano extends TopToBottomEnemy {
  Piano({
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

  double motorDamage = 6;

  IGameActions actions;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    var hitSize = Vector2(size.x * 0.9, size.y * 0.5);
    var hit = RectangleHitbox(
      size: hitSize,
      anchor: const Anchor(-0.1, -0.6),
    )..collisionType = CollisionType.passive;

    add(hit);
  }

  @override
  void damage() {
    actions.damageMotor(motorDamage);
  }
}
