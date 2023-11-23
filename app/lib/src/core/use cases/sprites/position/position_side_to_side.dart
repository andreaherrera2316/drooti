import 'dart:math';

import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/core/use%20cases/sprites/position/iposition.dart';

class PositionSideToSide implements IPosition {
  bool left;
  bool topToBottom;
  ISprite sprite;
  double screenWidth;
  double screenHeight;

  PositionSideToSide({
    required this.left,
    required this.topToBottom,
    required this.sprite,
    required this.screenHeight,
    required this.screenWidth,
  });

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
      sprite.x = 0 - sprite.sizeX;
    } else {
      sprite.x = screenWidth + sprite.sizeX;
    }
  }

  void _setYPosition() {
    int upperScreen = (screenHeight * 0.75).round();
    double posY;
    if (topToBottom) {
      posY = Random().nextDouble() * upperScreen;
    } else {
      posY = Random().nextDouble() * _top - upperScreen;
    }
    sprite.y = posY;
  }
}
