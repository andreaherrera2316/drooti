import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/power%20up%20catalogue/atom/charge_atom.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/power%20up%20catalogue/top_to_bottom_power_up.dart';
import 'package:flame/collisions.dart';

class Atom extends TopToBottomPowerUp {
  Atom({
    required this.actions,
    required super.game,
    required super.artboard,
    required super.pixelsPerMilli,
    required double height,
    required double width,
    super.topToBottom,
  }) : _spin = ChargeAtom(artboard: artboard) {
    size.x = width;
    size.y = height;
  }

  IGameActions actions;
  final ChargeAtom _spin;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    var hit = CircleHitbox()..collisionType = CollisionType.passive;

    add(hit);
  }

  @override
  void powerUp() {
    // actions.quantumSpeed()
  }

  @override
  void addToGame() {
    super.addToGame();
    _addChargeAnimation();
  }

  void _addChargeAnimation() {
    artboard.addController(_spin);
  }
}
