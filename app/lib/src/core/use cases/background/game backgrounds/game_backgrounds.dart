import 'package:app/src/core/entities/background/igame_background.dart';
import 'package:app/src/core/use%20cases/background/game%20backgrounds/backgrounds/city_background.dart';
import 'package:app/src/core/use%20cases/background/game%20backgrounds/backgrounds/eastern_island_background.dart';
import 'package:app/src/core/use%20cases/background/game%20backgrounds/backgrounds/fairy_tale_background.dart';
import 'package:app/src/core/use%20cases/background/game%20backgrounds/backgrounds/farm_background.dart';
import 'package:app/src/core/use%20cases/background/game%20backgrounds/backgrounds/island_background.dart';
import 'package:app/src/core/entities/background/igame_backgrounds.dart';

import 'backgrounds/alien_background.dart';

class GameBackgrounds implements IGameBackgrounds {
  GameBackgrounds() : _backgrounds = _getBackgrounds();

  static Map<String, IGameBackground> _getBackgrounds() {
    Map<String, IGameBackground> backgroundsMap = {};
    var bgs = [
      AlienBackground(),
      CityBackground(),
      EasternIslandBackground(),
      FairyTaleBackground(),
      FarmBackground(),
      IslandBackground(),
    ];

    for (int i = 0; i < bgs.length; i++) {
      backgroundsMap.addAll({bgs[i].id: bgs[i]});
    }

    return backgroundsMap;
  }

  final Map<String, IGameBackground> _backgrounds;

  @override
  List<IGameBackground> getBackgrounds() {
    return _backgrounds.values.toList();
  }

  @override
  IGameBackground getBackgroundByID(String backgroundID) {
    return _backgrounds[backgroundID] ?? _backgrounds.values.first;
  }
}
