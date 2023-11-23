import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/seasons%20notifier/seasons_subscriber.dart';

abstract class ISeasonalGenerator implements SeasonsSubscriber {
  List<SeasonOfYear> genSeasons = [];
  void reset();
  void start();
  void pause();
}
