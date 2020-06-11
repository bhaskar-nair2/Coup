import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/firebase/player.dart';
import 'package:coup/modals/firebase/turn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class GameTable extends ChangeNotifier {
  String tableId;
  int occupied = 0; // Exact number, index from 1
  Turn turn = Turn();
  List<Player> players = [];

  // singleton
  static final GameTable _table = GameTable._internal();
  GameTable._internal();

  factory GameTable() {
    return _table;
  }

  GameTable.fromFirestore(DocumentSnapshot snap) {
    List<Player> _players = (snap.data['players'] as List ?? [])
        .map((p) => Player.fromRef(p))
        .toList();
    this.tableId = snap.documentID;
    this.turn.turnId = (snap.data["turn"] as DocumentReference).documentID;
    this.players = _players;
  }
}

enum GameState { play, counter, block, challenge }
