import 'package:app/src/core/entities/game/weather/temperature.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/seasons_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const seasonsDuration = Duration(seconds: 2);
  final intialTemperature = Temperature(80);
  test("Seasons start in spring", () async {
    var manager = GameSeasonsManager(
        temperature: intialTemperature, seasonDuration: seasonsDuration);
    expect(manager.current.season, SeasonOfYear.spring);
  });

  test("Seasons change after the duration", () async {
    var manager = GameSeasonsManager(
        temperature: intialTemperature, seasonDuration: seasonsDuration);
    manager.start();

    var currentSeason = manager.current;
    var indexOfCurrent = manager.seasons.indexOf(currentSeason);
    var nextSeason = manager.seasons[indexOfCurrent + 1];

    await Future.delayed(manager.seasonDuration, () {
      //seasons should already have changed
      expect(manager.current, nextSeason);
    });
  });

  test("Seasons restart themselves after the last season", () async {
    var manager = GameSeasonsManager(
        temperature: intialTemperature, seasonDuration: seasonsDuration);
    var initialSeason = manager.current;
    manager.start();
    var durationOf4Seasons =
        Duration(seconds: manager.seasonDuration.inSeconds * 4 + 1);

    await Future.delayed(durationOf4Seasons, () {
      expect(manager.current, initialSeason);
    });
  });

  test("Keeps track of how many seasons have passed", () async {
    var manager = GameSeasonsManager(
        temperature: intialTemperature, seasonDuration: seasonsDuration);

    manager.start();
    var durationOf4Seasons =
        Duration(seconds: manager.seasonDuration.inSeconds * 4 + 1);

    await Future.delayed(durationOf4Seasons, () {
      expect(manager.seasonsPassed, 4);
    });
  });

  test("Pausing does not affect the seasons duration", () async {
    //okay so how do we test this
    //good question
    var manager = GameSeasonsManager(
        temperature: intialTemperature, seasonDuration: seasonsDuration);
    var halfSeason =
        Duration(seconds: (manager.seasonDuration.inSeconds / 2).round());
    manager.start();

    await Future.delayed(halfSeason, () {
      //let half a season pass and then pause
      manager.pause();
      expect(manager.seasonsPassed, 0);
    });
    await Future.delayed(halfSeason, () {
      //after one seasons duration
      //resume changing seasons
      manager.resume();
    });

    await Future.delayed(halfSeason, () {
      //check if only one season passed
      //since the duration of two seasons went by
      //but the manager was paused for one season duration
      expect(manager.seasonsPassed, 1);
    });
  });
}
