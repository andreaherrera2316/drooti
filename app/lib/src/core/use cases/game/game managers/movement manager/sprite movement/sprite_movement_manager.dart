// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/meter_limits_subscriber.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/movement%20manager/sprite%20movement/isprite_movement_manager.dart';

abstract class SpriteMovementManager
    implements ISpriteMovementManager, MeterLimitsSubscriber {
  double gameTopLimit = 0;
  double gameBottomLimit = 0;

  void moveSprites(double moveBy);

  @override
  void onLimitsUpdate(MeterLimits newLimits) {
    if (gameTopLimit != 0) {
      double aboveBy = newLimits.top - (gameTopLimit);
      double byPixelsY = aboveBy * newLimits.pixelsPerMeter;
      moveSprites(-byPixelsY);
    }
    gameTopLimit = newLimits.top;
    gameBottomLimit = newLimits.bottom;
  }

  @override
  double get bottomMeters => gameBottomLimit;

  @override
  double get topMeters => gameTopLimit;
}
