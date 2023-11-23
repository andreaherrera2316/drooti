import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/core/use%20cases/sprites/movement/imovement.dart';

class Spin implements IMovement {
  Spin(
      {required this.sprite,
      required this.spinLeft,
      this.spinDegreesPerMove = 7.8});

  bool spinLeft;
  double spinDegreesPerMove;
  ISprite sprite;

  @override
  void move() {
    if (spinLeft) {
      _spinLeft();
    } else {
      _spinRight();
    }
  }

  void _spinLeft() {
    sprite.rotate(spinDegreesPerMove);
  }

  void _spinRight() {
    sprite.rotate(-spinDegreesPerMove);
  }
}
