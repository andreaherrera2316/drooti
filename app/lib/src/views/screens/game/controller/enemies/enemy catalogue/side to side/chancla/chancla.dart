import 'dart:async';
import 'dart:ui';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/side%20to%20side/side_to_side_enemy.dart';
import 'package:app/src/core/use%20cases/sprites/movement/spin.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Chancla extends SideToSideEnemy {
  Chancla({
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

  double motorDamage = 3;
  IGameActions actions;
  Spin? _spin;
  bool _shouldSpin = false;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    var hit = RectangleHitbox()..collisionType = CollisionType.passive;
    add(hit);
    _spin = Spin(sprite: this, spinLeft: startLeft);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (_shouldSpin) {
      _spin?.move();
    }
  }

  @override
  void addToGame() {
    super.addToGame();
    _startSpinning();
  }

  @override
  void damage() {
    actions.damageMotor(motorDamage);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    _reverseSpin();
  }

  void _startSpinning() {
    _shouldSpin = true;
  }

  void _reverseSpin() {
    _spin?.spinLeft = !_spin!.spinLeft;
  }
}
