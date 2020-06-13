import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/game/hand.dart';
import 'package:coup/modals/game/isk.dart';
import 'package:flutter/foundation.dart';

class SelfPlayer extends ChangeNotifier {
  String _uid;
  Hand hand = Hand();
  Isk isk = Isk(0);

  String get uid => _self._uid;

  static final SelfPlayer _self = SelfPlayer._internal();
  SelfPlayer._internal();

  factory SelfPlayer() {
    return _self;
  }

  SelfPlayer.fromFirestore(DocumentSnapshot snap) {
    List<String> handList = List.castFrom(snap.data['hand'] as List ?? []);
    this.isk = Isk(snap.data['isk']);
    this.hand = Hand.fromList(handList);
    this._uid = snap.documentID;
    _self._uid = snap
        .documentID; // basically this is needed a lot, so use it in the singleton
  }
}
