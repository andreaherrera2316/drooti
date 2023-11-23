import 'package:app/src/core/use%20cases/sprites/enemy/generator/ienemy_generator.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/generator/iseasonal_generator.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';
import 'dart:async';

abstract class SeasonalEnemyGenerator implements ISeasonalGenerator {
  List<IEnemyGenerator> generators = [];

  @override
  void onSeasonChange(SeasonOfYear season) {
    if (genSeasons.contains(season)) {
      Timer(const Duration(seconds: 1, milliseconds: 500), () => start());
    } else {
      pause();
    }
  }

  @override
  void reset() {
    for (var generator in generators) {
      generator.reset();
    }
  }

  @override
  void start() {
    for (var generator in generators) {
      generator.start();
    }
  }

  @override
  void pause() {
    for (var generator in generators) {
      generator.pause();
    }
  }
}
