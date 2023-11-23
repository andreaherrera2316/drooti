import 'dart:async';

import 'package:app/src/core/entities/properties/position.dart';
import 'package:app/src/views/screens/game/components/drooti/sprites/drooti_sprite.dart';
import 'package:app/src/views/screens/game/components/sprites/drooti/move%20drooti/move_drooti.dart';
import 'package:app/src/views/screens/game/components/sprites/drooti/reposition%20drooti/resposition_drooti.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20screen/draggable_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';

class DraggableDrootiSprite extends DrootiSprite
    with Draggable, HasGameReference<DraggableGame> {
  DraggableDrootiSprite({
    required super.drootiArtboard,
    required this.onDrootiMoved,
    required this.onResizeGame,
    required super.drootiSize,
  })  : _moveDrooti = MoveDrooti(),
        _reposition = RespositionDrooti();

  Vector2? _currentSize;
  final RespositionDrooti _reposition;
  final MoveDrooti _moveDrooti;
  void Function(double x, double y) onDrootiMoved;
  void Function(double screenHeightInPixels, double screenWidthInPixels,
      [double drootiX,
      double drootiY,
      bool positionsAreBottomToTop]) onResizeGame;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    _currentSize = game.size;
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (_currentSize != null) {
      _repositionDrooti();
    }
    _currentSize = size;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    var dragPosition = info.eventPosition.game;
    var dragX = dragPosition.x;
    var dragY = dragPosition.y;
    Position moveTo = _moveDrooti.moveDrooti(
      moveToX: dragX,
      moveToY: dragY,
      gameHeight: game.size.y,
      gameWidth: game.size.x,
      drootiHeight: size.y,
      drootiWidth: size.x,
    );
    moveDrooti(moveTo.x, moveTo.y);
    onDrootiMoved(moveTo.x, moveTo.y);
    return super.onDragUpdate(info);
  }

  _repositionDrooti() {
    Position moveTo = _reposition.positionOnGameResize(
        drootiX: position.x,
        drootiY: position.y,
        gameHeight: _currentSize!.y,
        newGameHeight: game.size.y,
        gameWidth: _currentSize!.x,
        newGameWidth: game.size.x);

    position = Vector2(moveTo.x, moveTo.y);
    onResizeGame(game.size.y, game.size.x, position.x, position.y, true);
  }
}
