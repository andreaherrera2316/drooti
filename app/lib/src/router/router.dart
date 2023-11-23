import 'package:app/src/views/screens/game/view/game_view.dart';
import 'package:app/src/views/screens/home/home.dart';
import 'package:app/src/views/screens/pick%20background/view/pick_background.dart';
import 'package:app/src/views/screens/sign%20up%20/view/sign_up.dart';
import 'package:flutter/material.dart';

abstract class INavigation {
  void goToHome();
  void goToPickBackground();
  void goToGame(String background);
  void goToError();
  void goToSignUp();
  void goToLogin();
  void goToSettings();
  void goToRankings();
}

class Routes {
  static const String homeRoute = '/';
  static const String pickBackgroundRoute = '/pick_background';
  static const String gameRoute = '/game';
  static const String errorRoute = '/error';
  static const String signUpRoute = '/sign_up';
  static const String loginRoute = '/login';
  static const String settingsRoute = '/settings';
  static const String rankingsRoute = '/rankings';
}

class AppNavigation implements INavigation {
  final GlobalKey<NavigatorState> navigatorKey;

  AppNavigation(this.navigatorKey);

  @override
  void goToHome() {
    navigatorKey.currentState?.pushNamed(Routes.homeRoute);
  }

  @override
  void goToPickBackground() {
    navigatorKey.currentState?.pushNamed(Routes.pickBackgroundRoute);
  }

  @override
  void goToGame(String background) {
    navigatorKey.currentState?.pushNamed('${Routes.gameRoute}/$background');
  }

  @override
  void goToError() {
    navigatorKey.currentState?.pushNamed(Routes.errorRoute);
  }

  @override
  void goToLogin() {
    navigatorKey.currentState?.pushNamed(Routes.loginRoute);
  }

  @override
  void goToRankings() {
    navigatorKey.currentState?.pushNamed(Routes.rankingsRoute);
  }

  @override
  void goToSettings() {
    navigatorKey.currentState?.pushNamed(Routes.settingsRoute);
  }

  @override
  void goToSignUp() {
    navigatorKey.currentState?.pushNamed(Routes.signUpRoute);
  }
}

class AppRouter {
  static RouteInformationParser<Uri> routeInformationParser =
      _AppRouteInformationParser();
  static RouterDelegate<Uri> routerDelegate = _AppRouterDelegate();
  static AppNavigation? navigationService;

  static void initDependencies(AppNavigation navigationService) {
    AppRouter.navigationService = navigationService;
  }
}

class _AppRouteInformationParser extends RouteInformationParser<Uri> {
  @override
  Future<Uri> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    return uri;
  }

  @override
  RouteInformation restoreRouteInformation(Uri configuration) {
    return RouteInformation(location: configuration.toString());
  }
}

class _AppRouterDelegate extends RouterDelegate<Uri>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Uri>, Routes {
  @override
  late final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  late String _currentPath;
  late String? _background;

  _AppRouterDelegate() {
    _currentPath = Routes.homeRoute;
  }

  String? get background => _background;

  set background(String? value) {
    _background = value;
    notifyListeners();
  }

  @override
  Uri get currentConfiguration {
    return Uri.parse(_currentPath);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _currentPath = Routes.homeRoute;
        notifyListeners();

        return true;
      },
      pages: [
        MaterialPage(
          key: const ValueKey(Routes.homeRoute),
          child: Home(
            navigator: AppRouter.navigationService!,
          ),
        ),
        if (_currentPath == Routes.pickBackgroundRoute)
          MaterialPage(
            key: const ValueKey(Routes.pickBackgroundRoute),
            child: PickBackground(
              navigator: AppRouter.navigationService!,
            ),
          ),
        if (_currentPath.startsWith(Routes.gameRoute))
          MaterialPage(
            key: ValueKey(_currentPath),
            child: GameView(
              backgroundID: _currentPath.split('/').last,
            ),
          ),
        if (_currentPath == Routes.signUpRoute)
          const MaterialPage(
            key: ValueKey(Routes.signUpRoute),
            child: SignUpView(),
          ),

        //todo create and uncomment screens
        // if (_currentPath == Routes.loginRoute)
        //   MaterialPage(
        //     key: ValueKey(Routes.loginRoute),
        //     child: LoginView(),
        //   ),
        // if (_currentPath == Routes.settingsRoute)
        //   MaterialPage(
        //     key: ValueKey(Routes.settingsRoute),
        //     child: SettingsView(),
        //   ),
        // if (_currentPath == Routes.rankingsRoute)
        //   MaterialPage(
        //     key: ValueKey(Routes.rankingsRoute),
        //     child: RankingsView(),
        //   ),
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(Uri configuration) async {
    _currentPath = configuration.path;
  }
}
