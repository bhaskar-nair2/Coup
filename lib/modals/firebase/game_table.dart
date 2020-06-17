import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum GameState { waiting, loading, play, counter, block, challenge }

class GameTable extends ChangeNotifier {
  String tableId;
  int occupied = 0; // Exact number, index from 1
  String turnId = '';
  List<Player> players = [];
  GameState state = GameState.loading;
  String owner;

  GameTable();

  GameTable.fromFirestore(DocumentSnapshot snap) {
    List<Player> _players = (snap.data['players'] as List ?? [])
        .map((p) => Player.fromRef(p))
        .toList();
    this.tableId = snap.documentID;
    this.turnId = (snap.data["turn"] as DocumentReference).documentID;
    this.players = _players;
    this.owner = (snap.data['owner'] as DocumentReference).documentID;
    this.state = stateFromStr((snap.data['state'] as String));
    IDManager.tableId = snap.documentID;
  }

  static GameState stateFromStr(String str) {
    GameState state = GameState.values.firstWhere(
        (e) => e.toString() == 'GameState.' + str.toString().toLowerCase());

    return state;
  }
}
