import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/seasons%20notifier/seasons_subscriber.dart';
import 'package:app/src/views/screens/game/presenter/igame_presenter.dart';

class ProcessSeasonUpdates implements SeasonsSubscriber {
  ProcessSeasonUpdates({required this.presenter});
  IGamePresenter presenter;
  @override
  void onSeasonChange(SeasonOfYear season) {
    if (season == SeasonOfYear.spring) {
      presenter.spring();
    } else if (season == SeasonOfYear.summer) {
      presenter.summer();
    } else if (season == SeasonOfYear.autumn) {
      presenter.autumn();
    } else if (season == SeasonOfYear.winter) {
      presenter.winter();
    }
  }
}
