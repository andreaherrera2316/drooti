// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:app/src/core/entities/properties/dimensions.dart';
import 'package:app/src/core/entities/properties/position.dart';
import 'package:app/src/core/entities/game/difficulty/idifficulty.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/igame_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/calculations/calculate_meters.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/meter_limits_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/meter_limits_subscriber.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/drone%20meters%20manager/meters%20notifier/meters_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';
import 'package:app/src/views/screens/game/controller/game%20size%20notifier/game_size_subscriber.dart';

class DroneMetersManager extends MetersNotifier
    implements MeterLimitsSubscriber {
  DroneMetersManager(
      {required this.pixelsPerMeter,
      double gameHeight = 10,
      double gameWidth = 10,
      double drootiX = 0,
      double drootiY = 0})
      : _calc = CalculateMeters(),
        _gameD = Dimensions(height: gameHeight, width: gameWidth),
        _drootiPosition = Position(x: drootiX, y: drootiY);

  final CalculateMeters _calc;
  final Position _drootiPosition;
  final Dimensions _gameD;
  double pixelsPerMeter;
  double _metersTravelled = 0;
  double bottomLimit = 0;

  double get drootiY => _drootiPosition.y;

  double get metersTravelled => _metersTravelled;

  double get metersInScreen => _gameD.height / pixelsPerMeter;

  double get drootiAtScreenPercent =>
      _calc.drootiAtScreenPercent(_drootiPosition.y, _gameD.height);

  set metersTravelled(double travelledTo) {
    if (travelledTo >= 0) {
      _metersTravelled = travelledTo;
      updateMeters(_metersTravelled, pixelsPerMeter);
    }
  }

  void setDrootiStart(double drootiX, double drootiY,
      [bool topToBottom = true]) {
    _drootiPosition.x = drootiX;
    _setDrootiY(drootiY, topToBottom);
  }

  void onDrootiMoved(double drootiX, double drootiY,
      [bool topToBottom = true]) {
    _setDrootiY(drootiY, topToBottom);
    _drootiPosition.x = drootiX;

    _onDrootiMovedUpdateMeters();
  }

  @override
  void onLimitsUpdate(MeterLimits limits) {
    var meters = limits.bottom - bottomLimit;
    bottomLimit = limits.bottom;
    _updateMetersMoved(meters);
  }

  void _updateMetersMoved(double meters) {
    metersTravelled += meters;
    updateMeters(metersTravelled, pixelsPerMeter);
  }

  void _setDrootiY(double drootiY, bool topToBottom) {
    if (topToBottom) {
      _drootiPosition.y = _gameD.height - drootiY;
    } else {
      _drootiPosition.y = drootiY;
    }
  }

  double get _drootiTravelledWithinScreen => _calc.metersTravelledWithinScreen(
      drootiAtScreenPercent, metersInScreen, bottomLimit);

  //okay i think the reason this
  void _onDrootiMovedUpdateMeters() {
    metersTravelled = bottomLimit + _drootiTravelledWithinScreen;
  }
}

