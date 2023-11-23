import 'package:app/src/core/use%20cases/sprites/drooti/animations/ianimation.dart';
import 'package:app/src/views/screens/game/components/sprites/drooti/animations/catalogue/break_down_animation.dart';
import 'package:app/src/views/screens/game/components/sprites/drooti/animations/catalogue/collision_animation.dart';
import 'package:app/src/views/screens/game/components/sprites/drooti/animations/catalogue/explode_animation.dart';
import 'package:app/src/views/screens/game/components/sprites/drooti/animations/catalogue/freeze_animation.dart';
import 'package:app/src/views/screens/game/components/sprites/drooti/animations/catalogue/power_up_animation.dart';
import 'package:app/src/views/screens/game/components/sprites/drooti/animations/catalogue/quantum_speed_animation.dart';
import 'package:app/src/views/screens/game/components/sprites/drooti/animations/catalogue/take_off_animation.dart';

import 'package:flame_rive/flame_rive.dart';

class DrootiAnimations {
  IAnimation? _breakDown;
  IAnimation? _collision;
  IAnimation? _explode;
  IAnimation? _powerUp;
  IAnimation? _quantumSpeed;
  IAnimation? _takeOff;
  IAnimation? _freeze;

  breakDown(Artboard artboard) {
    _breakDown ??= BreakDownAnimation(artboard: artboard);
    _breakDown!.play();
  }

  collide(Artboard artboard) {
    _collision ??= CollisionAnimation(artboard: artboard);
    _collision!.play();
  }

  explode(Artboard artboard) {
    _explode ??= ExplodeAnimation(artboard: artboard);
    _explode!.play();
  }

  powerUp(Artboard artboard) {
    _powerUp ??= PowerUpAnimation(artboard: artboard);
    _powerUp!.play();
  }

  quantumSpeed(Artboard artboard) {
    _quantumSpeed ??= QuantumSpeedAnimation(artboard: artboard);
    _quantumSpeed!.play();
  }

  takeOff(Artboard artboard) {
    _takeOff ??= TakeOffAnimation(artboard: artboard);
    _takeOff!.play();
  }

  freeze(Artboard artboard) {
    _freeze ??= FreezeAnimation(artboard: artboard);
    _freeze!.play();
  }
}
