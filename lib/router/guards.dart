import 'package:auto_route/auto_route.dart';
import 'package:coup/firebase/auth.dart';
import 'package:coup/modals/self.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGuard extends RouteGuard {
  AuthService _auth = AuthService();
  @override
  Future<bool> canNavigate(ExtendedNavigatorState navigator, String routeName,
      Object arguments) async {
    SelfPlayer user = await _auth.user;
    print('Guard: $user');
    return user != null;
  }
}
