import 'dart:math';

import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20subscriber/idrone_main_vitals_subscriber.dart';
import 'package:app/src/core/use%20cases/sprites/power%20ups/factory/ipower_up_factory.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/iflame_power_up.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/load_flame_power_up.dart';
import 'package:flame/game.dart';

class PowerUpFactory implements IPowerUpFactory, IDroneMainVitalsSubscriber {
  PowerUpFactory({
    required this.gameActions,
    required this.game,
    bool topToBottom = true,
  }) : _topToBottom = topToBottom {
    batteryPowerUps.addAll([
      _sun,
      _lightning,
    ]);
    motorPowerUps.add(_gear);
    wildcardPowerUps.add(_atom);
    randomPowerUps.addAll([
      _batteryPowerUp,
      _motorPowerUp,
      _wildcard,
    ]);
  }

  IGameActions gameActions;
  FlameGame game;
  final bool _topToBottom;

  double _batteryPercent = 0;
  double _batteryHealth = 0;
  double _motorHealth = 0;

  final List<Future<IFlamePowerUp> Function()> batteryPowerUps = [];
  final List<Future<IFlamePowerUp> Function()> motorPowerUps = [];
  final List<Future<IFlamePowerUp> Function()> wildcardPowerUps = [];
  final List<Future<IFlamePowerUp> Function()> randomPowerUps = [];

  bool get batteryHealthLow => _batteryPercent < 30;
  bool get motorLow => _motorHealth < 30;
  bool get batteryLow => _batteryHealth < 30;

  bool get batteryHealthVeryLow => _batteryPercent < 10;
  bool get motorVeryLow => _motorHealth < 10;
  bool get batteryVeryLow => _batteryHealth < 10;

  @override
  Future<IFlamePowerUp> createPowerUp() async {
    bool allVeryLow = batteryHealthVeryLow && motorVeryLow && batteryVeryLow;
    bool allLow = batteryHealthLow && motorLow && batteryLow;
    Future<IFlamePowerUp> powerUp;
    if (allVeryLow) {
      powerUp = _powerUpForLowest();
    } else if (allLow) {
      bool randomize = Random().nextBool();
      powerUp = randomize ? _randomPowerUp() : _powerUpForLowest();
    } else {
      powerUp = _randomPowerUp();
    }
    return await powerUp;
  }

  Future<IFlamePowerUp> _powerUpForLowest() {
    if (_motorHealth < _batteryPercent) {
      return _motorPowerUp();
    } else {
      return _batteryPowerUp();
    }
  }

  @override
  void onBatteryHealthUpdate(double health) {
    _batteryHealth = health;
  }

  @override
  void onBatteryPercentUpdate(double batteryPercent) {
    _batteryPercent = batteryPercent;
  }

  @override
  void onMotorHealthUpdate(double health) {
    _motorHealth = health;
  }

  Future<IFlamePowerUp> _batteryPowerUp() {
    return _getRandomPowerUp(batteryPowerUps);
  }

  Future<IFlamePowerUp> _motorPowerUp() {
    return _getRandomPowerUp(motorPowerUps);
  }

  Future<IFlamePowerUp> _wildcard() {
    return _getRandomPowerUp(wildcardPowerUps);
  }

  Future<IFlamePowerUp> _randomPowerUp() {
    return _getRandomPowerUp(randomPowerUps);
  }

  Future<IFlamePowerUp> _sun() {
    return LoadFlamePowerUp().sun(_topToBottom, gameActions, game);
  }

  Future<IFlamePowerUp> _getRandomPowerUp(
      List<Future<IFlamePowerUp> Function()> powerUps) {
    Future<IFlamePowerUp> Function() randomPowerUp =
        powerUps[Random().nextInt(powerUps.length)];
    return randomPowerUp();
  }

  Future<IFlamePowerUp> _lightning() {
    return LoadFlamePowerUp().lightning(_topToBottom, gameActions, game);
  }

  Future<IFlamePowerUp> _gear() {
    return LoadFlamePowerUp().gear(_topToBottom, gameActions, game);
  }

  Future<IFlamePowerUp> _atom() {
    return LoadFlamePowerUp().atom(_topToBottom, gameActions, game);
  }
}
