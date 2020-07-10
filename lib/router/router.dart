import 'package:auto_route/auto_route_annotations.dart';
import 'package:coup/screens/game_screen.dart';
import 'package:coup/screens/home_screen.dart';
import 'package:coup/screens/login.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  HomeScreen homeScreen;
  GameScreen gameScreen;
  LoginScreen loginScreen;
}
// @MaterialRoute(fullscreenDialog: true)
// CreateInwardsForm inwardForm;
// CreateClientForm clientForm;
