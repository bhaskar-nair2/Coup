import 'package:auto_route/auto_route_annotations.dart';
import 'package:coup/router/guards.dart';
import 'package:coup/screens/game_screen.dart';
import 'package:coup/screens/home_screen.dart';
import 'package:coup/screens/login.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  LoginScreen loginScreen;
  @GuardedBy([AuthGuard])
  HomeScreen homeScreen;
  @GuardedBy([AuthGuard])
  GameScreen gameScreen;
}
// @MaterialRoute(fullscreenDialog: true)
// CreateInwardsForm inwardForm;
// CreateClientForm clientForm;
