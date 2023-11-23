import 'package:app/src/views/screens/game/controller/sprites/animation/irive_animation.dart';
import 'package:flame_rive/flame_rive.dart';

class ThrowSnowball extends IRiveAnimation {
  static const id = "throw";
  ThrowSnowball({
    required Artboard artboard,
  }) : super(artboard: artboard, name: id);
}
