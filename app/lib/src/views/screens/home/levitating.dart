import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:app/src/views/screens/game/components/drooti/animations/drooti_animations.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:rive/rive.dart';

class Levatating extends StatefulWidget {
  Levatating(
      {required this.content,
      this.maxTurnAngle = 0.22,
      this.maxOffsetX = 30,
      this.maxOffsetY = 15,
      this.turns = 23,
      this.stepDuration = const Duration(milliseconds: 25),
      this.startAfter = const Duration(milliseconds: 500),
      super.key});
  final double maxTurnAngle;
  final double maxOffsetX;
  final double maxOffsetY;
  final Duration stepDuration;
  final Widget content;
  final int turns;
  final Duration startAfter;

  @override
  State<Levatating> createState() => _LevatatingState();

  bool _stop = false;

  void stop() {
    _stop = true;
  }
}

class _LevatatingState extends State<Levatating> {
  Artboard? drootiArtboard;
  var animate = DrootiAnimations();

  double rotation = 0;
  bool goUp = false;
  bool stayOnSideX = false;
  bool stayOnSideY = false;
  bool goLeft = false;
  int turnsLeftX = 0;
  int turnsLeftY = 0;

  double angleChange = 0;
  bool firstTurnX = true;
  bool firstTurnY = false;
  bool turning = false;

  double offsetX = 0;
  double offsetY = 0;
  double offsetXChange = 0;
  double offsetYChange = 0;

  _startMoving() {
    Timer(widget.startAfter, () {
      setState(() {
        _turning();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!turning) {
      turning = true;
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => Timer(const Duration(seconds: 3), () => _startMoving()));
    }
    var rotating = Transform.rotate(
        alignment: Alignment.bottomCenter,
        angle: rotation,
        child: Center(child: widget.content));
    return Transform.translate(
        offset: Offset(offsetX, offsetY), child: rotating);
  }

  //the more turns the more the animation flows,
  int get randTime => (Random().nextInt(50) + 100).round();
  int get randTurns => (widget.turns * 0.7).round();
  int get randomTurns => Random().nextInt(randTurns) + widget.turns;

  //TURNING X

  _turning() {
    _turningX();
    _turningY();
  }

  _turningX() {
    Timer.periodic(widget.stepDuration, (timer) {
      if (widget._stop) {
        timer.cancel();
      } else if (!stayOnSideX) {
        if (goLeft) {
          _turnLeft();
        } else {
          _turnRight();
        }
      }
    });
  }

  _turnLeft() {
    if (turnsLeftX <= 0) {
      _changeDirectionX();

      _resetTurnsX();
    } else {
      _turnX(-angleChange);
      _moveX(-offsetXChange);
    }
  }

  _turnRight() {
    if (turnsLeftX <= 0) {
      _changeDirectionX();
      _resetTurnsX();
    } else {
      _turnX(angleChange);
      _moveX(offsetXChange);
    }
  }

  _moveX(double moveBy) {
    setState(() {
      offsetX += moveBy * 1.1; //so it the x animation is and ease in
    });
  }

  _changeDirectionX() {
    goLeft = !goLeft;
    stayOnSideX = true;
    Timer(Duration(milliseconds: randTime), () {
      stayOnSideX = false;
    });
  }

  _turnX(double degrees) {
    setState(() {
      rotation += degrees;
      turnsLeftX--;
    });
  }

  _resetTurnsX() {
    turnsLeftX = randomTurns;
    _resetOffsetX();

    if (firstTurnX) {
      setState(() {
        firstTurnX = false;
        angleChange = widget.maxTurnAngle / 2 / turnsLeftX;
      });
    } else {
      setState(() {
        angleChange = widget.maxTurnAngle / turnsLeftX;
      });
    }
  }

  _resetOffsetX() {
    offsetXChange = widget.maxOffsetX / turnsLeftX;
  }

  _turningY() {
    Timer.periodic(widget.stepDuration, (timer) {
      if (widget._stop) {
        timer.cancel();
      } else if (!stayOnSideY) {
        if (goUp) {
          _goUp();
        } else {
          _goDown();
        }
      }
    });
  }

  _goUp() {
    if (turnsLeftY <= 0) {
      _changeDirectionY();
      _resetTurnsY();
    } else {
      _turnY();
      _moveY(-offsetYChange);
    }
  }

  _goDown() {
    if (turnsLeftY <= 0) {
      _changeDirectionY();
      _resetTurnsY();
    } else {
      _turnY();
      _moveY(offsetYChange);
    }
  }

  _moveY(double moveBy) {
    setState(() {
      offsetY += moveBy;
    });
  }

  _turnY() {
    setState(() {
      turnsLeftY--;
    });
  }

  _resetTurnsY() {
    var multiplier = Random().nextBool() ? 2 : 4;
    turnsLeftY = (randomTurns * multiplier).round();
    _resetOffsetY();

    if (firstTurnY) {
      setState(() {
        firstTurnY = false;
        offsetYChange = widget.maxOffsetY / turnsLeftY / 2;
      });
    } else {
      setState(() {
        var offset = widget.maxOffsetY / turnsLeftY;
        offsetYChange = offset;
      });
    }
  }

  _resetOffsetY() {
    offsetYChange = widget.maxOffsetY / turnsLeftY;
  }

  _changeDirectionY() {
    goUp = !goUp;
    stayOnSideY = true;
    var multiplier = Random().nextBool() ? 3 : 6;
    Timer(Duration(milliseconds: randTime * multiplier), () {
      stayOnSideY = false;
    });
  }
}
