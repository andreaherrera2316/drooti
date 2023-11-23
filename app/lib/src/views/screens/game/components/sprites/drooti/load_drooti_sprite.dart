import 'package:app/src/views/screens/game/components/sprites/drooti/sprites/draggable_drooti_sprite.dart';
import 'package:app/src/views/screens/game/components/sprites/drooti/sprites/drooti_sprite.dart';
import 'package:flame_rive/flame_rive.dart';

class LoadDrootiSprite {
  Future<DraggableDrootiSprite> getDraggableDrooti(
      double drootiSize,
      void Function(double x, double y) onDrootiMoved,
      void Function(double screenHeightInPixels, double screenWidthInPixels,
              [double drootiX, double drootiY, bool positionsAreBottomToTop])
          onResizeGame) async {
    Artboard? drootiArtboard;
    try {
      drootiArtboard = await _loadDrootiAsset();
    } catch (e) {
      return Future.error(e);
    }

    return DraggableDrootiSprite(
      drootiSize: 200,
      drootiArtboard: drootiArtboard,
      onDrootiMoved: onDrootiMoved,
      onResizeGame: onResizeGame,
    );
  }

  Future<DrootiSprite> drootiSprite(double drootiSize) async {
    Artboard? drootiArtboard;
    try {
      drootiArtboard = await _loadDrootiAsset();
    } catch (e) {
      return Future.error(e);
    }

    return DrootiSprite(
      drootiSize: 200,
      drootiArtboard: drootiArtboard,
    );
  }

  Future<Artboard> _loadDrootiAsset() async {
    try {
      return loadArtboard(RiveFile.asset('assets/rive/drooti.riv'),
          artboardName: "Drooti");
    } catch (e) {
      return Future.error(e);
    }
  }
}

class ErrorLoadingArtboard extends Error {
  @override
  String toString() {
    return "An error occured while trying to load Drooti's artboard";
  }
}
