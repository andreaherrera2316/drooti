mixin SpriteWithinScreen {
  ///checks whether the sprite is within screen bounds throught the sides or bottom of the screen
  bool hasExitedScreenBounds(
      {required double posY,
      required double posX,
      required double spriteH,
      required double spriteW,
      required double screenH,
      required double screenW,
      required bool topToBottom}) {
    bool exited = hasExitedScreenBottom(
            posY: posY,
            spriteH: spriteH,
            screenH: screenH,
            topToBottom: topToBottom) ||
        hasExitedScreenLeft(posX: posX, spriteW: spriteW) ||
        hasExitedScreenRight(posX: posX, spriteW: spriteW, screenW: screenW);
    if (exited) {}
    return exited;
  }

  bool hasExitedScreenBottom(
      {required double posY,
      required double spriteH,
      required double screenH,
      required bool topToBottom}) {
    if (topToBottom) {
      return posY > _bottom(topToBottom, screenH) + spriteH;
    } else {
      return posY < _bottom(topToBottom, screenH) - spriteH;
    }
  }

  bool hasExitedScreenLeft({required double posX, required double spriteW}) {
    return posX < 0 - spriteW;
  }

  bool hasExitedScreenRight(
      {required double posX,
      required double spriteW,
      required double screenW}) {
    return posX > screenW + spriteW;
  }

  double _bottom(bool topToBottom, double screenH) {
    if (topToBottom) {
      return screenH;
    } else {
      return 0;
    }
  }
}
