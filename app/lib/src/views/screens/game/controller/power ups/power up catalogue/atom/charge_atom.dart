import 'package:app/src/views/screens/game/controller/sprites/animation/irive_animation.dart';
import 'package:flame_rive/flame_rive.dart';

class ChargeAtom extends IRiveAnimation {
  static const id = "charge";
  ChargeAtom({
    required Artboard artboard,
  }) : super(artboard: artboard, name: id);
}
