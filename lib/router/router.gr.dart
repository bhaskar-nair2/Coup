// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:coup/screens/login.dart';
import 'package:coup/screens/home_screen.dart';
import 'package:coup/router/guards.dart';
import 'package:coup/screens/game_screen.dart';

abstract class Routes {
  static const loginScreen = '/';
  static const homeScreen = '/home-screen';
  static const gameScreen = '/game-screen';
  static const all = {
    loginScreen,
    homeScreen,
    gameScreen,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;
  @override
  Map<String, List<Type>> get guardedRoutes => {
        Routes.homeScreen: [AuthGuard],
        Routes.gameScreen: [AuthGuard],
      };
  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginScreen(),
          settings: settings,
        );
      case Routes.homeScreen:
        if (hasInvalidArgs<HomeScreenArguments>(args)) {
          return misTypedArgsRoute<HomeScreenArguments>(args);
        }
        final typedArgs = args as HomeScreenArguments ?? HomeScreenArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeScreen(key: typedArgs.key),
          settings: settings,
        );
      case Routes.gameScreen:
        if (hasInvalidArgs<GameScreenArguments>(args)) {
          return misTypedArgsRoute<GameScreenArguments>(args);
        }
        final typedArgs = args as GameScreenArguments ?? GameScreenArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => GameScreen(key: typedArgs.key),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//HomeScreen arguments holder class
class HomeScreenArguments {
  final Key key;
  HomeScreenArguments({this.key});
}

//GameScreen arguments holder class
class GameScreenArguments {
  final Key key;
  GameScreenArguments({this.key});
}
