import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/power%20up%20catalogue/lightning/electrify_lightning.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/power%20up%20catalogue/top_to_bottom_power_up.dart';
import 'package:flame/collisions.dart';

class Lightning extends TopToBottomPowerUp {
  Lightning({
    required this.actions,
    required super.game,
    required super.artboard,
    required super.pixelsPerMilli,
    required double height,
    required double width,
    super.topToBottom,
  }) : _electrify = ElectrifyLightning(artboard: artboard) {
    size.x = width;
    size.y = height;
  }

  IGameActions actions;
  double chargeIncrease = 3;
  final ElectrifyLightning _electrify;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    var hit = RectangleHitbox()..collisionType = CollisionType.passive;

    add(hit);
  }

  @override
  void powerUp() {
    actions.increaseChargeByPercent(3);
  }

  @override
  void addToGame() {
    super.addToGame();
    _addElectrifyAnimation();
  }

  void _addElectrifyAnimation() {
    artboard.addController(_electrify);
  }
}
