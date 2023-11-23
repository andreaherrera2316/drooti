import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/seasons%20notifier/seasons_subscriber.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';

abstract class SeasonsNotifier {
  List<SeasonsSubscriber> seasonsSubs = [];
  void addSeasonSub(SeasonsSubscriber sub);
  void removeSeasonSub(SeasonsSubscriber sub);
  void changeSeason(SeasonOfYear season);
}
