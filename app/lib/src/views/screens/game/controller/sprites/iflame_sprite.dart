import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/core/use%20cases/sprites/sprite_within_screen.dart';
import 'package:flame_rive/flame_rive.dart';

abstract class IFlameSprite extends RiveComponent
    with SpriteWithinScreen
    implements ISprite {
  IFlameSprite({required super.artboard});

  @override
  double get x => position.x;
  @override
  double get y => position.y;

  @override
  set x(double x) => position.x = x;
  @override
  set y(double y) => position.y = y;

  @override
  double get sizeX => size.x;
  @override
  double get sizeY => size.y;

  @override
  set sizeX(double sizeX) => size.x = sizeX;
  @override
  set sizeY(double sizeY) => size.y = sizeY;

  @override
  double get angleInDegrees => _radiansToDegrees(angle);

  @override
  void moveX(double byPixels) {
    position.x += byPixels;
  }

  @override
  rotate(double degrees) {
    angle += _degreesToRadians(degrees);
  }

  double _degreesToRadians(double degrees) {
    return degrees * (3.141592653589793 / 180);
  }

  double _radiansToDegrees(double radians) {
    return radians * (180 / 3.141592653589793);
  }
}
