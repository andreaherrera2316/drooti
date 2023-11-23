import 'package:app/src/core/entities/background/igame_background.dart';

abstract class IGameBackgrounds {
  List<IGameBackground> getBackgrounds();

  IGameBackground getBackgroundByID(String backgroundID);
}
