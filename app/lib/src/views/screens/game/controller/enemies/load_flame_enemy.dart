import 'package:app/helper/value_based_on_screen.dart';
import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/components/load_rive_artboard.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/hair%20dryer/hair_dryer.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/punch/punch.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/extending/yoyo/yoyo.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/top%20to%20bottom/pinata/pinata.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/side%20to%20side/baseball/baseball.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/side%20to%20side/firework/firework.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/side%20to%20side/snowball/snowball.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/swinging/electric%20guitar/electric_guitar.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/swinging/saw/saw.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/swinging/umbrella/umbrella.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/top%20to%20bottom/log/log.dart';
import 'package:app/src/views/screens/game/controller/enemies/enemy%20catalogue/top%20to%20bottom/piano/piano.dart';
import 'package:app/src/views/screens/game/controller/enemies/iflame_enemy.dart';
import 'package:flame/game.dart';

import 'enemy catalogue/side to side/beachball/beachball.dart';
import 'enemy catalogue/side to side/chancla/chancla.dart';

class LoadFlameEnemy {
  static final _instance = LoadFlameEnemy._create();

  factory LoadFlameEnemy() {
    return _instance;
  }

  LoadFlameEnemy._create();
  //todo:
  //okay we can create an object, through which we will access all of the artboard it will be singleton
  //And it's going to prevent us from loading the rive file more than once
  //we can do a class LoadGameAssets

//todo: we need generators that will adapt to screen type
//that's it
//and we need top to bottom enemies for summer and winter
//we need tyo resize drooti as well based on this

  Future<IFlameEnemy> snowball(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Snowball",
      )!;
      var size = _adjustSizeToScreen(
          myGame.size.y * 0.06, myGame.size.x, myGame.size.y);

