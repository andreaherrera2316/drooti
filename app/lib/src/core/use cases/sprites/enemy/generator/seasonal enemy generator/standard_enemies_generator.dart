import 'dart:math';

import 'package:app/src/core/use%20cases/sprites/enemy/generator/enemy_generator.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/imeter_limits_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/factory/ienemy_factory.dart';
import 'package:app/src/core/use%20cases/sprites/isprite_displayer.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/generator/seasonal%20enemy%20generator/seasonal_enemy_generator.dart';

class StandardEnemiesManager extends SeasonalEnemyGenerator {
  StandardEnemiesManager(
      {required IEnemyFactory stationary,
      required IEnemyFactory topToBottom,
      required IEnemyFactory sideToSide,
      required IMeterLimitsNotifier limitsNotifier,
      ISpriteDisplayer? displayer}) {
    _setUpEnemies(
        stationary, topToBottom, sideToSide, limitsNotifier, displayer);
  }

  @override
  List<SeasonOfYear> genSeasons = [
    SeasonOfYear.spring,
    SeasonOfYear.autumn,
  ];

  _setUpEnemies(
      IEnemyFactory stationary,
      IEnemyFactory topToBottom,
      IEnemyFactory sideToSide,
      IMeterLimitsNotifier limitsNotifier,
      ISpriteDisplayer? displayer) {
    bool doubleStationary = Random().nextBool();
    var gens = [
      EnemyGenerator(
        displayer: displayer,
        genEnemiesEveryMeters: 60,
        enemies: stationary,
      ),
      EnemyGenerator(
        displayer: displayer,
        genEnemiesEveryMeters: (doubleStationary ? 120 : 180) * 1.1,
        enemies: stationary,
      ),
      EnemyGenerator(
        displayer: displayer,
        genEnemiesEveryMeters: 20,
        enemies: topToBottom,
      ),
      EnemyGenerator(
        displayer: displayer,
        genEnemiesEveryMeters: 7,
        enemies: sideToSide,
      )
    ];
    for (var generator in gens) {
      limitsNotifier.addLimitsSub(generator);
    }
    generators.addAll(gens);
  }
}
