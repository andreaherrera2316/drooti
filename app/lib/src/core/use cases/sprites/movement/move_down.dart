import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/core/use%20cases/sprites/movement/imovement.dart';

class MoveDown implements IMovement {
  MoveDown({
    required this.sprite,
    required this.pixelsPerMilli,
  }) : _maxSpeed = pixelsPerMilli * 1.3;

  ISprite sprite;

  double pixelsPerMilli;
  final double _maxSpeed;
  double _speed = 0.2;

  @override
  void move() {
    _moveDown();
    _increaseSpeed();
  }

  void _moveDown() {
    double byPixels = (pixelsPerMilli + _speed) * -1;
    sprite.moveY(byPixels);
  }

  void _increaseSpeed() {
    bool belowMaxSpeed = pixelsPerMilli + _speed < _maxSpeed;
    if (belowMaxSpeed) {
      _speed += pixelsPerMilli / 100;
    }
  }
}
