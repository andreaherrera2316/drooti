import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/core/use%20cases/sprites/movement/imovement.dart';

class Swing implements IMovement {
  Swing({
    required this.sprite,
    this.maxSwingDegrees = 90,
    this.topToBottom = true,
    this.degreesPerMove = 4,
    required bool left,
  }) : _left = left;

  ISprite sprite;
  double maxSwingDegrees;
  final bool topToBottom;
  final bool _left;
  final double degreesPerMove;
  double? _initialAngleDegrees;
  double _increase = 0;
  bool _goUp = true;
  //todo: do we need this
  bool get startLeft => _left;

  @override
  void move() {
    _initialAngleDegrees ??= sprite.angleInDegrees;
    _swing();
  }

  double get _rotation => degreesPerMove + _increase;

  void _swing() {
    if (_goUp) {
      _swingUp();
    } else {
      _swingDown();
    }
    _increaseSpeed();
  }

  void _swingUp() {
    bool reachedLimit =
        sprite.angleInDegrees > maxSwingDegrees + _initialAngleDegrees!;

    if (reachedLimit) {
      _reverseSwingDirection();
    } else {
      sprite.rotate(_rotation);
    }
  }

  void _swingDown() {
    bool reachedLimit =
        sprite.angleInDegrees < _initialAngleDegrees! - maxSwingDegrees;

    if (reachedLimit) {
      _reverseSwingDirection();
    } else {
      sprite.rotate(-_rotation);
    }
  }

  void _reverseSwingDirection() {
    _increase = 0;
    _goUp = !_goUp;
  }

  void _increaseSpeed() {
    _increase += 0.03;
  }
}
