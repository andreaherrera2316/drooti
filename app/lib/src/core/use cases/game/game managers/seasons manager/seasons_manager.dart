import 'dart:async';

import 'package:app/src/core/use%20cases/game/game%20managers/igame_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/iseasons_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/seasons%20notifier/seasons_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/seasons%20notifier/seasons_subscriber.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';

class GameSeasonsManager extends IGameSeasonsManager
    implements IGameManager, SeasonsNotifier {
  GameSeasonsManager({
    required super.temperature,
    super.seasonDuration = const Duration(seconds: 30),
  });

  int _seasonIndex = 0;
  int _seasonsPassed = 0;
  DateTime? _lastTimeFired;
  DateTime? _lastTimePaused;
  bool _cancel = false;

  int get seasonsPassed => _seasonsPassed;
  Season get current => seasons[_seasonIndex];

  @override
  void start() {
    _cancel = false;
    _changeSeasons();
  }

  @override
  void end() {
    _cancel = true;
  }

  @override
  void pause() {
    _cancel = true;
    _lastTimePaused = DateTime.now();
  }

  @override
  void resume() {
    _cancel = false;
    _resumeSeasons();
  }

  @override
  void restart() {
    _cancel = false;
    _seasonIndex = 0;
    _seasonsPassed = 0;
    _lastTimeFired = null;
    _lastTimePaused = null;
  }

  void _resumeSeasons() {
    int seasonLasted = _lastTimePaused!.difference(_lastTimeFired!).inSeconds;
    int seasonShouldLast = seasonDuration.inSeconds;
    int missingSeconds = seasonShouldLast - seasonLasted;
    if (missingSeconds <= 0) {
      _changeSeasons();
    } else {
      _resumeCurrentSeason(missingSeconds);
    }
  }

  void _resumeCurrentSeason(int missingSeconds) {
    Timer(Duration(seconds: missingSeconds), () {
      _changeSeason();
      _changeSeasons();
    });
  }

  void _changeSeasons() {
    Timer.periodic(seasonDuration, (timer) {
      if (_cancel) {
        timer.cancel();
      }
      _changeSeason();
    });
  }

  void _changeSeason() {
    _lastTimeFired = DateTime.now();
    changeSeason(current.season);
    temperature.setTemperature(current.intialTemperatureF);
    _seasonsPassed++;
    _setNextSeasonIndex();
  }

  _setNextSeasonIndex() {
    bool hasNextSeason = _seasonIndex < seasons.length - 1;
    if (hasNextSeason) {
      _seasonIndex++;
    } else {
      _seasonIndex = 0;
    }
  }

  @override
  List<SeasonsSubscriber> seasonsSubs = [];

  @override
  void addSeasonSub(SeasonsSubscriber sub) {
    seasonsSubs.add(sub);
    sub.onSeasonChange(current.season);
  }

  @override
  void changeSeason(SeasonOfYear season) {
    for (var sub in seasonsSubs) {
      sub.onSeasonChange(season);
    }
  }

  @override
  void removeSeasonSub(SeasonsSubscriber sub) {
    seasonsSubs.remove(sub);
  }
}
