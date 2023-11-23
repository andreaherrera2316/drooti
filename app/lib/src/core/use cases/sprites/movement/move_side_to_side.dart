import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/core/use%20cases/sprites/movement/imovement.dart';

class MoveSideToSide implements IMovement {
  MoveSideToSide(
      {required this.sprite, required this.pixelsPerMilli, required bool left})
      : _left = left,
        _maxSpeed = pixelsPerMilli * 1.3;

  ISprite sprite;
  double pixelsPerMilli;
  final bool _left;
  final double _maxSpeed;
  double _speed = 0.2;

  @override
  void move() {
    if (_left) {
      _goLeft();
    } else {
      _goRight();
    }
  }

  double get _moveByPixels => pixelsPerMilli + _speed;

  void _goLeft() {
    sprite.moveX(_moveByPixels);
    _increaseSpeed();
  }

  void _goRight() {
    sprite.moveX(-_moveByPixels);

    _increaseSpeed();
  }

  void _increaseSpeed() {
    bool belowMaxSpeed = pixelsPerMilli + _speed < _maxSpeed;
    if (belowMaxSpeed) {
      _speed += pixelsPerMilli / 100;
    }
  }
}
