import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/core/use%20cases/sprites/drooti/animations/ianimation.dart';
import 'package:app/src/views/screens/game/controller/enemies/artboard%20direction%20/artboard_direction.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/extending_enemy.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/yoyo/draw_back_yoyo.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/yoyo/extend_yoyo.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/yoyo/roll_yoyo.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Yoyo extends ExtendingEnemy {
  Yoyo({
    required super.game,
    required super.artboard,
    super.pixelsPerMilli = 2,
    super.topToBottom = true,
    required this.actions,
    required double height,
    required double width,
    this.artboardDirection = ArtboardDirection.rightToLeft,
  }) {
    size.x = width;
    size.y = height;
    _setUpRolling();
  }

  double motorDamage = 4;
  IGameActions actions;
  Function? stopRolling;
  IAnimation? _extendAnimation;
  IAnimation? _drawBackAnimation;
  IAnimation? _rollingAnimation;

  @override
  ArtboardDirection artboardDirection;

  @override
  void addToGame() {
    super.addToGame();
    _rollingAnimation?.play();
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    var punch = CircleHitbox(
      radius: size.y * 0.42,
      anchor: const Anchor(-0.05, -0.2),
    )..collisionType = CollisionType.passive;

    add(punch);

    if (reversedArtboard) {
      rotate(180);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    stopRolling?.call();
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
        DrawBackYoyo(artboard: artboard, onActivated: super.drawback);
    stopRolling?.call();
    _drawBackAnimation?.play();
  }

  @override
  void extend() {
    _extendAnimation ??= ExtendYoyo(
        artboard: artboard,
        onDeactivated: () {
          super.extend();
          _rollingAnimation?.play();
        });
    _extendAnimation?.play();
  }

  @override
  bool get reversedArtboard => startLeft;

  void _setUpRolling() {
    var roll = RollYoyo(artboard: artboard);
    stopRolling = roll.stop;
    _rollingAnimation = roll;
  }
}
