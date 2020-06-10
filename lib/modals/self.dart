import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/game_table.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/isk.dart';
import 'package:flutter/foundation.dart';

class SelfPlayer extends ChangeNotifier {
  DocumentReference ref;
  Hand hand = Hand();
  Isk isk = Isk(0);
  String uid;

  final GameTable table = GameTable();
  static final FirestoreService _fs = FirestoreService();

// final task = task();

  static final SelfPlayer _self = SelfPlayer._internal();
  SelfPlayer._internal();

  static startStream(String userId){
    _fs.selfStream(userId).listen((event) { });
  }

  factory SelfPlayer() {
    return _self;
  }

  factory SelfPlayer.fromFirestore(DocumentSnapshot snap) {
    List<String> handList = List.castFrom(snap.data['hand']);
    _self.ref = snap.reference;
    _self.isk = Isk(snap.data['isk']);
    _self.hand = Hand.fromList(handList);
    _self.uid = snap.documentID;
    return _self;
  }

  
}
