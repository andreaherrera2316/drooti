// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/movement%20manager/imovement_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/movement%20manager/sprite%20movement/sprite_movement_manager.dart';
import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/views/screens/game/controller/game%20size%20notifier/game_size_subscriber.dart';

class MovementManager extends SpriteMovementManager
    implements IMovementManager, GameSizeSubscriber {
  Map<ISprite, double> sprites = {};

  @override
  void addSprite(ISprite sprite) {
    sprites.addAll({sprite: topMeters});
  }

  @override
  removeSprite(ISprite sprite) {
    sprites.remove(sprite);
  }

  @override
  void onGameResize(double heightInPixels, double widthInPixels) {
    // TODO: implement onGameResize
    // or remove
    //feinitely would become its own manager
  }

  @override
  void moveSprites(double moveby) {
    List<ISprite> spritesToRemove = [];
    for (var sprite in sprites.keys) {
      if (sprite.isActive) {
        sprite.moveY(moveby);
      } else {
        spritesToRemove.add(sprite);
      }
    }
    _removeInactiveSprites(spritesToRemove);
  }

  void _removeInactiveSprites(List<ISprite> remove) {
    for (var sprite in remove) {
      sprites.remove(sprite);
    }
  }

  void _repositionOnResize(MeterLimits previous, MeterLimits current) {
    //todo:
    //here's the thing
    //we will need a game resize update
    //so that we only reposition the sprites when the screen changes
  }
}
