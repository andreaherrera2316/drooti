import 'dart:math';

import 'package:app/src/core/use%20cases/sprites/position/iposition.dart';
import 'package:flame/components.dart';

class PositionTopToBottom implements IPosition {
  PositionTopToBottom({
    required this.topToBottom,
    required this.component,
    required this.screenHeight,
    required this.screenWidth,
  });

  bool topToBottom;
  PositionComponent component;
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
    var limitLeft = screenWidth * 0.13;
    var limitRight = screenWidth * 0.87;

    component.position.x =
        Random().nextDouble() * (limitRight - limitLeft) + limitLeft;
  }

  void _setYPosition() {
    if (topToBottom) {
      component.position.y = _top - component.size.y;
    } else {
      component.position.y = _top + component.size.y;
    }
  }
}
