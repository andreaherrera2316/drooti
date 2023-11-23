import 'package:app/src/core/entities/properties/position.dart';

class MoveDrooti {
  MoveDrooti();

  Position moveDrooti({
    required double moveToX,
    required double moveToY,
    required double gameHeight,
    required double gameWidth,
    required double drootiHeight,
    required double drootiWidth,
  }) {
    return _moveDrootiWithinScreenBounds(
        moveToX: moveToX,
        moveToY: moveToY,
        gameHeight: gameHeight,
        gameWidth: gameWidth,
        drootiHeight: drootiHeight,
        drootiWidth: drootiWidth);
  }

  Position _moveDrootiWithinScreenBounds({
    required double moveToX,
    required double moveToY,
    required double gameHeight,
    required double gameWidth,
    required double drootiHeight,
    required double drootiWidth,
  }) {
    //bounds
    var top = 0 + drootiHeight;
    var left = 0 + drootiWidth * 0.47;
    var bottom = gameHeight;
    var right = gameWidth - drootiWidth * 0.42;

    if (moveToX < left) {
      moveToX = left;
    } else if (moveToX > right) {
      moveToX = right;
    }

    if (moveToY < top) {
      moveToY = top;
    } else if (moveToY > bottom) {
      moveToY = bottom;
    }

    return Position(x: moveToX, y: moveToY);
  }
}
