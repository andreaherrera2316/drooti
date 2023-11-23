import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/core/use%20cases/sprites/position/iposition.dart';

class PositionStationary implements IPosition {
  PositionStationary({
    required this.left,
    required this.topToBottom,
    required this.component,
    required this.screenHeight,
    required this.screenWidth,
    this.reversedArtboard = false,
  });

  bool left;
  bool reversedArtboard;
  bool topToBottom;
  ISprite component;
  double screenWidth;
  double screenHeight;

  @override
  void setInitialPosition() {
    _setYPosition();
    _setXPosition();
  }

  double get _top {
    if (topToBottom) {
      return 0;
    } else {
      return screenHeight;
    }
  }

  void _setXPosition() {
    if (left) {
      _positionLeft();
    } else {
      _positionRight();
    }
  }

  //okay we need to take the anchor out of here
  //ahhhhhh

  void _positionLeft() {
    component.x = 0;
    if (reversedArtboard) {
      component.x = component.sizeX.abs();
    }
  }

  void _positionRight() {
    if (reversedArtboard) {
      component.x = screenWidth - component.sizeX.abs();
    } else {
      component.x = screenWidth;
    }
  }

  void _setYPosition() {
    if (topToBottom) {
      component.y = _top - component.sizeY;
    } else {
      component.y = _top + component.sizeY;
    }
  }
}
