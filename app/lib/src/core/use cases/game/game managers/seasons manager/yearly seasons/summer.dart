import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season.dart';

class Summer implements Season {
  Summer()
      : season = SeasonOfYear.summer,
        intialTemperatureF = 100;

  @override
  int intialTemperatureF;

  @override
  SeasonOfYear season;
}
