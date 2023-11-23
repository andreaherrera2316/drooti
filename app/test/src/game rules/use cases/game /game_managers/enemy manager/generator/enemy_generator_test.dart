import 'package:app/src/core/use%20cases/sprites/enemy/generator/enemy_generator.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/factory/ienemy_factory.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/ienemy.dart';
import 'package:app/src/core/use%20cases/sprites/isprite.dart';
import 'package:app/src/core/use%20cases/sprites/isprite_displayer.dart';
import 'package:app/src/core/use%20cases/sprites/power%20ups/ipower_up.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      "should generate enemies and add them to the game and dipsplayer if given",
      () {
    var displayer = DisplayerMock();
    var factory = FactoryMock();
    var limits = MeterLimits(pixelsPerMeter: 10, top: 10, bottom: 0);

    var generator = EnemyGenerator(
      enemies: factory,
      displayer: displayer,
      genEnemiesEveryMeters: 1,
    );

    expect(displayer.sprites.length, 0);
    expect(factory.enemy == null, true);

    limits.increaseLimits(2);
    generator.onLimitsUpdate(limits);

    Future.delayed(const Duration(milliseconds: 100), () {
      expect(displayer.sprites.length, 1);
      expect(factory.enemy!.isActive, true);
    });
  });

  test("it should randomize a small percentage the genEveryMeters", () {
    var factory = FactoryMock();
    var generator = EnemyGenerator(
      enemies: factory,
      genEnemiesEveryMeters: 1,
    );

    expect(generator.nextGenerationAt != 1, true);
    expect(generator.nextGenerationAt.round() == 1, true);
  });

  test(
      "on meter limits update, generator checks if genEveryMeters have passed to generate an enemy",
      () {
    var factory = FactoryMock();
    var generator = EnemyGenerator(
      enemies: factory,
      genEnemiesEveryMeters: 1,
    );
    var limits = MeterLimits(pixelsPerMeter: 10, top: 1, bottom: 0);

    generator.onLimitsUpdate(limits);
    expect(factory.enemy == null, true);

    limits.increaseLimits(1.5);
    Future.delayed(const Duration(milliseconds: 100), () {
      expect(factory.enemy!.isActive, true);
    });
  });

  test("cannot set gen every meters to a negative number", () {
    var factory = FactoryMock();
    bool error = false;
    try {
      EnemyGenerator(enemies: factory, genEnemiesEveryMeters: -1);
    } catch (e) {
      error = true;
    }
    expect(error, true);

    error = false;
    try {
      EnemyGenerator(enemies: factory, genEnemiesEveryMeters: 1)
          .genEveryMeters = -1;
    } catch (e) {
      error = true;
    }
    expect(error, true);
  });

  test("when the difficulty increases the enemies are generated faster", () {
    var factory = FactoryMock();
    var generator = EnemyGenerator(
      enemies: factory,
      genEnemiesEveryMeters: 1000,
    );
    var limits = MeterLimits(pixelsPerMeter: 10, top: 1, bottom: 0);

    expect(generator.difficulty, 1);
    var initialNextGen = generator.nextGenerationAt;

    limits.increaseLimits(initialNextGen);
    generator.onLimitsUpdate(limits);
    var diff1NextGen = generator.nextGenerationAt;
    var genDifferenceDiff1 = generator.nextGenerationAt - initialNextGen;

    for (int i = 1; i < 10; i++) {
      generator.increaseDifficulty();
    }
    expect(generator.difficulty, 10);

    limits.increaseLimits(genDifferenceDiff1);
    var genDifferenceDiff10 = generator.nextGenerationAt - diff1NextGen;
    expect(genDifferenceDiff1 > genDifferenceDiff10, true);
    //the distance between generations should be smaller when difficulty is higher
  });

  test("when the game resets difficulty should be reset", () {
    var factory = FactoryMock();
    var generator = EnemyGenerator(
      enemies: factory,
      genEnemiesEveryMeters: 1000,
    );

    expect(generator.difficulty, 1);
    for (int i = 1; i < 10; i++) {
      generator.increaseDifficulty();
    }
    expect(generator.difficulty, 10);

    generator.reset();
    expect(generator.difficulty, 1);
  });

  test("when the game resets nextGenerationAt should be reset", () {
    var factory = FactoryMock();
    var generator = EnemyGenerator(
      enemies: factory,
      genEnemiesEveryMeters: 1,
    );
    var limits = MeterLimits(pixelsPerMeter: 10, top: 100, bottom: 10);
    expect(generator.nextGenerationAt.round(), 1);
    generator.onLimitsUpdate(limits);
    expect(generator.nextGenerationAt.round(), (limits.bottom + 1).round());

    generator.reset();
    expect(generator.nextGenerationAt.round(), 1);
  });
}

class DisplayerMock implements ISpriteDisplayer {
  List<ISprite> sprites = [];
  @override
  void addSprite(ISprite sprite) {
    sprites.add(sprite);
  }
}

class SpriteMock extends ISprite {
  bool _isActive = true;
  double _angle = 0;

  @override
  double get angleInDegrees => _angle;

  @override
  bool get isActive => _isActive;

  @override
  void addToGame() {
    _isActive = true;
  }

  @override
  void moveX(double byPixels) {
    x += byPixels;
  }

  @override
  void moveY(double byPixels) {
    y += byPixels;
  }

  @override
  void removeFromGame() {
    _isActive = false;
  }

  @override
  void rotate(double degrees) {
    _angle += degrees;
  }
}

class EnemyMock extends SpriteMock implements IEnemy {
  double damaged = 0;
  @override
  void damage() {
    damaged++;
  }
}

class PowerUpMock extends SpriteMock implements IPowerUp {
  double poweredUp = 0;
  @override
  void powerUp() {
    poweredUp++;
  }
}

class FactoryMock implements IEnemyFactory {
  IEnemy? enemy;
  @override
  Future<IEnemy> createEnemy() async {
    enemy = EnemyMock();
    return enemy!;
  }
}
