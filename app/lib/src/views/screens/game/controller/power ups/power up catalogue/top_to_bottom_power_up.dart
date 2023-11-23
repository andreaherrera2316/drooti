import 'package:app/src/core/use%20cases/sprites/movement/move_down.dart';
import 'package:app/src/core/use%20cases/sprites/position/position_top_to_bottom.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/iflame_power_up.dart';
import 'package:flame/components.dart';
import 'package:app/src/core/use%20cases/sprites/movement/imovement.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

abstract class TopToBottomPowerUp extends IFlamePowerUp {
  TopToBottomPowerUp({
    required this.game,
    required super.artboard,
    required this.pixelsPerMilli,
    this.topToBottom = true,
  }) {
    _setUpMovement();
  }

  bool
      topToBottom; //should be set to true if the games coordinates are top =0 and bottom = gameSize
  double pixelsPerMilli;
  FlameGame game;
  bool _active = false;
  bool _collided = false;
  IMovement? _moveToSide;
  IMovement? _fall;
  IMovement? _spin;

  @override
  bool get isActive => _active;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (isActive && !_collided) {
      _moveToSide?.move();
    } else if (isActive && _collided) {
      _fall?.move();
      _spin?.move();
    }

    _checkIfExitedScreen();
  }

  @override
  void addToGame() {
    _intialPosition();
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
      powerUp();
      removeFromGame();
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

  void _intialPosition() {
    PositionTopToBottom(
      component: this,
      screenHeight: game.size.y,
      screenWidth: game.size.x,
      topToBottom: topToBottom,
    ).setInitialPosition();
  }

  void _setUpMovement() {
    var move = MoveDown(
      sprite: this,
      pixelsPerMilli: pixelsPerMilli,
    );
    _moveToSide = move;
  }
}
