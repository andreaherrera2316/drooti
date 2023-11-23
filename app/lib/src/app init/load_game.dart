import 'dart:async';

import 'package:app/src/app%20init/iload_game.dart';
import 'package:app/src/views/screens/game/components/load_rive_artboard.dart';

class LoadGame extends ILoadGame {
  LoadGame({
    required super.onError,
    required super.onSuccess,
    this.retryEvery = const Duration(seconds: 10),
  });

  final Duration retryEvery;

  @override
  Future<void> loadGame() async {
    await _loadRiveAssets();
  }

  Future<void> _loadRiveAssets() async {
    var loadRiveArtboard = LoadRiveArtboard();
    int triesLeft = maxRetries;
    try {
      await loadRiveArtboard.loadFile();
    } catch (e) {
      Timer.periodic(retryEvery, (timer) async {
        if (loadRiveArtboard.fileLoaded) {
          timer.cancel();
          return;
        } else if (triesLeft <= 0) {
          onError();
          timer.cancel();
          return;
        }
        await loadRiveArtboard.loadFile();
        triesLeft--;
      });
    }
  }
}
