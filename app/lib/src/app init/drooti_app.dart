import 'dart:async';

import 'package:app/src/app%20init/load_game.dart';
import 'package:app/src/app%20init/myapp.dart';
import 'package:app/src/router/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app/src/app%20init/iapp.dart';
import 'package:app/firebase_options.dart';

class DrootiApp implements IApp {
  DrootiApp() : navigationService = AppNavigation(navigatorKey) {
    initializeApp();
    loadAssets();
  }

  static final navigatorKey = GlobalKey<NavigatorState>();
  AppNavigation navigationService;

  @override
  void initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    AppRouter.initDependencies(navigationService);
    runApp(MyApp(
        navigatorKey: navigatorKey, navigationService: navigationService));
  }

  @override
  void goToGame() {
    navigationService.goToHome();
  }

  @override
  Future<void> loadAssets() async {
    var load = LoadGame(onError: onError, onSuccess: goToGame);
    await load.loadGame();

    Timer(const Duration(milliseconds: 100), () {
      goToGame();
    });
  }

  @override
  void onError() {
    navigationService.goToError();
  }
}
