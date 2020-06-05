import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/chance.dart';
import 'package:coup/modals/game_table.dart';
import 'package:coup/modals/hand.dart';
import 'package:coup/modals/isk.dart';
import 'package:flutter/foundation.dart';

class SelfPlayer extends ChangeNotifier {
  Hand hand = Hand();
  Isk isk = Isk(0);
  Chance chance = Chance();
  String uid;
  bool playing; // TODO:
  bool spectator; // TODO:

  final GameTable table = GameTable();
// final task = task();

  static final SelfPlayer _self = SelfPlayer._internal();
  SelfPlayer._internal();

  factory SelfPlayer() {
    return _self;
  }

  factory SelfPlayer.fromFirestore(DocumentSnapshot snap) {
    List<String> handList = List.castFrom(snap.data['hand']);
    _self.isk = Isk(snap.data['isk']);
    _self.hand = Hand.fromList(handList);
    _self.uid = snap.documentID;
    return _self;
  }

  
}
