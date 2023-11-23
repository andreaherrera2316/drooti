import 'package:app/src/views/screens/game/controller/sprites/animation/irive_animation.dart';
import 'package:flame_rive/flame_rive.dart';

class DrawBackPunch extends IRiveAnimation {
  static const id = "draw back";

  DrawBackPunch({required Artboard artboard, this.onActivated})
      : super(artboard: artboard, name: id);

  void Function()? onActivated;

  @override
  void onActivate() {
    super.onActivate();
    onActivated?.call();
  }
}
