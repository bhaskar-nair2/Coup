import 'package:coup/modals/self.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;

  Future<FirebaseUser> get user => _auth.currentUser();
  Stream<FirebaseUser> get authState => _auth.onAuthStateChanged;

  void googleSignIn() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  void anonLogin() async {
    try {
      await _auth.signInAnonymously();
    } catch (error) {
      print("$error");
    }
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
