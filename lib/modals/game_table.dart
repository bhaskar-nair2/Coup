import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coup/modals/player.dart';
import 'package:coup/modals/self.dart';
import 'package:coup/modals/turn.dart';
import 'package:flutter/material.dart';

class GameTable extends ChangeNotifier {
  int occupied = 0; // Exact number, index from 1
  List<Player> players;
  List<Turn> turn;
  DocumentReference active;
  static SelfPlayer self = SelfPlayer();

  GameTable({this.occupied, List players, turn, DocumentReference active}) {
    this.active = active;
    this.players = List.generate(players.length, (index) {
      var playerData = players[index];
      bool isActive = playerData["player"] == active;

      var player = Player.fromFirebase(playerData,isActive);

      if (player.ref.documentID == self.uid) {
        // user data
        List<String> cards = List.castFrom(playerData["hand"]);
        self.setTableData(iskVal: player.isk, cards: cards);
      }
      return player;
    });
  }

  factory GameTable.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    return GameTable(
        occupied: data["occupied"],
        players: data['players'],
        turn: data["turn"],
        active: data["active"]);
  }
}
