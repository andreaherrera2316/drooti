import 'dart:math';

import 'package:app/src/core/use%20cases/sprites/movement/move_down.dart';
import 'package:app/src/views/screens/game/controller/enemies/iflame_enemy.dart';
import 'package:app/src/core/use%20cases/sprites/movement/imovement.dart';
import 'package:app/src/core/use%20cases/sprites/movement/swing.dart';
import 'package:app/src/core/use%20cases/sprites/position/position_stationary.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

//todo: also there's a lot of repeated code
//which i believe we could pass over to iflame enemy

abstract class SwingingEnemy extends IFlameEnemy {
  SwingingEnemy({
    required this.game,
    required super.artboard,
    required this.pixelsPerMilli,
    required this.swingDegrees,
    this.topToBottom = true,
  }) : _left = Random().nextBool() {
    _setUpMovement();
  }

  bool
      topToBottom; //should be set to true if the games coordinates are top =0 and bottom = gameSize
  double pixelsPerMilli;
  double swingDegrees;
  FlameGame game;
  bool _left;
  bool _active = false;
  bool _collided = false;
  IMovement? _swing;
  IMovement? _down;

  @override
  bool get isActive => _active;

  bool get startLeft => _left;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (isActive && !_collided) {
      _swing?.move();
      _down?.move();
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
    _setAnchor();
    PositionStationary(
      left: _left,
      topToBottom: topToBottom,
      component: this,
      screenHeight: game.size.y,
      screenWidth: game.size.x,
    ).setInitialPosition();
  }

  void _setAnchor() {
    if (_left) {
      anchor = Anchor.bottomLeft;
    } else {
      anchor = Anchor.bottomRight;
    }
  }

  void _setUpMovement() {
    var swing = Swing(
      sprite: this,
      left: _left,
      maxSwingDegrees: swingDegrees,
    );

    _down = MoveDown(sprite: this, pixelsPerMilli: 2);
    //todo: what???
    //do we need this>
    _left = swing.startLeft;
    _swing = swing;
  }
}
