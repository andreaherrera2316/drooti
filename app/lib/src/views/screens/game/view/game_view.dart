import 'package:app/src/core/entities/background/igame_background.dart';
import 'package:app/src/core/use%20cases/background/game%20backgrounds/game_backgrounds.dart';
import 'package:flutter/material.dart';

import 'game /game screen/draggable_game.dart';

class GameView extends StatelessWidget {
  const GameView({required this.backgroundID, super.key});

  final String backgroundID;

  @override
  Widget build(BuildContext context) {
    final background = getBackgroundFromId(backgroundID);
    return DraggableGame(background: background).getGameWidget();
  }
}

IGameBackground getBackgroundFromId(String backgroundID) {
  return GameBackgrounds().getBackgroundByID(backgroundID);
}
