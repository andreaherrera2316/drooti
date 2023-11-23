import 'package:app/src/core/use%20cases/sprites/enemy/ienemy.dart';
import 'package:app/src/views/screens/game/controller/enemies/artboard%20direction%20/artboard_direction.dart';
import 'package:app/src/views/screens/game/controller/sprites/iflame_sprite.dart';
import 'package:flame/collisions.dart';

abstract class IFlameEnemy extends IFlameSprite
    with CollisionCallbacks
    implements IEnemy {
  IFlameEnemy({required super.artboard});

  ArtboardDirection get artboardDirection => ArtboardDirection.circular;
}
