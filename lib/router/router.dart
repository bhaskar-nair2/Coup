import 'package:auto_route/auto_route_annotations.dart';
import 'package:coup/screens/game_screen.dart';
import 'package:coup/screens/login.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  LoginScreen loginScreen;
  GameScreen gameScreen;
}
// @MaterialRoute(fullscreenDialog: true)
// CreateInwardsForm inwardForm;
// CreateClientForm clientForm;
