import 'package:app/src/core/entities/background/igame_background.dart';
import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/igame_manager.dart';

abstract class IGameController implements IGameActions, IGameManager {
  void loadBackground(IGameBackground background);
  void movedDrooti(double x, double y);
  void setDrootiStartPoint(double x, double y);
  void resizeDrooti(double height, double width);
  void resizeGame(double screenHeightInPixels, double screenWidthInPixels,
      [double drootiX, double drootiY, bool positionsAreBottomToTop]);
}
