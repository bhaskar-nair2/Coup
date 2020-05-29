import 'package:coup/modals/self.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<SelfPlayer> get user async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null)
      return createSelfUser(user);
    else
      return null;
  }

  Stream<FirebaseUser> get authState => _auth.onAuthStateChanged;

  Future<SelfPlayer> googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      SelfPlayer player = createSelfUser(user);
      return player;
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  Future<SelfPlayer> anonLogin() async {
    FirebaseUser user = (await _auth.signInAnonymously()).user;
    createSelfUser(user);
    SelfPlayer player = createSelfUser(user);
    return player;
  }

  SelfPlayer createSelfUser(FirebaseUser user) {
    // Sets the singleton to this user
    print(user);
    SelfPlayer _player = SelfPlayer.fromFirebase(user);
    return _player;
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
