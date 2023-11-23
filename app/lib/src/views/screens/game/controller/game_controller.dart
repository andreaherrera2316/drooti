import 'dart:async';
import 'package:app/src/core/entities/background/igame_background.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/background%20manager/ibackground_manager.dart';
import 'package:app/src/core/entities/drone/drone%20data/battery_data.dart';
import 'package:app/src/core/entities/drone/drone%20data/drone_data.dart';
import 'package:app/src/core/entities/drone/drone%20data/drone_system_data.dart';
import 'package:app/src/core/entities/drone/drone%20data/motor_data.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/background%20manager/background_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/background%20manager/variant/background_variant_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/difficulty%20manager/difficulty_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20actions/idrone_actions_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone%20vitals%20notifier/idrone_vitals_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone%20vitals/drone_vitals_notifier.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/drone%20manager/drone_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/meters%20manager/meter%20limits%20manager/meter_limits_manager.dart';
import 'package:app/src/core/use%20cases/sprites/power%20ups/power%20up%20manager/ipower_up_manager.dart';
import 'package:app/src/core/use%20cases/sprites/power%20ups/power%20up%20manager/power_up_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/movement%20manager/movement_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/seasons%20manager/seasons_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/weather%20manager/weather_manager.dart';
import 'package:app/src/core/use%20cases/game/game%20managers/manager%20coordinator/game_manager_coordinator.dart';
import 'package:app/src/core/use%20cases/sprites/enemy/enemy%20manager/seasonal%20enemy%20managers/seasonal_enemy_manager.dart';
import 'package:app/src/views/screens/game/controller/igame_controller.dart';
import 'package:app/src/views/screens/game/controller/drone%20updates/process_drone_events.dart';
import 'package:app/src/views/screens/game/controller/drone%20data%20updates/process_drone_updates.dart';
import 'package:app/src/views/screens/game/controller/meters%20updates/process_meters_updates.dart';
import 'package:app/src/views/screens/game/controller/season%20updates/process_season_updates.dart';
import 'package:app/src/views/screens/game/controller/weather%20updates/process_weather_updates.dart';
import 'package:app/src/views/screens/game/presenter/igame_presenter.dart';
import 'package:app/src/views/background/background_scroller.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game size notifier/game_size_and_direction_subscriber.dart';
import 'game size notifier/game_size_and_position_subscriber.dart';
import 'game size notifier/game_size_notifier.dart';
import 'game size notifier/game_size_subscriber.dart';