class MainMetersManager
    with IDifficulty
    implements IGameManager, GameSizeSubscriber {
  MainMetersManager({
    required this.drootiMetersPerS,
    this.gameMetersPerS = 5,
    double pixelsPerMeter = 10,
    required double drootiX,
    required double drootiY,
    required double gameHeight,
    required double gameWidth,
    required double drootiHeight,
  })  : metersManager = DroneMetersManager(pixelsPerMeter: pixelsPerMeter),
        _meter = Meter(pixelsPerMeter: pixelsPerMeter),
        _calc = CalculateMeters() {
    limitsManager = MeterLimitsManager(
        meterLimits: _getIntialLimits(gameHeight, pixelsPerMeter),
        calcIncreasePerMove: calcLimitIncrease);

    _init();
    _adjustLimitsToDrootiStart();
  }

  late MeterLimitsManager limitsManager;
  DroneMetersManager metersManager;
  final Meter _meter;
  double gameMetersPerS;
  double drootiMetersPerS;
  final CalculateMeters _calc;

  MeterLimitsNotifier get limitsNotifier => limitsManager;
  MetersNotifier get droneMetersNotifier => metersManager;

  double get difficultyIncrease {
    return difficulty * gameMetersPerS / 10;
  }

  double calcLimitIncrease() {
    return gameMetersPerS + difficultyIncrease + _increaseIfHittingTop();
  }

  //*
  double _increaseIfHittingTop() {
    bool droneIsAtTopLimit =
        metersManager.drootiY >= limitsManager.meterLimits.top;
    return droneIsAtTopLimit ? drootiMetersPerS : 0;
  }

  _init() {
    limitsManager.addLimitsSub(metersManager);
    //we will add the subscriptions needed in init
    //for the hitting top and max meters travelled
  }

  @override
  void start() {
    limitsManager.moveGame();
  }

  @override
  void end() {
    limitsManager.endGame();
  }

  @override
  void pause() {
    limitsManager.pauseGame();
  }

  @override
  void resume() {
    limitsManager.moveGame();
  }

  @override
  void restart() {
    //   _pause = false;
    // _cancel = false;
    // _metersMoved = 0;
    // _maxMetersTravelled = 0;
    // resetDifficulty();
  }

//adjust the meter limits so that wherever drooti is initally positioned is
//equal to 0 metersTravelled
  void _adjustLimitsToDrootiStart() {
    var newLimits = _calc.readjustLimitsAroundDrooti(
        metersManager.drootiAtScreenPercent,
        0,
        metersManager.metersInScreen,
        _meter.pixelsPerMeter);
    limitsManager.meterLimits = newLimits;
  }

  static MeterLimits _getIntialLimits(
      double screenHeight, double pixelsPerMeter) {
    double metersOnScreen = screenHeight / pixelsPerMeter;

    return (MeterLimits(
        top: metersOnScreen, bottom: 0, pixelsPerMeter: pixelsPerMeter));
  }

  //okay you got this
  //understood me?
  //YOU GOT THIS
  //It's in the bag
  //okay so first of
  //You will need to
  //do the todo here
  //then you have to go back
  //and set up the background updates
  //then once everything seems to work alright
  //go find every mistake you can
  //and take it on one by one
  //and then when everything is okay
  //you come back
  //and you divide the code
  //you refactor
  //and then you upload your code with pending tests it's alright

  //and you focus on scraps
  //but scraps is tomorrow me's work

  //todo
  //okay so the only functionality i believe we have not implemented is the on hitting top
  //and the max meters travelled
  //they will both subscribe to meters updates
  //and the drooti dimension where necessary for the hittin tip funcitonality

  //do i need a dimensions manger?
  //that will have game dimensions and drooti dimensions
  //not a bad idea
  //we could have a dimension notifier
  //that would manage both screen and drooti dimensions
  void onDrootiResize(double? height, double? width) {
    // metersManager.onDrootiResize(height, width);
    //the drootiSize concerns the hittingTop
    //which we will implement later
    //once this runs
  }

  //*temp methods
  //we will get rid of it an use a position notifier instead

  //today could be the day
  //for real
  //and we should be able to finish this tonight
  //if we wanted to
  //up to you
  //but let me just remind you

  //        _ _ _
  //  _ _ _ _ _ _ _ _ _

  //now give it everything
  //ans have your resume in first thing monday morning
  //on ten jobs
  //and same thing everyday
  //everytday we apply to 10 jobs
  //and we take the cs50 course
  //practice algorithms for interviews
  //and do clinics

  //say each you do for two hours
  //and then an extra 2 for anything else
  //you will have 2 10 hour a weeks
  //and hten you will be done
  //you will be able to leave
  //and you will be right on time
  //so let's go
  //let's do this
  //give it everything you have
  //two weeks starting today

  void onDrootiMoved(double x, double y) {
    metersManager.onDrootiMoved(x, y);
  }

  void setDrootiStartPoint(double drootiX, double drootiY,
      [bool topToBottom = true]) {
    metersManager.setDrootiStart(drootiX, drootiY, topToBottom);

    _adjustLimitsToDrootiStart();
  }

  @override
  void onGameResize(double heightInPixels, double widthInPixels) {
    // TODO: implement onGameResize
  }
}

class MeterLimitsManager extends MeterLimitsNotifier {
  MeterLimitsManager(
      {required this.meterLimits, required this.calcIncreasePerMove});

  MeterLimits meterLimits;
  double Function() calcIncreasePerMove;

  bool _pause = false;
  bool _cancel = false;

  void moveGame() {
    if (!_pause) {
      _initTimer();
    }
    _pause = false;
  }

  void pauseGame() {
    _pause = true;
  }

  void endGame() {
    _cancel = true;
  }

  void onMove() {
    double increaseByMeters = calcIncreasePerMove();
    // _increseMetersMoved(increaseByMeters * 0.025);
    _increaseLimits(increaseByMeters * 0.025);
  }

  void _increaseLimits(double meters) {
    meterLimits.increaseLimits(meters);
    meterLimitsUpdate(meterLimits);
  }

  void _initTimer() {
    Timer.periodic(const Duration(milliseconds: 25), (timer) {
      if (_cancel) {
        timer.cancel();
      }
      if (!_pause) {
        onMove();
      }
    });
  }
}
