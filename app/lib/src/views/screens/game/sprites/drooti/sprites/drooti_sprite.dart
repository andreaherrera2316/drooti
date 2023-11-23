import 'dart:async';

import 'package:app/src/core/use%20cases/sprites/drooti/idrooti_sprite.dart';
import 'package:app/src/core/use%20cases/sprites/power%20ups/ipower_up.dart';
import 'package:app/src/views/screens/game/components/drooti/animations/drooti_animations.dart';
import 'package:app/src/views/screens/game/components/sprites/drooti/animations/catalogue/flying_animation.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';

class DrootiSprite extends RiveComponent
    with CollisionCallbacks
    implements IDrootiSprite {
  DrootiSprite({required this.drootiArtboard, required double drootiSize})
      : flying = FlyingAnimation(artboard: drootiArtboard),
        animations = DrootiAnimations(),
        super(
          artboard: drootiArtboard,
        ) {
    size = Vector2.all(drootiSize);
    flying.isActive = false;
    artboard.addController(flying);
  }

  Artboard drootiArtboard;
  bool _isGoingRight = false;
  bool _isGoingLeft = false;
  double _rotation = 0;
  final double _maxRotation = 0.35;
  RiveAnimationController flying;
  DrootiAnimations animations;

  //todo: check drone action after death
  //ok should be make the drone fall off the screen?

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    var head = CircleHitbox(
      radius: size.x * 0.28,
      anchor: const Anchor(-0.35, -0.45),
    );
    add(head);
  }

  @override
  onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is IPowerUp) {
      powerUp();
    } else {
      collide();
    }
  }

  @override
  void breakDown() {
    animations.breakDown(artboard);
  }

  @override
  void collide() {
    animations.collide(artboard);
  }

  @override
  void explode() {
    animations.explode(artboard);
  }

  @override
  void freeze() {
    animations.freeze(artboard);
  }

  @override
  void powerUp() {
    animations.powerUp(artboard);
  }

  @override
  void quantumSpeed() {
    animations.quantumSpeed(artboard);
  }

  @override
  void takeOff() {
    animations.takeOff(artboard);
  }

  ///Movement
  @override
  void moveDrooti(double xcoordinate, double ycoordinate) {
    _rotateDrooti(
      position.x,
      xcoordinate,
    );
    position = Vector2(xcoordinate, ycoordinate);
  }

  bool _isMovingLeft(atX, toX) => toX < atX;

  bool _isMovingRight(atX, toX) => toX > atX;

  void _setAngle() => angle = _rotation;

  void _rotateDrooti(atX, toX) {
    bool turnedLeft = _isMovingLeft(atX, toX);
    bool turnedRight = _isMovingRight(atX, toX);

    if (turnedLeft) {
      _turnLeft();
      return;
    }

    if (turnedRight) {
      _turnRight();
    }
  }

  void _turnLeft() {
    if (!_isGoingLeft) {
      _isGoingLeft = true;
      _isGoingRight = false;
    }

    _rotateLeft();
    _setAngle();
  }

  void _turnRight() {
    if (!_isGoingRight) {
      _isGoingRight = true;
      _isGoingLeft = false;
    }

    _rotateRight();
    _setAngle();
  }

  void _rotateLeft() {
    bool wasRotatedRight = _rotation > 0;
    if (wasRotatedRight) {
      _rotation -= 0.01;
    }

    bool belowMaxRotation = _rotation > (_maxRotation * -1);
    if (belowMaxRotation) {
      _rotation -= 0.007;
    }
  }

  void _rotateRight() {
    bool wasRotatedLeft = _rotation < 0;
    if (wasRotatedLeft) {
      _rotation += 0.01;
    }
    bool belowMaxRotation = _rotation < _maxRotation;
    if (belowMaxRotation) {
      _rotation += 0.007;
    }
  }
}
