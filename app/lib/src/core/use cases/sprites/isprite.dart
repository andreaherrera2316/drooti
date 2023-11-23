abstract class ISprite {
  double x = 0;
  double y = 0;
  double sizeX = 0;
  double sizeY = 0;
  bool get isActive;
  double get angleInDegrees;

  void moveX(double byPixels);
  void moveY(double byPixels);
  void addToGame();
  void removeFromGame();
  void rotate(double degrees);
}
