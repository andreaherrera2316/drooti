import 'dart:math';

import 'package:app/src/views/screens/game/controller/enemies/iflame_enemy.dart';
import 'package:app/src/core/use%20cases/sprites/movement/fall_off_screen.dart';
import 'package:app/src/core/use%20cases/sprites/movement/imovement.dart';
import 'package:app/src/core/use%20cases/sprites/movement/move_side_to_side.dart';
import 'package:app/src/core/use%20cases/sprites/position/position_side_to_side.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

abstract class SideToSideEnemy extends IFlameEnemy {
  SideToSideEnemy({
    required this.game,
    required super.artboard,
    required this.pixelsPerMilli,
    this.topToBottom = true,
  }) : _left = Random().nextBool() {
    _setUpMovement();
  }

  bool
      topToBottom; //should be set to true if the games coordinates are top =0 and bottom = gameSize
  double pixelsPerMilli;
  FlameGame game;
  bool _active = false;
  bool _collided = false;
  final bool _left;
  IMovement? _moveToSide;
  IMovement? _fall;

  bool get startLeft => _left;

  @override
  bool get isActive => _active;

  bool get shouldFall => true;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (isActive && !_collided) {
      _moveToSide?.move();
    } else if (isActive && _collided && shouldFall) {
      _fall?.move();
    }
  }

  @override
  void addToGame() {
    _initialPosition();
    game.add(this);
    _active = true;
    _collided = false;
  }

  @override
  void removeFromGame() {
    if (_active && parent == game) {
      try {
        removeFromParent();
        _active = false;
      } catch (e) {
        if (parent != null) {
          parent =
              null; //setting parent to null is the same and removing from parent
        }
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (!_collided) {
      _collided = true;
      damage();
    }
  }

  @override
  void moveY(double byPixels) {
    if (topToBottom) {
      position.y -= byPixels;
    } else {
      position.y += byPixels;
    }
    _checkIfExitedScreen();
  }

  @override
  void moveX(double byPixels) {
    super.moveX(byPixels);
    _checkIfExitedScreen();
  }

  void _checkIfExitedScreen() {
    bool exitedBounds = hasExitedScreenBounds(
        posY: position.y,
        posX: position.x,
        spriteH: size.y,
        spriteW: size.x,
        screenH: game.size.y,
        screenW: game.size.x,
        topToBottom: topToBottom);
    if (exitedBounds) {
      removeFromGame();
    }
  }

  void _initialPosition() {
    PositionSideToSide(
      sprite: this,
      screenHeight: game.size.y,
      screenWidth: game.size.x,
      left: _left,
      topToBottom: topToBottom,
    ).setInitialPosition();
  }

  void _setUpMovement() {
    _moveToSide = MoveSideToSide(
      sprite: this,
      left: _left,
      pixelsPerMilli: pixelsPerMilli,
    );

    if (shouldFall) {
      _fall = FallOffScreen(sprite: this, fallLeftToRight: _left);
    }
  }
}
