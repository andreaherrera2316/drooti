// import 'dart:async';
// import 'package:app/resources/position.dart';
// import 'package:app/resources/dimensions.dart';
// import 'package:app/src/game%20rules/entities/game/difficulty/idifficulty.dart';
// import 'package:app/src/game%20rules/use%20cases/game/game%20managers/igame_manager.dart';
// import 'package:app/src/game%20rules/use%20cases/game/game%20managers/meters%20manager/calculations/calculate_meters.dart';
// import 'package:app/src/game%20rules/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20notifier/imeter_limits_notifier.dart';
// import 'package:app/src/game%20rules/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20notifier/meter_limits_subscriber.dart';
// import 'package:app/src/game%20rules/use%20cases/game/game%20managers/meters%20manager/meter.dart';
// import 'package:app/src/game%20rules/use%20cases/game/game%20managers/meters%20manager/meters%20notifier/imeters_notifier.dart';
// import 'package:app/src/game%20rules/use%20cases/game/game%20managers/meters%20manager/meters%20notifier/meters_subscriber.dart';
// import 'package:app/src/game%20rules/use%20cases/game/game%20managers/meters%20manager/meters_limit.dart';
// import 'package:app/src/views/game/game/controller/game%20size%20notifier/game_size_and_position_subscriber.dart';

// class GameMetersManager
//     with IDifficulty
//     implements
//         IMetersNotifier,
//         IMeterLimitsNotifier,
//         IGameManager,
//         GameSizeAndPositonSubscriber {
//   GameMetersManager({
//     required this.drootiMetersPerS,
//     required double drootiX,
//     required double drootiY,
//     required double gameHeight,
//     required double gameWidth,
//     required double drootiHeight,
//     double? drootiWidth,
//     this.gameMetersPerS = 5,
//     double pixelsPerMeter = 10,
//   })  : _meter = Meter(pixelsPerMeter: pixelsPerMeter),
//         _metersLimit = _getIntialLimit(gameHeight, pixelsPerMeter),
//         _drootiPosition = Position(x: drootiX, y: drootiY),
//         _drootiD = Dimensions(
//             height: drootiHeight, width: drootiWidth ?? drootiHeight),
//         _gameD = Dimensions(height: gameHeight, width: gameWidth),
//         _calc = CalculateMeters() {
//     _adjustLimitsToDrootiStart();
//   }

//   // todo:
//   //okay for the drone dimensinos
//   //and hte game dimensions
//   //i will do a notifier
//   //with a manager

//   double gameMetersPerS;
//   double drootiMetersPerS;
//   final Meter _meter;
//   MeterLimits _metersLimit;
//   final Dimensions _gameD;
//   //final Dimensions _drootiD;
//   final Position _drootiPosition;
//   final CalculateMeters _calc;

//   bool _pause = false;
//   bool _cancel = false;

//   double _metersMoved = 0;
//   double _maxMetersTravelled = 0;

//   ///Manager
//   @override
//   void start() {
//     _moveGame();
//   }

//   @override
//   void pause() {
//     _pause = true;
//   }

//   @override
//   void end() {
//     _cancel = true;
//   }

//   @override
//   void restart() {
//     // TODO: implement reset
//     //okay
//     //but on reset
//     //we would need to get drooti's position again
//     //and adjust the position to drooti start
//     _pause = false;
//     _cancel = false;
//     _metersMoved = 0;
//     _maxMetersTravelled = 0;
//     resetDifficulty();
//   }

//   @override
//   void resume() {
//     _pause = false;
//   }

//   ///

//   //?
//   // void onDrootiResize(double? height, double? width) {
//   //   if (height != null) {
//   //     _drootiD.height = height;
//   //   }

//   //   if (width != null) {
//   //     _drootiD.width = width;
//   //   }
//   // }

//   @override
//   void onGameResize(
//     double heightInPixels,
//     double widthInPixels, [
//     bool topToBottom = true,
//     double? drootiX,
//     double? drootiY,
//   ]) {
//     if (drootiY != null) {
//       _setDrootiY(drootiY, topToBottom);
//     }

//     if (drootiX != null) {
//       _drootiPosition.x = drootiX;
//     }

//     _gameD.height = heightInPixels;
//     _gameD.width = widthInPixels;

//     _readjustLimitsToNewGameHeight();
//   }

//   //*
//   void onDrootiMoved(double drootiX, double drootiY,
//       [bool topToBottom = true]) {
//     _setDrootiY(drootiY, topToBottom);
//     _drootiPosition.x = drootiX;

//     _onDrootiMovedUpdateMeters();
//   }