class GameController
    with GameManagerCoordinator
    implements IGameController, GameSizeNotifier {
  GameController({
    required this.myGame,
    required this.presenter,
    required double gameHeight,
    required double gameWidth,
    required double drootiHeight,
    required double drootiWidth,
    required double drootiX,
    required double drootiY,
    required this.scrollController,
    required this.travelBgIn,
    int gameTempInDegreesF = 80,
  })  : processDrone = ProcessDroneEvents(presenter: presenter),
        processMeters = ProcessMetersUpdates(presenter: presenter),
        processSeasons = ProcessSeasonUpdates(presenter: presenter),
        processWeather = ProcessWeatherUpdates(presenter: presenter),
        difficultyManager = DifficultyManager(),
        weatherManager = WeatherManager(gameTempInDegreesF),
        metersManager = MainMetersManager(
          drootiMetersPerS: 0,
          drootiX: drootiX,
          drootiY: drootiY,
          gameHeight: gameHeight,
          gameWidth: gameWidth,
          drootiHeight: drootiHeight,
          //drootiWidth: drootiWidth,
        ),
        displayer = MovementManager() {
    metersManager.limitsNotifier.addLimitsSub(displayer);

    processGame =
        ProcessDroneUpdates(presenter: presenter, metersManager: metersManager);

    seasonsManager = GameSeasonsManager(
        temperature: weatherManager.temperature,
        seasonDuration: const Duration(seconds: 15));

    addAllManagers(
        [difficultyManager, metersManager, seasonsManager!, presenter]);
    _load(gameTempInDegreesF);
  }

  @override
  List<GameSizeSubscriber> sizeSubs = [];
  double _droneSpeed = 0;
  FlameGame myGame;
  IGamePresenter presenter;
  MainMetersManager metersManager; //?
  WeatherManager weatherManager; //?
  DifficultyManager difficultyManager; //?
  GameSeasonsManager? seasonsManager; //?
  IDroneActionsManager? droneManager; //?
  SeasonalEnemyManager? enemyManager; //?
  IPowerUpManager? powerUpManager; //?
  MovementManager displayer; //? #
  IBackgroundManager? backgroundManager; //?

  ProcessDroneUpdates? processGame;
  ProcessDroneEvents processDrone;
  ProcessMetersUpdates processMeters;
  ProcessSeasonUpdates processSeasons;
  ProcessWeatherUpdates processWeather;

  IDroneVitalsNotifier? droneNotifier;
  ScrollController scrollController;
  Duration travelBgIn;

  @override
  void loadBackground(IGameBackground background) {
    var bgScroller = BackgroundScroller(scrollController);
    var variantManager = BackgroundVariantManager(background);

    backgroundManager = BackgroundManager(
        variantManager: variantManager,
        scroller: bgScroller,
        travelBgIn: travelBgIn);

    updateBgVariant();

    addManager(backgroundManager!);
  }

  @override
  void adjustWeather(int amount) {
    weatherManager.adjustTemperature(amount);
  }

  @override
  void damageBattery([double percent = 1]) {
    droneManager!.damageBattery(percent);
  }

  @override
  void repairBattery([double percent = 1]) {
    droneManager!.repairBattery(percent);
  }

  @override
  void damageMotor([double percent = 1]) {
    droneManager!.damageMotor(percent);
  }

  @override
  void repairMotor([double percent = 1]) {
    droneManager!.repairMotor(percent);
  }

  @override
  void increaseChargeByPercent(double percent) {
    droneManager!.increaseChargeByPercent(percent);
  }

  @override
  void resizeDrooti(double? height, double? width) {
    metersManager.onDrootiResize(height, width);
  }

  @override
  void movedDrooti(double x, double y) {
    metersManager.onDrootiMoved(x, y);
  }

  @override
  void setDrootiStartPoint(double x, double y) {
    metersManager.setDrootiStartPoint(x, y);
  }

  @override
  void addSizeSub(GameSizeSubscriber sub) {
    sizeSubs.add(sub);
  }

  @override
  void removeSizeSub(GameSizeSubscriber sub) {
    sizeSubs.remove(sub);
  }

  @override
  void resizeGame(double screenHeightInPixels, double screenWidthInPixels,
      [double? drootiX, double? drootiY, bool positionsAreBottomToTop = true]) {
    notifyResize(screenHeightInPixels, screenWidthInPixels, drootiX, drootiY,
        positionsAreBottomToTop);
  }

  @override
  void notifyResize(double screenHeightInPixels, double screenWidthInPixels,
      [double? drootiX, double? drootiY, bool positionsAreBottomToTop = true]) {
    for (var sub in sizeSubs) {
      if (sub is GameSizeAndDirectionSubscriber) {
        sub.onGameResize(
            screenHeightInPixels, screenWidthInPixels, positionsAreBottomToTop);
      } else if (sub is GameSizeAndPositonSubscriber) {
        sub.onGameResize(screenHeightInPixels, screenWidthInPixels,
            positionsAreBottomToTop, drootiX, drootiY);
      } else {
        sub.onGameResize(
          screenHeightInPixels,
          screenWidthInPixels,
        );
      }
    }
  }

  Future<DroneData> _getDroneData() async {
    return DroneData(
        batteryData: BatteryData(maxTemp: 122, minTemp: 39, amps: 1200),
        motorData: MotorData(maxSpeedMetersPerSec: 16, consumptionPerSec: 10),
        systemData: DroneSystemData(consumptionPerSec: 5));
  }

  void _load(int gameTempInDegreesF) async {
    try {
      var droneData = await _getDroneData();
      _droneSpeed = droneData.maxSpeedMetersPerSec;
      _setUpSeasons();
      _setUpWeather();
      _setUpMeters(_droneSpeed);
      _setUpDroneDataManager(droneData, gameTempInDegreesF);
      _setupEnemyManager();
      _setUpPowerUpManager();
    } catch (e) {
      presenter.displayErrorScreen();
    }
  }

  void _setUpSeasons() {
    seasonsManager!.addSeasonSub(processSeasons);
  }

  void _setUpWeather() {
    weatherManager.addWeatherSub(processWeather);
  }

  void _setUpMeters(double maxSpeed) {
    metersManager.drootiMetersPerS = maxSpeed;
    metersManager.droneMetersNotifier.addMetersSub(processMeters);

    addSizeSub(metersManager);
  }

  void _setUpDroneDataManager(DroneData droneData, int gameTempInDegreesF) {
    var notifier = DroneVitalsNotifier();
    droneNotifier = notifier;
    weatherManager.addWeatherSub(notifier);
    droneManager = DroneManager(
      droneData: droneData,
      gameTempInDegreesF: gameTempInDegreesF,
      weatherNotifier: weatherManager,
      notifier: droneNotifier,
      sendUpdates: processDrone,
    );
    droneNotifier?.addVitalsSub(processGame!);
    addManager(droneManager!);
  }

  void _setupEnemyManager() {
    enemyManager = SeasonalEnemyManager(
      gameActions: this,
      game: myGame,
      limitsNotifier: metersManager.limitsNotifier,
      seasonsNotifier: seasonsManager!,
      displayer: displayer,
    );
    addManager(enemyManager!);
  }

  void _setUpPowerUpManager() {
    powerUpManager = PowerUpManager(
      gameActions: this,
      game: myGame,
      limitsNotifier: metersManager.limitsNotifier,
      displayer: displayer,
      vitalsNotifier: droneNotifier!,
    );
    addManager(powerUpManager!);
  }

  void updateBgVariant() {
    int color = backgroundManager!.backgroundColor;

    String variant = backgroundManager!.backgroundVariant;
    presenter.updateBgVariant(variant, color);
  }
}
