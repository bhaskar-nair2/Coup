import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/player.dart';
import 'package:coup/modals/self.dart';
import 'package:coup/modals/turn.dart';
import 'package:flutter/material.dart';

class GameTable extends ChangeNotifier {
  int occupied = 0;
  List<Player> players;
  List<Turn> turn;
  static SelfPlayer self = SelfPlayer();

  GameTable({this.occupied, players, turn}) {
    this.players = List.generate(this.occupied, (index) {
      var playerData = players[index];
      var player = Player.fromMap(playerData);
      if (player.ref.documentID == self.uid) {
        List<String> cards = List.castFrom(playerData["hand"]);
        self.setTableData(iskVal: player.isk, cards: cards);
      }
      return player;
    });
  }

  factory GameTable.fromMap(DocumentSnapshot doc) {
    Map data = doc.data;
    return GameTable(
      occupied: data["occupied"],
      players: data['players'],
      turn: data["turn"],
    );
  }
}
