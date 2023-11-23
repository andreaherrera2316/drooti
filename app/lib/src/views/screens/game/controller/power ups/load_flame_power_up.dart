import 'package:app/helper/value_based_on_screen.dart';
import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/views/screens/game/components/load_rive_artboard.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/iflame_power_up.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/power%20up%20catalogue/atom/atom.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/power%20up%20catalogue/gear/gear.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/power%20up%20catalogue/lightning/lightning.dart';
import 'package:app/src/views/screens/game/controller/power%20ups/power%20up%20catalogue/sun/sun.dart';
import 'package:flame/game.dart';

class LoadFlamePowerUp {
  static final _instance = LoadFlamePowerUp._create();

  factory LoadFlamePowerUp() {
    return _instance;
  }

  LoadFlamePowerUp._create();

  Future<IFlamePowerUp> sun(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Sun",
      )!;
      var size = _getPowerUpSize(myGame.size.x, myGame.size.y);

      return Sun(
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

  Future<IFlamePowerUp> lightning(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Lightning",
      )!;
      var size = _getPowerUpSize(myGame.size.x, myGame.size.y);

      return Lightning(
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

  Future<IFlamePowerUp> gear(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Gear",
      )!;
      var size = _getPowerUpSize(myGame.size.x, myGame.size.y);

      return Gear(
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

  Future<IFlamePowerUp> atom(
      bool topToBottom, IGameActions actions, FlameGame myGame) async {
    try {
      var artboard = LoadRiveArtboard().getArtboard(
        "Atom",
      )!;
      var size = _getPowerUpSize(myGame.size.x, myGame.size.y);

      return Atom(
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

  double _adjustSizeToScreen(
      double mobileSize, double screenWidth, double screenHeight) {
    return ValueBasedOnScreen().getValueOnWidth(
        mobile: mobileSize,
        tablet: mobileSize * 1.35,
        desktop: mobileSize * 1.6,
        screenWidth: screenWidth);
  }

  double _getPowerUpSize(double screenWidth, double screenHeight) {
    return _adjustSizeToScreen(screenHeight * 0.07, screenWidth, screenHeight);
  }

  double _getTopToBottomSpeed(double screenHeight) {
    return ValueBasedOnScreen().getValueOnHeight(
      shortScreen: 2,
      mediumScreen: 3.5,
      longScreen: 5,
      screenHeight: screenHeight,
    );
  }
}
