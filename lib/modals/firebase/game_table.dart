import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/firebase/idmanager.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

enum TableState { loading, waiting, play, score }

class GameTable extends ChangeNotifier {
  String tableId;
  int occupied = 0; // Exact number, index from 1
  String turnId = '';
  List<Player> players = [];
  String owner;
  String pin;
  TableState state;
  bool inProgress;

  GameTable();

  GameTable.fromFirestore(DocumentSnapshot snap) {
    List<Player> _players = (snap.data['players'] as List ?? [])
        .map((p) => Player.fromRef(p))
        .toList();
    this.players = _players;
    this.owner = (snap.data['owner'] as DocumentReference).documentID;
    this.state = stateFromStr((snap.data['state'] as String));
    this.inProgress = snap['inProgress'];

    if (this.inProgress == false) {
      this.pin = snap.data['pin'];
      IDManager.tableId = snap.documentID;
      this.turnId = (snap.data["turn"] as DocumentReference).documentID;
    }
  }
  static TableState stateFromStr(String str) {
    TableState state = TableState.values.firstWhere(
        (e) => e.toString() == 'TableState.' + str.toString().toLowerCase());
    return state;
  }
}
