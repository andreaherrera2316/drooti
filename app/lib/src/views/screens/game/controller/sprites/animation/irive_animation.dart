import 'package:app/src/core/use%20cases/sprites/drooti/animations/ianimation.dart';
import 'package:flame_rive/flame_rive.dart';

abstract class IRiveAnimation extends SimpleAnimation implements IAnimation {
  Artboard artboard;

  IRiveAnimation({required this.artboard, required this.name})
      : super(name, autoplay: true);

  @override
  String name;
  @override
  void play() {
    reset();
    if (artboard.animationControllers.contains(this)) {
      isActive = true;
    } else {
      artboard.addController(this);
    }
  }
}
