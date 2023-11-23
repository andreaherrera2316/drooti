import 'package:app/src/core/use%20cases/game/game%20actions/igame_actions.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20notifier/idrone_main_vitals_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter%20limits%20notifier/imeter_limits_notifier.dart';
import 'package:app/src/core/use%20cases/sprites/isprite_displayer.dart';
import 'package:app/src/core/use%20cases/sprites/power%20ups/factory/power_up_factory.dart';
import 'package:app/src/core/use%20cases/sprites/power%20ups/generator/ipower_up_generator.dart';
import 'package:app/src/core/use%20cases/sprites/power%20ups/generator/power_up_generator.dart';
import 'package:app/src/core/use%20cases/sprites/power%20ups/power%20up%20manager/ipower_up_manager.dart';
import 'package:flame/game.dart';

class PowerUpManager implements IPowerUpManager {
  PowerUpManager({
    required IGameActions gameActions,
    required FlameGame game,
    required this.limitsNotifier,
    required IDroneMainVitalsNotifier vitalsNotifier,
    ISpriteDisplayer? displayer,
  }) {
    _setUpGenerators(gameActions, game, displayer, vitalsNotifier);
  }
  IMeterLimitsNotifier limitsNotifier;
  List<IPowerUpGenerator> generators = [];

  @override
  void start() {
    _startGenerators();
  }

  @override
  void end() {
    _pauseGenerators();
  }

  @override
  void pause() {
    _pauseGenerators();
  }

  @override
  void resume() {
    _startGenerators();
  }

  @override
  void restart() {
    for (var generator in generators) {
      generator.reset();
    }
  }

  _startGenerators() {
    for (var generator in generators) {
      generator.start();
    }
  }

  _pauseGenerators() {
    for (var generator in generators) {
      generator.pause();
    }
  }

  void _setUpGenerators(IGameActions gameActions, FlameGame game,
      ISpriteDisplayer? displayer, IDroneMainVitalsNotifier vitalsNotifier) {
    var factory = PowerUpFactory(gameActions: gameActions, game: game);
    vitalsNotifier.addMainVitalsSub(factory);

    var gens = [
      PowerUpGenerator(
        powerUps: factory,
        displayer: displayer,
        genPowerUpsEvery: 50,
      ),
      PowerUpGenerator(
        powerUps: factory,
        displayer: displayer,
        genPowerUpsEvery: 120,
      )
    ];

    for (var generator in gens) {
      limitsNotifier.addLimitsSub(generator);
    }

    generators = gens;
  }
}


//the season alerts
//the screen effects 
//the drone animations 
//test it and we go for backgrounds 
//then we are pretty much done 
//then just create the score screen and replay 
//and you are done with this 
//hook up the screens together 
//and done 

//maybe give the power ups a little shade 
//in rive 
//so that players know they need to grab those 
//they are good 
//do that when you add the enemies for summer and winter 


