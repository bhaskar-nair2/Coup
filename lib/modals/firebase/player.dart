import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/game/action.dart';
import 'package:flutter/foundation.dart';

class Player extends ChangeNotifier {
  String playerId;
  String name = '';
  String nick = '';
  int cards = 0;
  int isk = 0;
  bool active = false;

  Player();

  // Stream<Player> get playerData =

  Player.fromRef(DocumentReference ref) {
    this.playerId = ref.documentID;
  }

  Player.fromFirestore(DocumentSnapshot snap) {
    this.nick = snap.data["nick"];
    this.cards = snap.data["hand"]?.length ?? 0;
    this.isk = snap.data["isk"];
  }
}

class PlayerAction {
  Player player;
  CardAction action;
}
