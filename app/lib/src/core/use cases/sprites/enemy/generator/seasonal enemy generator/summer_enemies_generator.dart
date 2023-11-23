import 'package:app/src/core/use%20cases/sprites/enemy/generator/enemy_generator.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/imeter_limits_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/season/season_of_year.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/factory/ienemy_factory.dart';
import 'package:app/src/core/use%20cases/sprites/isprite_displayer.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/generator/seasonal%20enemy%20generator/seasonal_enemy_generator.dart';

class SummerEnemiesManager extends SeasonalEnemyGenerator {
  SummerEnemiesManager(
      {required IEnemyFactory sideToSide,
      required IMeterLimitsNotifier limitsNotifier,
      ISpriteDisplayer? displayer}) {
    _setUpEnemies(sideToSide, limitsNotifier, displayer);
  }

  @override
  List<SeasonOfYear> genSeasons = [
    SeasonOfYear.summer,
  ];

  _setUpEnemies(IEnemyFactory sideToSide, IMeterLimitsNotifier limitsNotifier,
      ISpriteDisplayer? displayer) {
    var gens = [
      EnemyGenerator(
        displayer: displayer,
        genEnemiesEveryMeters: 4,
        enemies: sideToSide,
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

    generators = gens;
  }
}
