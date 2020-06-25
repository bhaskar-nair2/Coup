import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/firebase/chance.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/game/action.dart';
import 'package:coup/repos/turnReader.dart';
import 'package:flutter/foundation.dart';

enum GameState { waiting, loading, play, counter, block, challenge }

class Turn extends ChangeNotifier {
  String id = ''; // id of turn from table
  TurnAction action;
  var block;
  var challenge;
  GameState gameState = GameState.loading;
  Chance chance = Chance();
  String pin;

  Turn();

  set turnId(String turnId) {
    this.id = turnId;
    IDManager.turnId = turnId;
  }

  Turn.fromFirestore(DocumentSnapshot snap) {
    this.id = snap.documentID;
    this.action = TurnAction(snap.data["action"] as Map) ?? null;
    this.block = snap.data["block"] ?? null;
    this.challenge = snap.data["challenge"] ?? null;
    this.gameState = stateFromStr((snap.data['gameState'] as String));

    TurnReader.readTurn(this);
    this.setCurrActive(snap);

    if (IDManager.tableId == null) IDManager.turnId = snap.documentID;
  }

  setCurrActive(snap) {
    switch (this.gameState) {
      case GameState.play:
        this.chance.setActive((snap['active'] as DocumentReference).documentID);
        break;

      default:
        this.chance.active = false;
        break;
    }
  }

  static GameState stateFromStr(String str) {
    GameState state = GameState.values.firstWhere(
        (e) => e.toString() == 'GameState.' + str.toString().toLowerCase());
    return state;
  }
}

class TurnAction {
  var player;
  ActionName type;

  TurnAction(data) {
    if (data != null) {
      this.player = data['player'] ?? null;
      this.type = CardAction.actionFromStr(data['action']);
    }
  }
}
