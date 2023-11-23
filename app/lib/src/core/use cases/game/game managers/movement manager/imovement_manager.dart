import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/core/use%20cases/sprites/isprite_displayer.dart';

abstract class IMovementManager implements ISpriteDisplayer {
  moveSprites(double byPixels);
  //addSprite(ISprite sprite);
  removeSprite(ISprite sprite);

  //todo remove the sprite displayer
  //okay for now
}
