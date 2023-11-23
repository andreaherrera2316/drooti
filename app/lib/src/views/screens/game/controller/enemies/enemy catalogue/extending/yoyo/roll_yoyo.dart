import 'package:app/src/views/screens/game/controller/sprites/animation/irive_animation.dart';
import 'package:flame_rive/flame_rive.dart';

class RollYoyo extends IRiveAnimation {
  static const id = "roll";

  RollYoyo({required Artboard artboard}) : super(artboard: artboard, name: id);

  stop() {
    isActive = false;
  }
}
