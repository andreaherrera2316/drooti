import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/core/use%20cases/sprites/movement/imovement.dart';

class FallOffScreen implements IMovement {
  FallOffScreen({
    required this.sprite,
    required bool fallLeftToRight,
    this.pixelsPerMilli = 9.8,
  })  : _maxSpeed = pixelsPerMilli * 1.5,
        _fallLtoR = fallLeftToRight,
        _fallSideEffect = pixelsPerMilli * 0.5;
  //todo: edited

  ISprite sprite;
  Function? onExitedScreen;
  double pixelsPerMilli;
  final bool _fallLtoR;
  final double _maxSpeed;
  double _speed = 0.2;
  double _fallSideEffect;

  @override
  void move() {
    _fall();
    _increaseSpeed();
  }

  void _fall() {
    _moveDown();
    _fallToSide();
  }

  void _moveDown() {
    double byPixels = (pixelsPerMilli + _speed) * -1;
    sprite.moveY(byPixels);

    _increaseSpeed();
  }

  void _fallToSide() {
    if (_fallLtoR) {
      sprite.moveX(_fallSideEffect * -1);
    } else {
      sprite.moveX(_fallSideEffect);
    }

    if (_fallSideEffect > pixelsPerMilli / 4) {
      _fallSideEffect -= 0.1;
    }
  }

  void _increaseSpeed() {
    bool belowMaxSpeed = pixelsPerMilli + _speed < _maxSpeed;
    if (belowMaxSpeed) {
      _speed += pixelsPerMilli / 100;
    }
  }
}
