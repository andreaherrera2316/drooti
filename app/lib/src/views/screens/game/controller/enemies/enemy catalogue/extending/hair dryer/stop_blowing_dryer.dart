import 'package:app/src/views/screens/game/controller/sprites/animation/irive_animation.dart';
import 'package:flame_rive/flame_rive.dart';

class StopBlowingDryer extends IRiveAnimation {
  static const id = "stop blowing";
  StopBlowingDryer({required Artboard artboard, this.onActivated})
      : super(artboard: artboard, name: id);

  void Function()? onActivated;

  @override
  void onActivate() {
    super.onActivate();
    onActivated?.call();
  }
}
