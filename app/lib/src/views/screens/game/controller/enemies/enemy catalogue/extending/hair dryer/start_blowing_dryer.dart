import 'package:app/src/views/screens/game/controller/sprites/animation/irive_animation.dart';
import 'package:flame_rive/flame_rive.dart';

class StartBlowingDryer extends IRiveAnimation {
  static const id = "start blowing";
  StartBlowingDryer({required Artboard artboard, this.onDeactivated})
      : super(artboard: artboard, name: id);

  void Function()? onDeactivated;

  @override
  void onDeactivate() {
    super.onDeactivate();
    onDeactivated?.call();
  }
}
