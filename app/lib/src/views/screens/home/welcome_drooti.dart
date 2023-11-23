import 'dart:async';
import 'dart:math';

import 'package:app/src/views/screens/game/components/drooti/animations/drooti_animations.dart';
import 'package:app/src/views/screens/game/components/load_rive_artboard.dart';
import 'package:app/src/views/screens/home/levitating.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class WelcomeDrooti extends StatefulWidget {
  const WelcomeDrooti(
      {required this.drootiSize,
      required this.boxWidth,
      this.boxHeight,
      this.maxTurnAngle = 0.25,
      this.maxOffsetX = 30,
      this.maxOffsetY = 15,
      super.key});
  final double boxWidth;
  final double? boxHeight;
  final double drootiSize;
  final double maxTurnAngle;
  final double maxOffsetX;
  final double maxOffsetY;

  @override
  State<WelcomeDrooti> createState() => _WelcomeDrootiState();
}

class _WelcomeDrootiState extends State<WelcomeDrooti> {
  Artboard? drootiArtboard;
  var animate = DrootiAnimations();
  double _collisions = 0;
  bool drootiIsDead = false;
  double rotation = 0;

  bool stayOnSide = false;

  bool goLeft = false;
  int turnsLeft = 0;
  double angleChange = 0;
  bool firstTurn = true;
  double offsetX = 0;
  double offsetY = 0;
  double offsetXChange = 0;
  double offsetYChange = 0;

  @override
  Widget build(BuildContext context) {
    var boxColor = Colors.grey[300]!;
    var radius = const Radius.circular(35);
    var decoration = BoxDecoration(
      color: Colors.grey[200],
      border: Border.all(color: boxColor, width: 0.5),
      boxShadow: kElevationToShadow[2],
      borderRadius: BorderRadius.all(radius),
    );

    var drooti = Levatating(
        maxOffsetX: widget.maxOffsetX,
        maxOffsetY: widget.maxOffsetY,
        content: LoadWelcomeDrooti(
          size: widget.drootiSize,
          onArtboardLoaded: _startAnimations,
        ));

    if (drootiIsDead) {
      drooti.stop();
    }

    var display = Container(
      width: widget.boxWidth,
      decoration: decoration,
      margin: const EdgeInsets.only(top: 30),
      child: drooti,
    );

    return GestureDetector(
      onTap: _collide,
      child: display,
    );
  }

  void _startAnimations(Artboard drooti) {
    drootiArtboard = drooti;
    _flying(drooti);
    _periodicPowerUps(drooti);
    _ifTooLongInScreen(drooti);
  }

  void _flying(Artboard drooti) {
    Timer(const Duration(seconds: 1), () {
      animate.takeOff(drooti);
    });
  }

  void _periodicPowerUps(Artboard drooti) {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (drootiIsDead) {
        timer.cancel();
      }
      var rand = Random().nextInt(3);
      if (rand == 1) {
        animate.powerUp(drooti);
      }
    });
  }

  void _ifTooLongInScreen(Artboard drooti) {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      _drootiDies();
      animate.freeze(drooti);
    });
  }

  void _collide() {
    if (drootiArtboard != null && !drootiIsDead) {
      if (_collisions >= 16) {
        _explode();
      } else {
        animate.collide(drootiArtboard!);
        _collisions++;
      }
    }
  }

  void _explode() {
    _drootiDies();
    animate.explode(drootiArtboard!);
  }

  void _drootiDies() {
    setState(() {
      drootiIsDead = true;
    });
  }
}

class LoadWelcomeDrooti extends StatefulWidget {
  const LoadWelcomeDrooti({this.size, this.onArtboardLoaded, super.key});
  final double? size;

  final Function(Artboard artboard)? onArtboardLoaded;

  @override
  State<LoadWelcomeDrooti> createState() => _LoadWelcomeDrootiState();
}

class _LoadWelcomeDrootiState extends State<LoadWelcomeDrooti> {
  Artboard? drootiArtboard;

  void loadDrootiAsset() async {
    setState(() {
      drootiArtboard = LoadRiveArtboard().getArtboard("Drooti");

      if (drootiArtboard != null) widget.onArtboardLoaded!(drootiArtboard!);
    });
  }

  @override
  void initState() {
    super.initState();
    loadDrootiAsset();
  }

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    double size = widget.size ?? s.height * 0.2;

    Widget drooti;
    if (drootiArtboard != null) {
      drooti = SizedBox(
          width: size, height: size, child: Rive(artboard: drootiArtboard!));
    } else {
      drooti = SizedBox(width: size, height: size);
    }

    return drooti;
  }
}


//todo: 
//theres two things first, 
//make the powerup animation start after 6 seconds 
//and then make sure that the animaitons stop, whenever the user changes the screen 
//and restart whenever they come back 


//okay how about i add all the animations 
//and remove all the animations 

//whenever i have the artboard 
//basically i would restart the artboard 
//
//but i would remove all the aniamtions 
//and add the ones i need 
//simple