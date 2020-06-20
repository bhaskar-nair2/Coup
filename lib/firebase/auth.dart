import 'package:coup/modals/firebase/idmanager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> get getUser => _auth.currentUser();
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  void googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var _authRes = await _auth.signInWithCredential(credential);
      IDManager.selfId = _authRes.user.uid;
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  anonLogin() async {
    var _authRes = await _auth.signInAnonymously();
    IDManager.selfId = _authRes.user.uid;
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
