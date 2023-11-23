import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/core/use%20cases/sprites/drooti/animations/ianimation.dart';
import 'package:app/src/views/screens/game/controller/enemies/artboard%20direction%20/artboard_direction.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/extending_enemy.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/hair%20dryer/blow_dryer.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/hair%20dryer/start_blowing_dryer.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/hair%20dryer/stop_blowing_dryer.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

//todo
//Animations need revision
//And either mirror or just use left to right

class HairDryer extends ExtendingEnemy {
  HairDryer({
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
    _setUpBlowing();
  }

  double motorDamage = 4;
  IGameActions actions;
  Function? stopBlowing;
  IAnimation? _extendAnimation;
  IAnimation? _drawBackAnimation;
  IAnimation? _blowAnimation;

  @override
  ArtboardDirection artboardDirection;

  @override
  void addToGame() {
    super.addToGame();
    _blowAnimation?.play();
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    var punch = RectangleHitbox(
      size: Vector2(size.x * 0.55, size.y * 0.7),
      anchor: const Anchor(-0.81, -0.22),
    )..collisionType = CollisionType.passive;

    add(punch);

    if (reversedArtboard) {
      rotate(180);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    stopBlowing?.call();
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
        StopBlowingDryer(artboard: artboard, onActivated: super.drawback);
    stopBlowing?.call();
    _drawBackAnimation?.play();
  }

  @override
  void extend() {
    _extendAnimation ??= StartBlowingDryer(
        artboard: artboard,
        onDeactivated: () {
          super.extend();
          _blowAnimation?.play();
        });
    _extendAnimation?.play();
  }

  @override
  bool get reversedArtboard => !startLeft;

  void _setUpBlowing() {
    var blow = BlowDryer(artboard: artboard);
    stopBlowing = blow.stop;
    _blowAnimation = blow;
  }
}
