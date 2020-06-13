import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/game/hand.dart';
import 'package:coup/modals/game/isk.dart';
import 'package:flutter/foundation.dart';

class SelfPlayer extends ChangeNotifier {
  String _uid;
  Hand hand = Hand();
  Isk isk = Isk(0);

  SelfPlayer();

  SelfPlayer.fromFirestore(DocumentSnapshot snap) {
    List<String> handList = List.castFrom(snap.data['hand'] as List ?? []);
    this._uid = snap.documentID;
    this.isk = Isk(snap.data['isk']);
    this.hand = Hand.fromList(handList);
    IDManager.selfId = snap.documentID;
  }
}
