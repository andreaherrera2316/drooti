import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';

abstract class SeasonsSubscriber {
  void onSeasonChange(SeasonOfYear season);
}
