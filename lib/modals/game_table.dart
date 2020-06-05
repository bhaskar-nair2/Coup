import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/player.dart';
import 'package:coup/modals/self.dart';
import 'package:coup/modals/turn.dart';
import 'package:flutter/material.dart';

class GameTable extends ChangeNotifier {
  int occupied = 0; // Exact number, index from 1
  List<Player> players = [];
  List<Turn> turn;
  DocumentReference active; // ! change later
  static SelfPlayer self = SelfPlayer();

  static final GameTable _table = GameTable._internal();
  GameTable._internal();

  factory GameTable() {
    return _table;
  }

  factory GameTable.fromFirestore(DocumentSnapshot snap) {
    List<DocumentReference> _players = List.castFrom(snap.data['players']);

    _table.active = snap.data["active"];

    _table.players = List.generate(_players.length, (index) {
      Player player = Player(playerId: _players[index].documentID);
      return player;
    });

    return _table;
  }
}
