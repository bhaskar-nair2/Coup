// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:coup/screens/login.dart';
import 'package:coup/screens/game_screen.dart';
import 'package:coup/router/guards.dart';

abstract class Routes {
  static const loginScreen = '/';
  static const gameScreen = '/game-screen';
  static const all = {
    loginScreen,
    gameScreen,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;
  @override
  Map<String, List<Type>> get guardedRoutes => {
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

//GameScreen arguments holder class
class GameScreenArguments {
  final Key key;
  GameScreenArguments({this.key});
}
