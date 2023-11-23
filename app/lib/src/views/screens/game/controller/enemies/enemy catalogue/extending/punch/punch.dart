import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/core/use%20cases/sprites/drooti/animations/ianimation.dart';
import 'package:app/src/views/screens/game/controller/enemies/artboard%20direction%20/artboard_direction.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/extending_enemy.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/punch/draw_back_punch.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/punch/extend_punch.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Punch extends ExtendingEnemy {
  Punch({
    required super.game,
    required super.artboard,
    super.pixelsPerMilli = 2,
    super.topToBottom = true,
    required this.actions,
    required double height,
    required double width,
    this.artboardDirection = ArtboardDirection.leftToRight,
  }) {
    size.x = width;
    size.y = height;
  }

  double motorDamage = 4;
  IGameActions actions;
  IAnimation? _extendAnimation;
  IAnimation? _drawBackAnimation;

  @override
  ArtboardDirection artboardDirection;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    var punch = CircleHitbox(
      radius: size.y * 0.42,
      anchor: const Anchor(-2.5, -0.2),
    )..collisionType = CollisionType.passive;
    var gloveBottom = RectangleHitbox(
      size: Vector2(size.x * 0.3, size.y * 0.4),
      anchor: const Anchor(-1.6, -0.7),
    )..collisionType = CollisionType.passive;
    add(punch);
    add(gloveBottom);

    if (reversedArtboard) {
      rotate(180);
    }
  }

  @override
  void damage() {
    if (isExtended) {
      actions.damageMotor(motorDamage);
    }
  }

  @override
  void drawback() {
    _drawBackAnimation ??=
        DrawBackPunch(artboard: artboard, onActivated: super.drawback);

    _drawBackAnimation?.play();
  }

  @override
  void extend() {
    _extendAnimation ??=
        ExtendPunch(artboard: artboard, onDeactivated: super.extend);
    _extendAnimation?.play();
  }

  @override
  bool get reversedArtboard => !startLeft;
}
