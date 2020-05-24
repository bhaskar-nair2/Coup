import 'package:auto_route/auto_route.dart';
import 'package:coup/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(ExtendedNavigatorState navigator, String routeName,
      Object arguments) async {
    FirebaseUser user = await AuthService().getUser;
    return user != null;
  }
}
