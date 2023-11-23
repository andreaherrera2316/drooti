import 'dart:math';

import 'package:app/src/core/use%20cases/sprites/movement/imovement.dart';
import 'package:app/src/core/use%20cases/sprites/movement/move_down.dart';
import 'package:app/src/views/screens/game/controller/enemies/iflame_enemy.dart';
import 'package:app/src/core/use%20cases/sprites/position/position_stationary.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'dart:async' as asy;

import 'package:flutter/foundation.dart';

abstract class ExtendingEnemy extends IFlameEnemy {
  ExtendingEnemy({
    required this.game,
    required super.artboard,
    required this.pixelsPerMilli,
    this.topToBottom = true,
    this.extendDuration = const Duration(milliseconds: 1800),
  }) : _left = Random().nextBool() {
    _setUpMovement();
  }

  bool
      topToBottom; //should be set to true if the games coordinates are top =0 and bottom = gameSize
  double pixelsPerMilli;
  FlameGame game;
  Duration extendDuration;
  bool _active = false;
  bool _collided = false;
  bool _extended = true;
  final bool _left;
  IMovement? _down;

  @override
  bool get isActive => _active;

  bool get startLeft => _left;

  bool get isExtended => _extended;

  bool get reversedArtboard;

  @mustCallSuper
  void extend() {
    _extended = true;
  }

  @mustCallSuper
  void drawback() {
    _extended = false;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (isActive && !_collided) {
      _down?.move();
    }
    _checkIfExitedScreen();
  }

  @override
  void addToGame() {
    _initialPosition();
    game.add(this);
    _active = true;
    _collided = false;
    _startExtending();
  }

  void _startExtending() {
    asy.Timer.periodic(extendDuration, (timer) {
      if (isActive && !_collided) {
        _extendingMovement();
      } else {
        timer.cancel();
      }
    });
  }

  void _extendingMovement() {
    if (isExtended) {
      drawback();
    } else {
      extend();
    }
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
    if (!_collided && isExtended) {
      super.onCollision(intersectionPoints, other);

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
      reversedArtboard: reversedArtboard,
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
    _down = MoveDown(sprite: this, pixelsPerMilli: 2);
  }
}
