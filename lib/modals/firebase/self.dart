import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/game/hand.dart';
import 'package:coup/modals/game/isk.dart';
import 'package:flutter/foundation.dart';

class SelfPlayer extends ChangeNotifier {
  String uid;
  Hand hand = Hand();
  Isk isk = Isk(0);

// final task = task();

  static final SelfPlayer _self = SelfPlayer._internal();
  SelfPlayer._internal();


  factory SelfPlayer() {
    return _self;
  }

  SelfPlayer.fromFirestore(DocumentSnapshot snap) {
        List<String> handList = List.castFrom(snap.data['hand']);
    this.isk = Isk(snap.data['isk']);
    this.hand = Hand.fromList(handList);
    this.uid = snap.documentID;
  }

  
}
