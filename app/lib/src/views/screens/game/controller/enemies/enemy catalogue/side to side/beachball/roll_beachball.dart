import 'package:app/src/views/screens/game/controller/sprites/animation/irive_animation.dart';
import 'package:flame_rive/flame_rive.dart';

class RollBeachball extends IRiveAnimation {
  static const id = "roll";
  RollBeachball({
    required Artboard artboard,
  }) : super(artboard: artboard, name: id);
}
