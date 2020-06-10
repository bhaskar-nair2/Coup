import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/firebase/firedb.dart';
import 'package:coup/modals/player.dart';
import 'package:coup/modals/turn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class GameTable extends ChangeNotifier {
  DocumentReference ref;
  String tableId;
  int occupied = 0; // Exact number, index from 1
  List<Player> players = [];
  GameState gameState; // soon
  String turnId;

  static final GameTable _table = GameTable._internal();
  static final FirestoreService _fs = FirestoreService();

  GameTable._internal();

  factory GameTable() {
    return _table;
  }

  static startStream(String tableId) {
    _fs.tableStream(tableId).listen((event) {});
  }

  GameTable.fromFirestore(DocumentSnapshot snap) {
    List<DocumentReference> _players = List.castFrom(snap.data['players']);

    _table.ref = snap.reference;
    _table.tableId = snap.documentID;
    if (_table.turnId == null) {
      _table.turnId = snap.data["turn"].documentID;
      Turn.startStrem(_table.turnId);
    }
    // move this to players bc
    _table.players = List.generate(_players.length, (index) {
      Player player = Player(playerId: _players[index].documentID);
      return player;
    });
    notifyListeners();
  }
}

enum GameState { play, counter, block, challenge }
