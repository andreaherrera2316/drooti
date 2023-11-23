import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season.dart';

class Winter implements Season {
  Winter()
      : season = SeasonOfYear.winter,
        intialTemperatureF = 50;

  @override
  int intialTemperatureF;

  @override
  SeasonOfYear season;
}
