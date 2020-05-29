import 'package:coup/modals/chance.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/isk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SelfPlayer extends ChangeNotifier {
  FirebaseUser user;
  static Isk isk;
  Chance chance;
  String uid;
  static Hand hand;

  static final SelfPlayer _self = SelfPlayer._internal();
  SelfPlayer._internal();

  factory SelfPlayer() {
    return _self;
  }

  factory SelfPlayer.fromFirebase(FirebaseUser user) {
    _self.user = user;
    _self.uid = user.uid;
    return _self;
  }

  setTableData({@required int iskVal, @required List<String> cards}) {
    isk = Isk(iskVal);
    hand = Hand(cards);
  }
}
