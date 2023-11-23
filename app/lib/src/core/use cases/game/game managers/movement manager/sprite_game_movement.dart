import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/meter_limits_subscriber.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/movement%20manager/imovement_manager.dart';
import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/views/screens/game/controller/game%20size%20notifier/game_size_subscriber.dart';

class MovementManager
    implements IMovementManager, MeterLimitsSubscriber, GameSizeSubscriber {
  Map<ISprite, double> sprites = {};
  double? gameTopLimit;

  @override
  void onLimitsUpdate(MeterLimits newLimits) {
    if (gameTopLimit != null) {
      double aboveBy = newLimits.top - (gameTopLimit ?? 0);
      double byPixelsY = aboveBy * newLimits.pixelsPerMeter;
      moveSprites(-byPixelsY);
    }
    gameTopLimit = newLimits.top;
  }

  @override
  void addSprite(ISprite sprite) {
    sprites.addAll({sprite: gameTopLimit ?? 0});
  }

  @override
  removeSprite(ISprite sprite) {
    sprites.remove(sprite);
  }

  @override
  void onGameResize(double heightInPixels, double widthInPixels) {
    // TODO: implement onGameResize
  }
  @override
  void moveSprites(double byPixelsY) {
    List<ISprite> spritesToRemove = [];
    for (var sprite in sprites.keys) {
      if (sprite.isActive) {
        sprite.moveY(byPixelsY);
      } else {
        spritesToRemove.add(sprite);
      }
    }
    //we remove the sprites
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
