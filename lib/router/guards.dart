import 'package:auto_route/auto_route.dart';
import 'package:coup/repos/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGuard extends RouteGuard {
  AuthService _auth = AuthService();
  @override
  Future<bool> canNavigate(ExtendedNavigatorState navigator, String routeName,
      Object arguments) async {
    FirebaseUser user = await _auth.getUser;
    print('Guard: ');
    print('${user.uid}');
    return user != null;
  }
}