//   //*
//   void setDrootiStartPoint(double drootiX, double drootiY,
//       [bool topToBottom = true]) {
//     _drootiPosition.x = drootiX;
//     _setDrootiY(drootiY, topToBottom);
//     _adjustLimitsToDrootiStart();
//   }

//   //?
//   double get difficultyIncrease {
//     return difficulty * gameMetersPerS / 10;
//   }

//   double get _metersInScreen => _gameD.height / _meter.pixelsPerMeter;

//   double get _drootiAtScreenPercent =>
//       _calc.drootiAtScreenPercent(_drootiPosition.y, _gameD.height);

//   double get _topLimit => _gameD.height - (_drootiD.height * 1.15);
//   //?

//   //*
//   set _setMaxMetersTravelled(double travelledTo) {
//     _maxMetersTravelled = travelledTo;
//     updateMeters();
//   }

//   //*
//   set _setMetersLimits(MeterLimits limits) {
//     _metersLimit = limits;
//     meterLimitsUpdate(_metersLimit);
//   }

//   //*
//   void _increaseLimits(double meters) {
//     _metersLimit.increaseLimits(meters);
//     meterLimitsUpdate(_metersLimit);
//   }

// //*
//   void _onDrootiMovedUpdateMeters() {
//     _setMaxMetersTravelled = _metersMoved + _drootiTravelledWithinScreen;
//   }

// //*
//   ///adjust the meter limits so that wherever drooti is initally positioned is
//   ///equal to 0 metersTravelled
//   void _adjustLimitsToDrootiStart() {
//     _setMetersLimits = _calc.readjustLimitsAroundDrooti(
//         _drootiAtScreenPercent, 0, _metersInScreen, _meter.pixelsPerMeter);
//   }

//   void _readjustLimitsToNewGameHeight() {
//     double drootiAtMeters = _drootiTravelledWithinScreen + _metersMoved;
//     _setMetersLimits = _calc.readjustLimitsAroundDrooti(_drootiAtScreenPercent,
//         drootiAtMeters, _metersInScreen, _meter.pixelsPerMeter);
//   }

//   //*
//   void _setDrootiY(double drootiY, bool topToBottom) {
//     if (topToBottom) {
//       _drootiPosition.y = _gameD.height - drootiY;
//     } else {
//       _drootiPosition.y = drootiY;
//     }
//   }

//   //*
//   double _increaseIfHittingTop() {
//     bool droneIsAtTopLimit = _drootiPosition.y >= _topLimit;
//     return droneIsAtTopLimit ? drootiMetersPerS : 0;
//   }

//   //* ////////////////////////////////////////

//   void _moveGame() {
//     //okay we are moving this to imits essential
//     Timer.periodic(const Duration(milliseconds: 25), (timer) {
//       if (_cancel) {
//         timer.cancel();
//       }
//       if (!_pause) {
//         double increaseByMeters =
//             gameMetersPerS + difficultyIncrease + _increaseIfHittingTop();
//         _increseMetersMoved(increaseByMeters * 0.025);
//       }
//     });
//   }

//   void _increseMetersMoved(double meters) {
//     _metersMoved += meters;
//     _maxMetersTravelled +=
//         meters; //okay, drooti meters has to take care of this

//     _increaseLimits(meters);
//     updateMeters();
//   }

//   static MeterLimits _getIntialLimit(
//       double screenHeight, double pixelsPerMeter) {
//     double metersOnScreen = screenHeight / pixelsPerMeter;

//     return (MeterLimits(
//         top: metersOnScreen, bottom: 0, pixelsPerMeter: pixelsPerMeter));
//   }

//   @override
//   void addMetersSub(MetersSubscriber sub) {
//     metersSubs.add(sub);
//     sub.onMetersUpdate(_metersMoved, _meter.pixelsPerMeter);
//   }

//   @override
//   void removeMetersSub(MetersSubscriber sub) {
//     metersSubs.remove(sub);
//   }

//   @override
//   void updateMeters([meters = 0, pixelsPerMeter = 0]) {
//     for (var sub in metersSubs) {
//       sub.onMetersUpdate(_maxMetersTravelled, _meter.pixelsPerMeter);
//     }
//   }

//   @override
//   void addLimitsSub(MeterLimitsSubscriber sub) {
//     limitsSubs.add(sub);
//     sub.onLimitsUpdate(_metersLimit);
//   }

//   @override
//   void meterLimitsUpdate(limits) {
//     for (var sub in limitsSubs) {
//       sub.onLimitsUpdate(_metersLimit);
//     }
//   }

//   @override
//   void removeLimitsSub(MeterLimitsSubscriber sub) {
//     limitsSubs.remove(sub);
//   }
// }
