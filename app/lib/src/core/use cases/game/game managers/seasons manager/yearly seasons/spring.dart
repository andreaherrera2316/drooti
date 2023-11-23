import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season.dart';

class Spring implements Season {
  Spring()
      : season = SeasonOfYear.spring,
        intialTemperatureF = 70;

  @override
  int intialTemperatureF;

  @override
  SeasonOfYear season;
}
