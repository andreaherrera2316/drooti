import 'dart:math';

import 'package:app/src/core/entities/game/difficulty/idifficulty.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/generator/ienemy_generator.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/meter_limits_subscriber.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/factory/ienemy_factory.dart';
import 'package:app/src/core/use%20cases/sprites/isprite_displayer.dart';

class EnemyGenerator
    with IDifficulty
    implements IEnemyGenerator, MeterLimitsSubscriber {
  EnemyGenerator({
    required this.enemies,
    this.displayer,
    double genEnemiesEveryMeters = 10,
  }) {
    genEveryMeters = genEnemiesEveryMeters;
    _setNextGen(0);
  }

  IEnemyFactory enemies;
  ISpriteDisplayer? displayer;
  double _genEveryMeters = 0;
  double _nextGenerationAt = 0;
  double get genEveryMeters => _genEveryMeters;
  double get nextGenerationAt => _nextGenerationAt;
  bool _pause = false;

  set genEveryMeters(double meters) {
    if (meters >= 0) {
      _genEveryMeters = meters;
    } else {
      throw Exception("genEveryMeters can't be negative");
    }
  }

  @override
  void pause() {
    _pause = true;
  }

  @override
  void start() {
    _pause = false;
  }

  @override
  void reset() {
    _pause = false;
    resetDifficulty();
    _setNextGen(0);
  }

  @override
  void generateEnemy() async {
    var enemy = await enemies.createEnemy();
    enemy.addToGame();
    displayer?.addSprite(enemy);
  }

  @override
  void onLimitsUpdate(MeterLimits limits) {
    bool shouldGenerate = limits.bottom >= _nextGenerationAt && !_pause;

    if (shouldGenerate) {
      generateEnemy();
      _setNextGen(limits.bottom);
    }
  }

  void _setNextGen(double limitsBottom) {
    var difficultyDecrease = (difficulty / 100);
    var multplier = 1 - difficultyDecrease;
    var genAfterMeters = genEveryMeters * multplier;
    _nextGenerationAt =
        limitsBottom + genAfterMeters + _randomizeGeneration(genAfterMeters);
  }

  double _randomizeGeneration(double genEvery) {
    double maxRand = genEvery * 0.1;
    var rand = Random().nextDouble() * maxRand;
    var sign = Random().nextInt(2);
    if (sign == 0) {
      rand *= -1;
    }
    return rand;
  }
}
