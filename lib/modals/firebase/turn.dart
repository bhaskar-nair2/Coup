import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/firebase/chance.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/game/action.dart';
import 'package:coup/repos/turnReader.dart';
import 'package:flutter/foundation.dart';

class Turn extends ChangeNotifier {
  String id = ''; // id of turn from table
  TurnAction action;
  var block;
  var challenge;
  Chance chance = Chance();
  String pin;

  Turn();

  set turnId(String turnId) {
    this.id = turnId;
    IDManager.turnId = turnId;
  }

  Turn.fromFirestore(DocumentSnapshot snap) {
    this.id = snap.documentID;
    this.action = TurnAction(snap["action"] as Map) ?? null;
    this.block = snap["block"] ?? null;
    this.challenge = snap["challenge"] ?? null;
    this.chance.setActive((snap['active'] as DocumentReference).documentID);
    // this.pin = snap['pin'];
    TurnReader.readTurn(this);
    IDManager.turnId = snap.documentID;
  }
}

class TurnAction {
  var player;
  ActionName action;

  TurnAction(data) {
    this.player = data['player'];
    this.action = CardAction.actionFromStr(data['action']);
  }
}
