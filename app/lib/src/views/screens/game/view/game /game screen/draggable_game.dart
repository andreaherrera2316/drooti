import 'dart:async';
import 'package:app/src/core/entities/background/background_data.dart';
import 'package:app/src/core/entities/background/igame_background.dart';
import 'package:app/src/core/use%20cases/background/game%20backgrounds/game_backgrounds.dart';
import 'package:app/src/views/screens/game/controller/igame_controller.dart';
import 'package:app/src/views/screens/game/presenter/game_presenter.dart';
import 'package:app/src/views/screens/game/components/drooti/load_drooti_sprite.dart';
import 'package:app/src/views/screens/game/components/drooti/sprites/drooti_sprite.dart';
import 'package:app/src/views/background/background_display.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/game_data_display.dart';
import 'package:app/src/views/screens/game/view%20model/game_view_model.dart';
import 'package:app/src/views/screens/game/controller/view%20model%20notifier/view_model_notifier.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20screen/iflame_game_screen.dart';
import 'package:app/src/views/screens/game/view/game%20/game%20data%20display%20/seasons%20display/season_alerts.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../controller/game_controller.dart';
import '../../igame_view.dart';

class DraggableGame extends IFlameGameScreen
    with HasDraggables, HasCollisionDetection, SeasonAlerts
    implements IGameView {
  DraggableGame(
      {required this.background, this.travelBgIn = const Duration(seconds: 5)})
      : viewModel = GameViewModel(),
        scrollController = ScrollController(),
        selectedBackground = background.wildcard {
    _viewModelNotifier = ViewModelNotifier(viewModel: viewModel);
    _controller = GameController(
        travelBgIn: travelBgIn,
        scrollController: scrollController,
        myGame: this,
        presenter: GamePresenter(view: this),
        gameHeight: 0,
        gameWidth: 0,
        drootiHeight: _drootiSize,
        drootiWidth: _drootiSize,
        drootiX: 0,
        drootiY: 0);

    _controller.loadBackground(background);
  }

  @override
  GameViewModel viewModel;
  DrootiSprite? drootiSprite;
  IGameBackground background;
  BackgroundData selectedBackground;
  GameDataDisplay? _displayData;
  ScrollController scrollController;
  Duration travelBgIn;
  late IGameController _controller;
  late ViewModelNotifier _viewModelNotifier;
  final double _drootiSize = 200;
  double? startX;
  double? startY;
  bool _overheating = false;
  bool _freezing = false;

  Widget getGameWidget() {
    _displayData = GameDataDisplay(
      viewModel: viewModel,
      notifier: _viewModelNotifier,
      seasonAlertNotifier: this,
    );
    return Scaffold(
      body: GameWidget(
        game: this,
        backgroundBuilder: (context) => BackgroundDisplay(
          backgroundVariant: selectedBackground,
          bgColor: Colors.indigoAccent[400]!,
          scrollController: scrollController,
        ),
        overlayBuilderMap: {
          "game data display": (BuildContext context, DraggableGame game) {
            return _displayData!;
          },
          // "background": (BuildContext context, DraggableGame game) {

          // }
        },
      ),
    );
  }

  //okayso the sprites are not going down
  //what did i change
  //that messed this up
  //or is there another displayer

  //okay i am going to have to hunt down the notifiers
  //that i simply extended
  //and modify their add method

  //todo:
  //we need the notifier for the presenter to recieve updates
  //form the background manager
  //okay i am thinking i can split the game
  //into an object called game manager
  //that will intialize all the managers
  //and i will have access to the managers through that object
  //and it will also handle the subscriptions
  //is will have methods like subscribeToBackgroundVariant()
  //and it will subscribe you to updates
  //one of the managers will be emitting those updates
  //and the presenter will recieve them
  //and call a method on the view
  //that will affect the UI

  //We need to make this clean up
  //finish implementing the notifier
  //and then get started
  //with making that big game manager
  //that will handle the creation and initialization for the game
  //and will manage the subscriptions
  //and we simply need the controller to have one of those
  //jaja that is very clever
  //and it will make the game easy to manage
  //that code
  //i will be proud to show
  //i feel overall this project is very well written
  //yes we need test and so on
  //and there's bugs we need to fix and other we might know nothing about
  //but i will get there
  //"if you give me code i can change that doesn't work
  // I can make it work "
  //So we will keep improving the code
  //And I will maintain it

  ////Todo:

  //i will add alog in and log out
  //and we are done
  //we are uploading
  //tests can come later
  //and i will add in that we still have tests to do
  //and stuff
  //then we are done
  //drooti has been uploaded
  //scraps to go
  //and once i do it i will build an interface
  //for the usage and stuff
  //it will be fun
  //and then gallery js
  //2 days from now
  //i will be done with all of these
  //i will continue with my courses
  //and focus on interview prep and ai for my startup

  //this is an exciting day
  //it definitely is

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    debugMode = true;
    _loadDrootiStart();
    _addDrootiSprite();
    _updateControllerData();
    _loadBackground();
    overlays.add("game data display");
  }

  @override
  void onDragStart(int pointerId, DragStartInfo info) {
    bool gameHasNotStarted = !viewModel.gameStarted;
    if (gameHasNotStarted) {
      _startGame();
    }
    super.onDragStart(pointerId, info);
  }

  @override
  void updateGameData() {
    _viewModelNotifier.setViewModel = viewModel;
  }

  @override
  void droneBatteryDied() {
    drootiSprite!.breakDown();
  }

  @override
  void droneMotorBroke() {
    drootiSprite!.breakDown();
  }

  @override
  void droneOutOfPower() {
    drootiSprite!.breakDown();
  }

  @override
  void explodeDrone() {
    drootiSprite!.explode();
  }

  @override
  void freezeDrone() {
    drootiSprite!.freeze();
  }

  @override
  void quantumSpeed() {
    drootiSprite!.quantumSpeed();
  }

  @override
  void droneOverheating() {
    _overheating = true;
  }

  @override
  void droneStopedOverheating() {
    _overheating = false;
  }

  @override
  void droneFreezing() {
    _freezing = true;
  }

  @override
  void droneStoppedFreezing() {
    _freezing = false;
  }

  ///Game State

  _startGame() {
    _controller.start();
    drootiSprite!.takeOff();
  }

  _endGame() {
    _controller.end();
  }

  void _loadDrootiStart() {
    startX = size.x / 2;
    startY = size.y * 0.95;
  }

  //Loading
  void _addDrootiSprite() async {
    await _loadDrootiSprite();
    _positionDrooti();
    add(drootiSprite!);
  }

  void _positionDrooti() {
    drootiSprite!.anchor = Anchor.bottomCenter;
    drootiSprite!.position = Vector2(startX!, startY!);
  }

  Future<void> _loadDrootiSprite() async {
    try {
      drootiSprite = await LoadDrootiSprite().getDraggableDrooti(
          _drootiSize, _controller.movedDrooti, _controller.resizeGame);
    } catch (e) {
      //TODO: display error screen
    }
    return;
  }

  void _updateControllerData() {
    _controller.resizeGame(size.y, size.x);
    _controller.setDrootiStartPoint(startX!, startY!);
  }

  void _loadBackground() {
    _controller.loadBackground(background);
  }

  @override
  void updateBgVariant(String variant, int color) {
    // TODO: implement updateBgVariant
  }
}
