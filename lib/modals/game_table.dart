import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/player.dart';
import 'package:coup/modals/turn.dart';
import 'package:flutter/material.dart';

class GameTable extends ChangeNotifier {
  int occupied = 0;
  List<Player> players;
  List<Turn> turn;

  GameTable({this.occupied, players, turn}) {
    this.players =
        List.generate(this.occupied, (index) => Player.fromMap(players[index]));
  }

  factory GameTable.fromMap(DocumentSnapshot doc) {
    Map data = doc.data;
    return GameTable(
      occupied: doc["occupied"],
      players: doc['players'],
      turn: data["turn"],
    );
  }
}
