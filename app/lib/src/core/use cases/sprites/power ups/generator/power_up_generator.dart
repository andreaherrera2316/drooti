import 'dart:math';
import 'package:app/src/core/entities/game/difficulty/idifficulty.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/meter_limits_subscriber.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';
import 'package:app/src/core/use%20cases/sprites/isprite_displayer.dart';
import 'package:app/src/core/use%20cases/sprites/power%20ups/factory/ipower_up_factory.dart';
import 'package:app/src/core/use%20cases/sprites/power%20ups/generator/ipower_up_generator.dart';

class PowerUpGenerator
    with IDifficulty
    implements IPowerUpGenerator, MeterLimitsSubscriber {
  PowerUpGenerator({
    required this.powerUps,
    this.displayer,
    double genPowerUpsEvery = 50,
  }) {
    genEveryMeters = genPowerUpsEvery;
    _setNextGen(0);
  }

  IPowerUpFactory powerUps;
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
  void generatePowerUp() async {
    var powerUp = await powerUps.createPowerUp();
    powerUp.addToGame();
    displayer?.addSprite(powerUp);
  }

  @override
  void onLimitsUpdate(MeterLimits limits) {
    bool shouldGenerate = limits.bottom >= _nextGenerationAt && !_pause;

    if (shouldGenerate) {
      generatePowerUp();
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
