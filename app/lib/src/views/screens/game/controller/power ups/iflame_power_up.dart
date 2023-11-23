import 'package:app/src/core/use%20cases/sprites/power%20ups/ipower_up.dart';
import 'package:app/src/views/screens/game/controller/sprites/iflame_sprite.dart';
import 'package:flame/collisions.dart';

abstract class IFlamePowerUp extends IFlameSprite
    with CollisionCallbacks
    implements IPowerUp {
  IFlamePowerUp({required super.artboard});
}
