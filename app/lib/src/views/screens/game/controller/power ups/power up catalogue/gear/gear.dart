import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/power%20up%20catalogue/gear/spin_gear.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/power%20up%20catalogue/top_to_bottom_power_up.dart';
import 'package:flame/collisions.dart';

class Gear extends TopToBottomPowerUp {
  Gear({
    required this.actions,
    required super.game,
    required super.artboard,
    required super.pixelsPerMilli,
    required double height,
    required double width,
    super.topToBottom,
  }) : _spin = SpinGear(artboard: artboard) {
    size.x = width;
    size.y = height;
  }

  IGameActions actions;
  double motorRepair = 3;
  final SpinGear _spin;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    var hit = CircleHitbox()..collisionType = CollisionType.passive;

    add(hit);
  }

  @override
  void powerUp() {
    actions.repairMotor(3);
  }

  @override
  void addToGame() {
    super.addToGame();
    _addSpinAnimation();
  }

  void _addSpinAnimation() {
    artboard.addController(_spin);
  }
}
