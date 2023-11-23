import 'package:app/src/router/router.dart';
import 'package:app/src/views/screens/sign%20up%20/view/sign_up.dart';
import 'package:app/src/views/state/error/error_screen.dart';
import 'package:app/src/views/state/loading/loading_game.dart';
import 'package:flutter/material.dart';
import 'package:app/src/views/screens/pick%20background/view/pick_background.dart';

import 'package:app/src/views/screens/game/view/game_view.dart';
import 'package:app/src/views/screens/home/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final AppNavigation navigationService;

  const MyApp(
      {super.key, required this.navigatorKey, required this.navigationService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/load_game',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      onGenerateRoute: (settings) {
        if (settings.name == Routes.homeRoute) {
          return MaterialPageRoute(
            builder: (context) => Home(navigator: navigationService),
          );
        } else if (settings.name == Routes.pickBackgroundRoute) {
          return MaterialPageRoute(
            builder: (context) => PickBackground(navigator: navigationService),
          );
        } else if (settings.name!.startsWith(Routes.gameRoute)) {
          final background = settings.name!.substring('/game/'.length);
          return MaterialPageRoute(
            builder: (context) => GameView(backgroundID: background),
          );
        } else if (settings.name == Routes.errorRoute) {
          return MaterialPageRoute(
            builder: (context) => const ErrorScreen(),
          );
        } else if (settings.name == '/load_game') {
          return MaterialPageRoute(
            builder: (context) => const LoadingGame(),
          );
        } else if (settings.name == Routes.signUpRoute) {
          return MaterialPageRoute(
            builder: (context) => const SignUpView(),
          );
        } else if (settings.name == Routes.loginRoute) {
          return MaterialPageRoute(
            builder: (context) => const LoadingGame(),
          );
        } else if (settings.name == Routes.settingsRoute) {
          return MaterialPageRoute(
            builder: (context) => const LoadingGame(),
          );
        } else if (settings.name == Routes.rankingsRoute) {
          return MaterialPageRoute(
            builder: (context) => const LoadingGame(),
          );
        }

        return null;
      },
    );
  }
}