      return Snowball(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getSideToSideSpeed(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> baseball(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Baseball",
      )!;

      var size = _adjustSizeToScreen(
          myGame.size.y * 0.06, myGame.size.x, myGame.size.y);

      return Baseball(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getSideToSideSpeed(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> chancla(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Chancla",
      )!;

      var height = _adjustSizeToScreen(
          myGame.size.y * 0.105, myGame.size.x, myGame.size.y);

      return Chancla(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: height,
        width: height / 2,
        topToBottom: topToBottom,
        pixelsPerMilli: _getSideToSideSpeed(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> redBeachball(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Red Beachball",
      )!;

      var size = _beachballSize(myGame.size.x, myGame.size.y);

      return Beachball(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getSideToSideSpeed(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> greenBeachball(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Green Beachball",
      )!;
      var size = _beachballSize(myGame.size.x, myGame.size.y);

      return Beachball(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getSideToSideSpeed(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> purpleBeachball(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Purple Beachball",
      )!;
      var size = _beachballSize(myGame.size.x, myGame.size.y);

      return Beachball(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getSideToSideSpeed(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> log(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Log",
      )!;
      var size = _adjustSizeToScreen(
          myGame.size.y * 0.12, myGame.size.x, myGame.size.y);

      return Log(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getTopToBottomSpeed(myGame.size.y),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> pinata(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Pinata",
      )!;
      var size = _adjustSizeToScreen(
          myGame.size.y * 0.16, myGame.size.x, myGame.size.y);

      return Pinata(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getTopToBottomSpeed(myGame.size.y),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> piano(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Piano",
      )!;
      var size = _adjustSizeToScreen(
          myGame.size.y * 0.19, myGame.size.x, myGame.size.y);

      return Piano(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getTopToBottomSpeed(myGame.size.y),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> redFirework(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Red Firework",
      )!;

      var size = _fireworkSize(myGame.size.x, myGame.size.y);

      return Firework(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getSideToSideSpeed(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> blueFirework(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Blue Firework",
      )!;

      var size = _fireworkSize(myGame.size.x, myGame.size.y);

      return Firework(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getSideToSideSpeed(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> yellowFirework(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Yellow Firework",
      )!;

      var size = _fireworkSize(myGame.size.x, myGame.size.y);

      return Firework(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getSideToSideSpeed(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> greenFirework(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Green Firework",
      )!;

      var size = _fireworkSize(myGame.size.x, myGame.size.y);
      return Firework(
        game: myGame,
        artboard: artboard,
        actions: actions,
        height: size,
        width: size,
        topToBottom: topToBottom,
        pixelsPerMilli: _getSideToSideSpeed(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> electricGuitar(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Electric Guitar",
      )!;

      var height = _swinginEnemySize(myGame.size.x);

      return ElectricGuitar(
        game: myGame,
        artboard: artboard,
        actions: actions,
        width: height / 3,
        height: height,
        topToBottom: topToBottom,
        pixelsPerMilli: _getStationarySpeed(myGame.size.y),
        swingDegrees: _enemySwingDegrees(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> saw(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Saw",
      )!;
      var height = _swinginEnemySize(myGame.size.x);

      return Saw(
        game: myGame,
        artboard: artboard,
        actions: actions,
        width: height / 3,
        height: height,
        topToBottom: topToBottom,
        pixelsPerMilli: _getStationarySpeed(myGame.size.y),
        swingDegrees: _enemySwingDegrees(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> umbrella(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Umbrella",
      )!;
      var height = _swinginEnemySize(myGame.size.x);
      return Umbrella(
        game: myGame,
        artboard: artboard,
        actions: actions,
        width: height / 3,
        height: height,
        topToBottom: topToBottom,
        pixelsPerMilli: _getStationarySpeed(myGame.size.y),
        swingDegrees: _enemySwingDegrees(myGame.size.x),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> punch(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Punch",
      )!;

      var width = _extendingEnemySize(myGame.size.x);
      return Punch(
        game: myGame,
        artboard: artboard,
        actions: actions,
        width: width,
        height: width / 3,
        topToBottom: topToBottom,
        pixelsPerMilli: _getStationarySpeed(myGame.size.y),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> hairDryer(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Hair Dryer",
      )!;
      var width = _extendingEnemySize(myGame.size.x);
      return HairDryer(
        game: myGame,
        artboard: artboard,
        actions: actions,
        width: width,
        height: width * 0.45,
        topToBottom: topToBottom,
        pixelsPerMilli: _getStationarySpeed(myGame.size.y),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<IFlameEnemy> yoyo(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Yoyo",
      )!;

      var width = _extendingEnemySize(myGame.size.x);

      return Yoyo(
        game: myGame,
        artboard: artboard,
        actions: actions,
        width: width,
        height: width / 3,
        topToBottom: topToBottom,
        pixelsPerMilli: _getStationarySpeed(myGame.size.y),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  double _getSideToSideSpeed(double screenWidth) {
    return ValueBasedOnScreen().getValueOnWidth(
      mobile: 10,
      tablet: 14,
      desktop: 18,
      screenWidth: screenWidth,
    );
  }

  double _getTopToBottomSpeed(double screenHeight) {
    return ValueBasedOnScreen().getValueOnHeight(
      shortScreen: 10,
      mediumScreen: 12,
      longScreen: 13,
      screenHeight: screenHeight,
    );
  }

  double _getStationarySpeed(double screenHeight) {
    return ValueBasedOnScreen().getValueOnHeight(
      shortScreen: 2,
      mediumScreen: 3,
      longScreen: 4,
      screenHeight: screenHeight,
    );
  }

  double _swinginEnemySize(double screenWidth) {
    return ValueBasedOnScreen().getValueOnWidth(
      mobile: screenWidth * 0.4,
      tablet: screenWidth * 0.35,
      desktop: screenWidth * 0.25,
      screenWidth: screenWidth,
    );
  }

  double _extendingEnemySize(double screenWidth) {
    return ValueBasedOnScreen().getValueOnWidth(
      mobile: screenWidth * 0.53,
      tablet: screenWidth * 0.5,
      desktop: screenWidth * 0.3,
      screenWidth: screenWidth,
    );
  }

  double _enemySwingDegrees(double screenWidth) {
    return ValueBasedOnScreen().getValueOnWidth(
      mobile: 80,
      tablet: 60,
      desktop: 45,
      screenWidth: screenWidth,
    );
  }

  double _fireworkSize(double screenWidth, double screenHeight) {
    var size = screenHeight * 0.13;
    return _adjustSizeToScreen(size, screenWidth, screenHeight);
  }

  double _beachballSize(double screenWidth, double screenHeight) {
    var size = screenHeight * 0.12;
    return _adjustSizeToScreen(size, screenWidth, screenHeight);
  }

  double _adjustSizeToScreen(
      double mobileSize, double screenWidth, double screenHeight) {
    return ValueBasedOnScreen().getValueOnWidth(
        mobile: mobileSize,
        tablet: mobileSize * 1.35,
        desktop: mobileSize * 1.6,
        screenWidth: screenWidth);
  }
}
